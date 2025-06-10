import os
from flask import Flask

app = Flask(__name__)

PORT = int(os.environ.get('PORT', 8000))

@app.route('/')
def hello_world():
    python_version = os.environ.get('PYTHON_VER', 'Unknown')
    return f"Hello from Flask! Running on Python version: {python_version}."

@app.route('/health')
def health_check():
    return "OK", 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=PORT)