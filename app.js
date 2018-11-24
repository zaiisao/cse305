const express = require('express')
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
var query = pgClient.query("SELECT id from movies where name = 'deadpool'", (err, res_user) => {
  /* etc, etc */
	//app.get('/', (req, res) => res.send(query))
	app.get('/', (req, res) => res.send(res_user))

	console.log(res_user);
});
//query.on("row", function(row,result) {
//	result.addRow(row);
//});


app.listen(port, () => console.log(`Example app listening on port ${port}!`))
