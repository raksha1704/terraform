#!/bin/bash

sudo apt update

# install python
sudo apt install python3-pip -y
pip3 install flask

# install nodejs
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install nodejs -y

# create flask backend
cat <<EOF > app.py
from flask import Flask
app = Flask(__name__)

@app.route("/")
def hello():
 return "Flask Backend Running"

app.run(host="0.0.0.0",port=5000)
EOF

nohup python3 app.py &

# create express frontend
cat <<EOF > server.js
const express=require('express')
const app=express()

app.get('/',(req,res)=>{
res.send("Express Frontend Running")
})

app.listen(3000)
EOF

npm init -y
npm install express

nohup node server.js &