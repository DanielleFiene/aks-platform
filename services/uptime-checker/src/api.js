const express = require('express');
const { pool } = require('./db');
const router = express.Router();

router.get('/status', async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT DISTINCT ON (endpoint)
        endpoint, status, latency, is_up, checked_at
      FROM checks
      ORDER BY endpoint, checked_at DESC
    `);
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.get('/history/:endpoint', async (req, res) => {
  try {
    const result = await pool.query(
      'SELECT * FROM checks WHERE endpoint = $1 ORDER BY checked_at DESC LIMIT 100',
      [decodeURIComponent(req.params.endpoint)]
    );
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.get('/healthz', (req, res) => res.json({ status: 'ok' }));

module.exports = router;
