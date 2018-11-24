const express = require('express')
const app = express()
const port = 3000

var pg = require('pg')
var connectionString = "postgres://postgres:tenal@localhost/localhost:5432/CSE305MovieDB"
var pgClient = new pg.Client(connectionString);
pgClient.connect();
var query = pgClient.query("SELECT id from Movie where name = 'deadpool'");
//query.on("row", function(row,result) {
//	result.addRow(row);
	app.get('/', (req, res) => res.send(query))
//});


app.listen(port, () => console.log(`Example app listening on port ${port}!`))
