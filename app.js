const express = require('express')
const app = express()
var cors = require('cors')

app.use(cors())
app.use(express.json())

var cp = require('child_process')

app.get('/webhook', (req, res) => {
  res.json({ success: true, get: true })
})

app.post('/webhook', (req, res) => {
  // console.log(req.body);
  var reponame = req.body.repository.name
  var repofullname = req.body.repository.full_name
  const branch = req.body.ref.split('/').slice(-1)[0]
  console.log('Received webhook for repository: ' + reponame + ' on branch: ' + branch)

  var child = cp.spawn('./runner.sh', [reponame, repofullname, branch])
  child.stdout.on('data', function (data) {
    var dt = String(data).trim()
    if (dt != '') {
      console.log('Log:' + dt)
    }
  })
  child.stderr.on('data', function (data) {
    var dt = String(data).trim()
    if (dt != '') {
      console.log('Error:' + dt)
    }
  })
  res.json({ success: true })
})

app.listen(3000, () => {
  console.log('Server is running on port 3000')
})