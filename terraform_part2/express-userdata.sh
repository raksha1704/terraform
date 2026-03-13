#!/bin/bash

sudo apt update

curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install nodejs -y

mkdir expressapp
cd expressapp

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
