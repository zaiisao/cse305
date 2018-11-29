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
  password: 'amazingPGtest',
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
//var engines = require('consolidate');
app.set('views', './');
//app.set('views', __dirname + '/');
app.engine('html', require('ejs').renderFile);
//app.engine('html', engines.mustache);
app.set('view engine', 'html');

app.use(express.static(path.join(__dirname, '/')));

app.set('view options', {
  layout: true
});

app.use(bodyParser.urlencoded({
    extended: true
}));
app.use(bodyParser.json());


app.get('/', function(req, res) {
  res.sendFile(path.join(__dirname + '/index.html'));
});

app.post("/", function (req, res) {
	console.log(req.body.query);
	console.log(req.body.querycategory); //selection is by NAME of HTML object
  var query = pgClient.query("SELECT " + req.body.querycategory + " from movies where name = '" + req.body.query +"'", (err, res_user) => {
	console.log("RESULT OF SEARCH QUERY");
	console.log(res_user);
    app.get('/', (req, res) => res.send(res_user))
    //res.setHeader('Content-Type', 'application/json');
	
	//plan - use a function to get back to og search page but with results
    //res.send(JSON.stringify(res_user));
	//res.redirect('back');
    //res.render('index.html');
	res.render('index', {name: JSON.stringify(res_user),data: res_user})
	
	//res.render('index', { title: 'Hey', message: 'Hello there!' })
  });
});


app.listen(port, () => console.log(`Example app listening on port ${port}!`))
