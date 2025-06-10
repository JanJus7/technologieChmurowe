const express = require('express');
const mysql = require('mysql2');
const app = express();
const port = 3001;

const conn = mysql.createConnection({
  host: 'db',
  user: 'user',
  password: 'pass',
  database: 'testdb'
});

app.get('/data', (req, res) => {
  conn.query('SELECT NOW() as now', (err, results) => {
    if (err) return res.send('Błąd bazy: ' + err.message);
    res.send('Czas z bazy: ' + results[0].now);
  });
});

app.listen(port, () => {
  console.log(`Backend działa na porcie ${port}`);
});
