const express = require('express')
const path = require('path');
const app = express()
const port = 3000

var pg = require('pg')
var connectionString_CS = "postgres://postgres:tenal@localhost/CSE305MovieDB"
var pgClient = new pg.Client({
  host: 'localhost',
  port: 5423,
  user: 'postgres',
  password: 'tenal',
  connectionString: connectionString_CS,
});
pgClient.connect((err) => {
  if (err) {
    console.error('connection error', err.stack)
  } else {
    console.log('connected')
  }
});

var bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({
    extended: true
}));
app.use(bodyParser.json());

app.get('/', function(req, res) {
  res.sendFile(path.join(__dirname + '/index.html'));
});

app.post("/", function (req, res) {
  var query = pgClient.query("SELECT id from movies where name = '" + req.body.query +"'", (err, res_user) => {
    app.get('/', (req, res) => res.send(res_user))
    console.log(res_user);
  });
});

app.listen(port, () => console.log(`Example app listening on port ${port}!`))
