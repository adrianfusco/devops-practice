from flask import Flask

app = Flask(__name__)

@app.route('/')
def helloExample():
    return 'Hello, World!'