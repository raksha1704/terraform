const express=require('express')
const app=express()

app.get('/',(req,res)=>{
res.send("Express Frontend Container Running")
})

app.listen(3000)
