const { Pool } = require('pg');

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: process.env.NODE_ENV === 'production' ? { rejectUnauthorized: false } : false
});

const initDb = async () => {
  await pool.query(`
    CREATE TABLE IF NOT EXISTS checks (
      id         SERIAL PRIMARY KEY,
      endpoint   VARCHAR(255) NOT NULL,
      status     INTEGER,
      latency    INTEGER,
      is_up      BOOLEAN,
      checked_at TIMESTAMPTZ DEFAULT NOW()
    )
  `);
  console.log('Database initialisatie klaar');
};

module.exports = { pool, initDb };
