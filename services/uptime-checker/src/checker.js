const axios = require('axios');
const cron = require('node-cron');
const { pool } = require('./db');

const endpoints = JSON.parse(process.env.ENDPOINTS || '[]');

const checkEndpoint = async (url) => {
  const start = Date.now();
  try {
    const res = await axios.get(url, { timeout: 5000 });
    return { url, status: res.status, latency: Date.now() - start, isUp: true };
  } catch (err) {
    return { url, status: err.response?.status || 0, latency: Date.now() - start, isUp: false };
  }
};

const sendSlackAlert = async (url, status) => {
  if (!process.env.SLACK_WEBHOOK_URL) return;
  await axios.post(process.env.SLACK_WEBHOOK_URL, {
    text: `🔴 *DOWN* | ${url} | status: ${status}`
  });
};

const runChecks = async () => {
  for (const url of endpoints) {
    const result = await checkEndpoint(url);
    await pool.query(
      'INSERT INTO checks (endpoint, status, latency, is_up) VALUES ($1, $2, $3, $4)',
      [result.url, result.status, result.latency, result.isUp]
    );
    if (!result.isUp) await sendSlackAlert(result.url, result.status);
    console.log(`[${new Date().toISOString()}] ${result.isUp ? '✅' : '🔴'} ${result.url} — ${result.latency}ms`);
  }
};

const startScheduler = () => {
  cron.schedule('* * * * *', runChecks);
  console.log('Scheduler gestart — checks elke 60 seconden');
};

module.exports = { startScheduler, runChecks };
