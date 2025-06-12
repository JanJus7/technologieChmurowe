const express = require('express');
const app = express();
const port = 3000;

app.get('/data', (req, res) => {
  res.json({ message: "Hello from mikroserwis_b!" });
});

app.listen(port, () => {
  console.log(`mikroserwis_b running on port ${port}`);
});
