var express = require('express')//, movies = require('./moviequery.js').Request;
var app = express();
var mysql = require('mysql');

// Binding express app to port 3000

app.listen(3000,function(){
    console.log('Node server running @ http://localhost:3000')
});
app.use('/node_modules',  express.static(__dirname + '/node_modules'));

app.use('/style',  express.static(__dirname + '/style'));
app.get('/',function(req,res){
    res.sendFile('Movie.html',{'root': __dirname + '/templates'});
})

// 1st Create user in database
// 2nd Give permisions to the user
// 3rd enter the host and username and database
app.get('/request', function(req, res){
var con = mysql.createConnection({
  host: "localhost",
  user: "isaiah",
  password: "PASSword",
  database : 'md',
});

con.connect(function(err) {
  if (err) throw err;
  con.query("SELECT name FROM MOVIE", function (err, result) {
    if (err){
    	throw err;
    }
    else {
    	console.log(result);
    	res.send(result) //How to transfer this to app.js without it resulting in unidentified
	}
  });
  con.end();
});
});

