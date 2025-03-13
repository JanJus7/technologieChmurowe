const express = require('express');
const app = express();
const port = 8080;

app.get('/', (req, res) => {
  const currentDate = new Date();
  res.json({ date: currentDate.toISOString() });
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});