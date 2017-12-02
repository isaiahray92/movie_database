
var express = require("express");
var app = express();
var router = express.Router();
var path = __dirname + "/templates";
var mysql = require("mysql");


router.use(function(req,res,next){
  console.log("/" + req.method);
  next();
});

router.get("/", function(req,res){
  res.sendFile(path + "/Movie.html");
});
router.get("/review", function(req,res){
  res.sendFile(path + "/review.html");
});
router.get("/ticket", function(req,res){
  res.sendFile(path + "/ticket.html");
});
router.get("/movieticket", function(req,res){
  res.sendFile(path + "/movieticket.html");
});
router.get("/freshpotatoes", function(req,res){
  res.sendFile(path + "/freshpotatoes.png");
});

app.use("/", router);
app.use('/node_modules',  express.static(__dirname + '/node_modules'));
app.use('/style',  express.static(__dirname + '/style'));


app.listen(3000,function(){
    console.log('Node server running @ http://localhost:3000')
});

/*router.get('/request', function(req, res){
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
});*/

router.get('/postReview', function(req, res){
  var test = req.query;
  console.log(req.query);
  console.log('I made it');
  var con = mysql.createConnection({
    host: "localhost",
    user: "isaiah",
    password: "PASSword",
    database : 'md',
});

con.connect(function(err) {
  if (err) throw err;
    //quer = "INSERT * FROM "+ req.query.type +" WHERE NAME = \"" + req.query.name + "\""
  con.query("INSERT INTO REVIEW (reviewer_id, movie_id, description, rating) VALUES ( 2, (SELECT movie_id FROM MOVIE WHERE MOVIE.name = \""+ req.query.movie +"\"), \'"+ req.query.review +"\', "+ req.query.rating +") ",  function (err, result) {
    if (err){
      throw err;
  }
    else {
      console.log(result);
      res.send("Success"); //How to transfer this to app.js without it resulting in unidentified
}
});
con.end();

});
});


  router.get('/generalRequest', function(req, res){
  var con = mysql.createConnection({
    host: "localhost",
    user: "isaiah",
    password: "PASSword",
    database : 'md',
  });

  con.connect(function(err) {
    if (err) throw err;
    var quer = [];
    if (req.query.type == "movie"){
      quer.push("SELECT * FROM MOVIE WHERE NAME = \"" + req.query.name + "\"");
      quer.push("SELECT fname, lname FROM ACTOR WHERE act_id IN (SELECT act_id FROM MOVIE_ACT WHERE movie_id = (SELECT movie_id FROM MOVIE WHERE name = \""+ req.query.name +"\"));");
      quer.push("SELECT avg(rating) FROM REVIEW WHERE movie_id = (SELECT movie_id FROM MOVIE WHERE name = \'" + req.query.name + "\');");
      quer.push("SELECT fname, lname FROM DIRECTOR WHERE director_id = (SELECT director_id FROM MOVIE_DIRECTORS WHERE movie_id = (SELECT movie_id FROM MOVIE WHERE NAME =\'" + req.query.name + "\'));");
      quer.push("SELECT description, rating FROM REVIEW WHERE movie_id = (SELECT movie_id FROM MOVIE WHERE name = \'" + req.query.name + "\');");
    }
    else{
      var fname = req.query.name.split(" ")[0];
      var lname = req.query.name.split(" ")[1];
      var type = req.query.type;
      type = type.toUpperCase()
      quer.push("SELECT * FROM "+ type +" WHERE FNAME = \"" + fname + "\" AND LNAME = \"" + lname + "\";");
      if (type == "DIRECTOR"){
        quer.push("SELECT name FROM MOVIE WHERE movie_id IN (SELECT movie_id FROM MOVIE_DIRECTORS WHERE director_id = (SELECT director_id FROM DIRECTOR WHERE FNAME = \'" + fname + "\' AND LNAME = \'" + lname + "\'));");
      }
      else{
        quer.push("SELECT name FROM MOVIE WHERE movie_id IN (SELECT movie_id FROM MOVIE_ACT WHERE act_id = (SELECT act_id FROM ACTOR WHERE FNAME = \'" + fname + "\' AND LNAME = \'" + lname + "\'));");
      }
    }

    var prev = [];
    for (i = 0; i < quer.length; i++){
    con.query(quer[i], function (err, result) {
      if (err){
        throw err;
      }
      else {
        prev.push(result);
        console.log(prev);
    }
    });
  }
  console.log(prev);
    setTimeout(function(){ res.send(prev); }, 100);
    con.end();

});
});

router.get('/getMovies', function(req, res){
  var con = mysql.createConnection({
    host: "localhost",
    user: "isaiah",
    password: "PASSword",
    database : 'md',
});

con.connect(function(err) {
  if (err) throw err;
    //quer = "INSERT * FROM "+ req.query.type +" WHERE NAME = \"" + req.query.name + "\""
  con.query("SELECT name FROM MOVIE;",  function (err, result) {
    if (err){
      throw err;
  }
    else {
      console.log(result);
      res.send(result); //How to transfer this to app.js without it resulting in unidentified
}
});
con.end();

});
});

router.get('/getShowtimes', function(req, res){
console.log(req.query.movie)
  var con = mysql.createConnection({
    host: "localhost",
    user: "isaiah",
    password: "PASSword",
    database : 'md',
});

con.connect(function(err) {
  if (err) throw err;
    //quer = "INSERT * FROM "+ req.query.type +" WHERE NAME = \"" + req.query.name + "\""
  con.query("SELECT * FROM SHOW_TIME WHERE movie_id = (SELECT movie_id FROM MOVIE WHERE name = \""+ req.query.movie + "\");",  function (err, result) {
    if (err){
      throw err;
  }
    else {
      console.log(result);
      res.send(result); //How to transfer this to app.js without it resulting in unidentified
}
});
con.end();

});
});
