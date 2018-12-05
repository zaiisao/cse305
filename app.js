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
	//if (req.body.querytable.localeCompare("movies")==0){
		//DATE NEEDS ITS OWN SPECIAL HANDLER
		//NUMBERS (ID, RATING) NEED THEIR OWN SPECIAL HANDLER
		//DEFAULT: STRING FIELDS(NAME, AGERATING, GENRE)

		//console.log(searchInputType[req.body.querytable][req.body.querysearcher](req.body.query))
		//console.log(sortType.movies[req.body.sorttype]);
		//console.log(req.body.genre);
		
		//for 'include all' filters, could use if statements to 'build' the string, and always append the order by at the end

		var queryStrings = {
			movies: "WITH subquery_genre AS (SELECT mid, string_agg(genre, ', ') AS genre FROM genres g GROUP BY g.mid), "
				+"subquery_actor AS (SELECT actedin, string_agg(name, ', ') AS actors FROM actors a GROUP BY a.actedin), "
				+"subquery_director AS (SELECT produced, string_agg(name, ', ') AS directors FROM directors d GROUP BY d.produced), "
				+"subquery_producer AS (SELECT produced, string_agg(name, ', ') AS producers FROM producers p GROUP BY p.produced)"
				+ " SELECT " 
				+ /*req.body.querycategory*/ "*" + " FROM " + /*req.body.querytable*/ "movies" + " FULL JOIN subquery_genre ON movies.id = subquery_genre.mid " +
				"FULL JOIN subquery_actor ON movies.id = subquery_actor.actedin " +
				"FULL JOIN subquery_director ON movies.id = subquery_director.produced " +
				"FULL JOIN subquery_producer ON movies.id = subquery_producer.produced" +
				" WHERE LOWER(name) LIKE LOWER('%" + req.body.query +"%')",
			actors: "WITH subquery_awards AS (SELECT pid, string_agg(award, ', ') AS awards_given FROM awards ar GROUP BY ar.pid), " +
			"subquery_movies AS (SELECT id, name AS movie_name FROM movies) " +
			"SELECT DISTINCT actors.id, actors.name, actors.age, subquery_awards.awards_given, string_agg(subquery_movies.movie_name, ', ') AS movies_actedin " + 
			"FROM actors " +
			"LEFT JOIN subquery_awards ON actors.id = subquery_awards.pid " +
			"LEFT JOIN subquery_movies ON actors.actedin = subquery_movies.id " +
			"WHERE LOWER(" + req.body.querysearcher + 
				") LIKE LOWER('%" + req.body.query +"%') "+
			"GROUP BY actors.id, actors.name, actors.age, subquery_awards.awards_given",
			directors: "WITH subquery_awards AS (SELECT pid, string_agg(award, ', ') AS awards_given FROM awards ar GROUP BY ar.pid), " +
			"subquery_movies AS (SELECT id, name AS movie_name FROM movies) " +
			"SELECT DISTINCT directors.id, directors.name, directors.age, subquery_awards.awards_given, string_agg(subquery_movies.movie_name, ', ') AS movies_producedfor " + 
			"FROM directors " +
			"LEFT JOIN subquery_awards ON directors.id = subquery_awards.pid " +
			"LEFT JOIN subquery_movies ON directors.produced = subquery_movies.id " +
			"WHERE LOWER(" + req.body.querysearcher + 
				") LIKE LOWER('%" + req.body.query +"%') "+
			"GROUP BY directors.id, directors.name, directors.age, subquery_awards.awards_given",
			producers: "WITH subquery_awards AS (SELECT pid, string_agg(award, ', ') AS awards_given FROM awards ar GROUP BY ar.pid), " +
			"subquery_movies AS (SELECT id, name AS movie_name FROM movies) " +
			"SELECT DISTINCT producers.id, producers.name, producers.age, subquery_awards.awards_given, string_agg(subquery_movies.movie_name, ', ') AS movies_producedfor " + 
			"FROM producers " +
			"LEFT JOIN subquery_awards ON producers.id = subquery_awards.pid " +
			"LEFT JOIN subquery_movies ON producers.produced = subquery_movies.id " +
			"WHERE LOWER(" + req.body.querysearcher + 
				") LIKE LOWER('%" + req.body.query +"%') "+
			"GROUP BY producers.id, producers.name, producers.age, subquery_awards.awards_given",
			awards: "WITH subquery_people AS (SELECT DISTINCT * FROM people) " +
			"SELECT " + req.body.querycategory + " from " + req.body.querytable + 
			" INNER JOIN subquery_people ON awards.pid = subquery_people.id" +
			" where LOWER(" + req.body.querysearcher + 
				") LIKE LOWER('%" + req.body.query +"%')",
			distributedby: "SELECT " + req.body.querycategory + " from " + req.body.querytable + " where LOWER(" + req.body.querysearcher + 
				") LIKE LOWER('%" + req.body.query +"%')"


		}

		queryCmd = queryStrings[req.body.querytable];
		
		if (req.body.querytable.localeCompare("movies")==0) {
			if(req.body.agerating.localeCompare("all")!=0){
				queryCmd = queryCmd.concat(" AND LOWER(agerating) LIKE LOWER('" + req.body.agerating + "')");
			}
			if(req.body.genre.localeCompare("all")!=0){
				queryCmd = queryCmd.concat(" AND LOWER(genre) LIKE LOWER('%" + req.body.genre + "%')");
			}
			queryCmd = queryCmd.concat(" ORDER BY " + sortType.movies[req.body.sorttype]);
		}

		console.log("queryTable: ", req.body.querytable)
		console.log("queryCmd: ", queryCmd)

		var query = pgClient.query(queryCmd, (err, res_user) => {
			console.log("RESULT OF SEARCH QUERY - " + req.body.querytable.toUpperCase());
			console.log(res_user);
			app.get('/', (req, res) => res.send(res_user))

			res.render('results', {
				searchtype: req.body.querytable,
				testoutput: JSON.stringify(res_user.rows),
				data: res_user.rows,
				userinput: req.body.query
			})
		});
	/*} else {//if (req.body.querytable.localeCompare("actors")==0) {
		var queryCmd = "SELECT " + req.body.querycategory + " from " + req.body.querytable + " where LOWER(" + req.body.querysearcher + 
			") LIKE LOWER('%" + req.body.query +"%')"

		var query = pgClient.query(queryCmd, (err, res_user) => {
			console.log("RESULT OF SEARCH QUERY - " + req.body.querytable.toUpperCase());
			console.log(res_user);
			app.get('/', (req, res) => res.send(res_user))

    		res.render('results', {
    			searchtype: req.body.querytable, 
    			testoutput: JSON.stringify(res_user.rows),
    			data: res_user.rows,
    			userinput: req.body.query
    		})
		});
	}*//* else {
		res.render('index_error')
	}*/
});


app.listen(port, () => console.log(`Example app listening on port ${port}!`))
