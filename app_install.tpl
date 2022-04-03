#!/bin/bash
sudo su -
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
ls -lrta
chmod 777 get-pip.py
python3 get-pip.py
pip3 install flask
export FLASK_APP=main.py
export FLASK_ENV=development
flask run --host=0.0.0.0 --port=5000
