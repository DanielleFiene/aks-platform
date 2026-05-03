require('dotenv').config();
const express = require('express');
const { initDb } = require('./db');
const { startScheduler } = require('./checker');
const api = require('./api');

const app = express();
app.use(express.json());
app.use('/api', api);

const start = async () => {
  await initDb();
  startScheduler();
  app.listen(3000, () => console.log('Uptime checker draait op :3000'));
};

start().catch(console.error);
