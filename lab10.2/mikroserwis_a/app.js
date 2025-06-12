const express = require('express');
const axios = require('axios');

const app = express();
const PORT = 3000;
const B_URL = process.env.B_URL || 'http://localhost:3001';

app.get('/proxy', async (req, res) => {
  try {
    const response = await axios.get(`${B_URL}/api`);
    res.send(`A -> B: ${response.data}`);
  } catch (error) {
    res.status(500).send('Błąd przy komunikacji z mikroserwisem B');
  }
});

app.listen(PORT, () => {
  console.log(`Mikroserwis A nasłuchuje na porcie ${PORT}`);
});
