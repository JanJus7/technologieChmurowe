const express = require('express');
const axios = require('axios');
const app = express();
const port = 3000;

app.get('/proxy', async (req, res) => {
  try {
    const response = await axios.get('http://mikroserwis-b-service:3000/data');
    res.json({ fromB: response.data });
  } catch (err) {
    res.status(500).send('Failed to contact mikroserwis_b');
  }
});

app.listen(port, () => {
  console.log(`mikroserwis_a running on port ${port}`);
});
