const express = require('express')
const path = require('path');
const app = express()
const port = 3000

var pg = require('pg')
var connectionString_CS = "postgres://postgres:amazingPGtest@localhost/CSE305MovieDB"
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
app.set('views', './views');
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
  //res.sendFile(path.join(__dirname + '/dummy.html'));
  res.sendFile(path.join(__dirname + '/index_results.html'));
});

app.post("/", function (req, res) {
	console.log(req.body.query);
	console.log(req.body.querycategory); //selection is by NAME of HTML object
	console.log(req.body.querytable); //selection is by NAME of HTML object
	console.log(req.body.querysearcher); //selection is by NAME of HTML object
	req.body.querycategory = "*"; //omitted user ability to control the category displayed, we assume user wants all info
	//FULL JOIN in postgresql = OUTER JOIN in other sql 
 if(req.body.querytable.localeCompare("movies")==0){
  var query = pgClient.query("WITH subquery_genre AS (SELECT mid, string_agg(genre, ', ') AS genre FROM genres g GROUP BY g.mid), "
  +"subquery_actor AS (SELECT actedin, string_agg(name, ', ') AS actors FROM actors a GROUP BY a.actedin), "
  +"subquery_director AS (SELECT produced, string_agg(name, ', ') AS directors FROM directors d GROUP BY d.produced), "
  +"subquery_producer AS (SELECT produced, string_agg(name, ', ') AS producers FROM producers p GROUP BY p.produced)"
  + " SELECT " 
  + req.body.querycategory + " FROM " + req.body.querytable + " FULL JOIN subquery_genre ON movies.id = subquery_genre.mid " +
  "FULL JOIN subquery_actor ON movies.id = subquery_actor.actedin " +
  "FULL JOIN subquery_director ON movies.id = subquery_director.produced " +
  "FULL JOIN subquery_producer ON movies.id = subquery_producer.produced" +
  " WHERE LOWER(" + req.body.querysearcher + 
  ") LIKE LOWER('%" + req.body.query +"%') ORDER BY 1", (err, res_user) => {
	console.log("RESULT OF SEARCH QUERY - MOVIES");
	console.log(res_user);
    app.get('/', (req, res) => res.send(res_user))
    //res.setHeader('Content-Type', 'application/json');
	
	//plan - use a function to get back to og search page but with results
    //res.send(JSON.stringify(res_user));
	//res.redirect('back');
    //res.render('index.html');
	res.render('results_movies', {testoutput: JSON.stringify(res_user.rows),data: res_user.rows})
	
	//res.render('index', { title: 'Hey', message: 'Hello there!' })
  });
 }else if (req.body.querytable.localeCompare("actors")==0){
  var query = pgClient.query("SELECT " + req.body.querycategory + " from " + req.body.querytable + " where LOWER(" + req.body.querysearcher + 
  ") LIKE LOWER('%" + req.body.query +"%')", (err, res_user) => {
	console.log("RESULT OF SEARCH QUERY - ACTORS");
	console.log(res_user);
    app.get('/', (req, res) => res.send(res_user))
    //res.setHeader('Content-Type', 'application/json');
	
	//plan - use a function to get back to og search page but with results
    //res.send(JSON.stringify(res_user));
	//res.redirect('back');
    //res.render('index.html');
	res.render('results_movies', {testoutput: JSON.stringify(res_user.rows),data: res_user.rows})
	
	//res.render('index', { title: 'Hey', message: 'Hello there!' })
  });
 }
 else{
  var query = pgClient.query("SELECT " + req.body.querycategory + " from " + req.body.querytable + " where LOWER(" + req.body.querysearcher + 
  ") LIKE LOWER('%" + req.body.query +"%')", (err, res_user) => {
	console.log("RESULT OF SEARCH QUERY");
	console.log(res_user);
    app.get('/', (req, res) => res.send(res_user))
    //res.setHeader('Content-Type', 'application/json');
	
	//plan - use a function to get back to og search page but with results
    //res.send(JSON.stringify(res_user));
	//res.redirect('back');
    //res.render('index.html');
	res.render('results_movies', {testoutput: JSON.stringify(res_user.rows),data: res_user.rows})
	
	//res.render('index', { title: 'Hey', message: 'Hello there!' })
  });
 }
});


app.listen(port, () => console.log(`Example app listening on port ${port}!`))
