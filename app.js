const express = require('express')
const app = express()
const https = require('https')
const fs = require('fs')
var cors = require('cors')

app.use(cors())
app.use(express.json());

var cp = require('child_process');

app.get('/webhook',(req,res)=>{
        res.json({success:true,get:true});
});

app.post('/webhook',(req,res)=>{

   // console.log(req.body);
    var reponame = req.body.repository.name;
    var repofullname = req.body.repository.full_name;

    var child = cp.spawn('./runner.sh',[reponame,repofullname])

    res.json({success:true});

});

var privateKey  = fs.readFileSync('./ssl/irscloud_id.key', 'utf8');
var certificate = fs.readFileSync('./ssl/irscloud_id.crt', 'utf8');
var credentials = {key: privateKey, cert: certificate};

var httpsServer = https.createServer(credentials, app);
httpsServer.listen(9090);