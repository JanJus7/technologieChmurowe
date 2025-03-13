const express = require('express');
const mongoose = require('mongoose');
const app = express();
const port = 8080;

mongoose.connect('mongodb://mongo:27017/mydatabase', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

const ItemSchema = new mongoose.Schema({
  name: String,
});

const Item = mongoose.model('Item', ItemSchema);

Item.findOne({ name: 'example' })
  .then((item) => {
    if (!item) {
      Item.create({ name: 'example' });
    }
  });

app.get('/', async (req, res) => {
  const items = await Item.find();
  res.json(items);
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});