from flask import Flask, jsonify
from pymongo import MongoClient

app = Flask(__name__)

client = MongoClient("mongodb://db:27017/")
db = client["test"]
users_collection = db["users"]

@app.route('/')
def index():
    return "Hello, Flask!"

@app.route('/users', methods=['GET'])
def print_users():
    users = list(users_collection.find({}, {"_id": 0}))
    return jsonify(users)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
