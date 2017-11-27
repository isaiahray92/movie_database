
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
  con.query("INSERT INTO REVIEW (reviewer_id, movie_id, description, rating) VALUES ( 2, "+ req.query.movie +", \'"+ req.query.review +"\', "+ req.query.rating +") ",  function (err, result) {
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
  console.log(req);
  console.log('hellos');
  var con = mysql.createConnection({
    host: "localhost",
    user: "isaiah",
    password: "PASSword",
    database : 'md',
  });

  con.connect(function(err) {
    if (err) throw err;
    console.log(req.query);
    var quer
    var quer2
    if (req.query.type == "movie"){
      var type = req.query.type;
      type = type.toUpperCase()
      var name = req.query.name;
      name = name.toUpperCase();
      quer = "SELECT * FROM "+ type +" WHERE NAME = \"" + name + "\""
    }
    else{
      var fname = req.query.name.split(" ")[0]
      var lname = req.query.name.split(" ")[1]
      var type = req.query.type;
      type = type.toUpperCase()
      quer = "SELECT bio FROM "+ type +" WHERE FNAME = \"" + fname + "\" AND LNAME = \"" + lname + "\""
      quer2 = "SELECT name FROM MOVIE WHERE movie_id = (SELECT director_id FROM DIRECTOR WHERE FNAME = 'Taika')"
      quer3 = "SELECT name FROM MOVIE WHERE movie_id = (SELECT movie_id FROM ACTOR WHERE act_id = (SELECT act_id FROM ACTOR WHERE FNAME = 'Chris' and LNAME = 'Hemsworth'));"
      quer4 = "SELECT avg(rating) FROM REVIEW WHERE movie_id = (SELECT movie_id FROM MOVIE WHERE name = 'Thor: Ragnarok')"
      quer5 = "SELECT rating FROM REVIEW WHERE movie_id = (SELECT movie_id FROM MOVIE WHERE name = 'Thor: Ragnarok')"
    }
    con.query(quer, function (err, result) {
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
