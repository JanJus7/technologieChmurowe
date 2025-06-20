const express = require("express");
const { MongoClient } = require("mongodb");

const app = express();
const PORT = 3000;
const user = process.env.MONGO_USER;
const pass = process.env.MONGO_PASSWORD;
const MONGO_URL = `mongodb://${user}:${pass}@mongo-service:27017/db?authSource=admin`;

const DB_NAME = "db";

let db;

MongoClient.connect(MONGO_URL)
  .then((client) => {
    db = client.db(DB_NAME);
    console.log("Połączono z MongoDB");
  })
  .catch((err) => console.error("Błąd połączenia z MongoDB:", err));

app.get("/api", async (req, res) => {
  try {
    if (!db) {
      return res
        .status(503)
        .send("Połączenie z bazą danych jeszcze nie gotowe");
    }

    const collection = db.collection("test");
    const data = await collection.find({}).toArray();

    if (data.length === 0) {
      await collection.insertOne({ message: "Hello from MongoDB!" });
      return res.send("Dodano wpis do MongoDB!");
    }

    res.send(`Z MongoDB: ${data[0].message}`);
  } catch (err) {
    console.error(err);
    res.status(500).send("Błąd operacji na bazie danych");
  }
});

app.listen(PORT, () => {
  console.log(`Mikroserwis B nasłuchuje na porcie ${PORT}`);
});
