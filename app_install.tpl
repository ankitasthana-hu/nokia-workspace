#!/bin/bash
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
ls -lrta
chmod 777 get-pip.py
python3 get-pip.py
pip3 install flask
export FLASK_APP=main.py
export FLASK_ENV=development
cat <<EOF >>main.py
from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "Hello, World!"
    
@app.route("/salvador")
def salvador():
    return "Hello, Salvador"
    
if __name__ == "__main__":
    app.run(host='0.0.0.0', debug=True, port=5000)
    #app.run(debug=True)
EOF

flask run --host=0.0.0.0 --port=5000
