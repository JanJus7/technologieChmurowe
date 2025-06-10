const express = require('express');
const mysql = require('mysql2');

const app = express();
const port = 3000;

const connection = mysql.createConnection({
  host: 'db',
  user: 'user',
  password: 'pass',
  database: 'testdb'
});

app.get('/', (req, res) => {
  connection.query('SELECT NOW() as now', (err, results) => {
    if (err) {
      return res.send('Błąd połączenia z bazą: ' + err.message);
    }
    res.send('Połączono z bazą danych! Data i czas z MySQL: ' + results[0].now);
  });
});

app.listen(port, () => {
  console.log(`Serwer działa na http://localhost:${port}`);
});
