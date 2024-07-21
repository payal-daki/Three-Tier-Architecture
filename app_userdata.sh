#!/bin/bash

# Update the package list and install necessary packages
apt-get update
apt-get install -y python3 python3-pip

# Install application dependencies
pip3 install flask  # Example for a Python Flask application

# Create a simple application
echo "from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello from the Application Tier!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)" > /home/ubuntu/app.py

# Run the application
nohup python3 /home/ubuntu/app.py &
