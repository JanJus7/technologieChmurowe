const express = require('express');
const app = express();
const port = 3000;

app.get('/', async (req, res) => {
  try {
    const response = await fetch('http://backend:3001/data');
    const data = await response.text();
    res.send('Frontend działa. Dane z backendu: ' + data);
  } catch (err) {
    res.send('Błąd połączenia z backendem: ' + err.message);
  }
});

app.listen(port, () => {
  console.log(`Frontend działa na http://localhost:${port}`);
});
