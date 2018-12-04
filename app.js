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

const searchInputType = {
	actors: {
		name: function(prop) { return prop; },
		id: function(prop) { return Number(prop); },
		age: function(prop) { return Number(prop); },
		actedin: function(prop) { return prop; }
	},
	movies: {
		name: function(prop) { return prop; },
		id: function(prop) { return Number(prop); },
		date: function(prop) { return prop; },
		rating: function(prop) { return Number(prop); },
		agerating: function(prop) { return prop; },
		rating: function(prop) { return prop; }
	}
};

const sortType = {
	movies: {
		oldtonew: "movies.releasedate ASC",
		newtoold: "movies.releasedate DESC",
		lowest: "movies.rating ASC",
		highest: "movies.rating DESC",
		alphabetical: "movies.name ASC",
		ralphabetical: "movies.name DESC",
	}
}

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
	if (req.body.querytable.localeCompare("movies")==0){
		//DATE NEEDS ITS OWN SPECIAL HANDLER
		//NUMBERS (ID, RATING) NEED THEIR OWN SPECIAL HANDLER
		//DEFAULT: STRING FIELDS(NAME, AGERATING, GENRE)

		//console.log(searchInputType[req.body.querytable][req.body.querysearcher](req.body.query))
		console.log(sortType.movies[req.body.sorttype]);
		console.log(req.body.genre);
		var queryCmd = "WITH subquery_genre AS (SELECT mid, string_agg(genre, ', ') AS genre FROM genres g GROUP BY g.mid), "
			+"subquery_actor AS (SELECT actedin, string_agg(name, ', ') AS actors FROM actors a GROUP BY a.actedin), "
			+"subquery_director AS (SELECT produced, string_agg(name, ', ') AS directors FROM directors d GROUP BY d.produced), "
			+"subquery_producer AS (SELECT produced, string_agg(name, ', ') AS producers FROM producers p GROUP BY p.produced)"
			+ " SELECT " 
			+ /*req.body.querycategory*/ "*" + " FROM " + /*req.body.querytable*/ "movies" + " FULL JOIN subquery_genre ON movies.id = subquery_genre.mid " +
			"FULL JOIN subquery_actor ON movies.id = subquery_actor.actedin " +
			"FULL JOIN subquery_director ON movies.id = subquery_director.produced " +
			"FULL JOIN subquery_producer ON movies.id = subquery_producer.produced" +
			" WHERE LOWER(name) LIKE LOWER('%" + req.body.query +"%') "+ 
			"AND LOWER(agerating) LIKE LOWER('" + req.body.agerating + "') "   
			+ "AND LOWER(genre) LIKE LOWER('%" + req.body.genre + "%') " 
			+ "ORDER BY " + sortType.movies[req.body.sorttype];
		//for 'include all' filters, could use if statements to 'build' the string, and always append the order by at the end

		var query = pgClient.query(queryCmd, (err, res_user) => {
			console.log("RESULT OF SEARCH QUERY - MOVIES");
			console.log(res_user);
			app.get('/', (req, res) => res.send(res_user))
			//res.setHeader('Content-Type', 'application/json');
		
			//plan - use a function to get back to og search page but with results
			//res.send(JSON.stringify(res_user));
			//res.redirect('back');
			//res.render('index.html');
			res.render('results_movies', {testoutput: JSON.stringify(res_user.rows),data: res_user.rows,userinput: req.body.query})
		
			//res.render('index', { title: 'Hey', message: 'Hello there!' })
		});
	} else if (req.body.querytable.localeCompare("actors")==0) {
		var queryCmd = "SELECT " + req.body.querycategory + " from " + req.body.querytable + " where LOWER(" + req.body.querysearcher + 
			") LIKE LOWER('%" + req.body.query +"%')"

		var query = pgClient.query(queryCmd, (err, res_user) => {
			console.log("RESULT OF SEARCH QUERY - ACTORS");
			console.log(res_user);
			app.get('/', (req, res) => res.send(res_user))
		    //res.setHeader('Content-Type', 'application/json');

			//plan - use a function to get back to og search page but with results
		    //res.send(JSON.stringify(res_user));
			//res.redirect('back');
		    //res.render('index.html');
    		res.render('results_movies', {testoutput: JSON.stringify(res_user.rows),data: res_user.rows,userinput: req.body.query})
			//res.render('index', { title: 'Hey', message: 'Hello there!' })
		});
	}
	else {
		res.render('index_error')
	}
});


app.listen(port, () => console.log(`Example app listening on port ${port}!`))
