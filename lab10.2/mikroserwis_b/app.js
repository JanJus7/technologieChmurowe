const express = require('express');
const { MongoClient } = require('mongodb');

const app = express();
const PORT = 3000;
const MONGO_URL = process.env.MONGO_URL || 'mongodb://localhost:27017';
const DB_NAME = 'db';

let db;

MongoClient.connect(MONGO_URL, { useUnifiedTopology: true })
  .then(client => {
    db = client.db(DB_NAME);
    console.log('Połączono z MongoDB');
  })
  .catch(err => console.error('Błąd połączenia z MongoDB:', err));

app.get('/api', async (req, res) => {
  try {
    const collection = db.collection('test');
    const data = await collection.find({}).toArray();

    if (data.length === 0) {
      await collection.insertOne({ message: 'Hello from MongoDB!' });
      return res.send('Dodano wpis do MongoDB!');
    }

    res.send(`Z MongoDB: ${data[0].message}`);
  } catch (err) {
    res.status(500).send('Błąd operacji na bazie danych');
  }
});

app.listen(PORT, () => {
  console.log(`Mikroserwis B nasłuchuje na porcie ${PORT}`);
});
