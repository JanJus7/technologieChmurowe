from flask import Flask, jsonify
# from pymongo import MongoClient

app = Flask(__name__)

@app.route('/')
def index():
    return "Hello, Flask!"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
