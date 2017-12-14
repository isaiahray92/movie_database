
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
router.get("/manLogin", function(req,res){
  res.sendFile(path + "/manLogin.html");
});
router.get("/freshpotatoes", function(req,res){
  res.sendFile(path + "/freshpotatoes.png");
});
router.get("/thorragnarok", function(req,res){
  res.sendFile(path + "/pictures/Thor_Ragnarok.jpg");
});
router.get("/daddyshome2", function(req,res){
  res.sendFile(path + "/pictures/daddyshome2.jpg");
});
router.get("/melgibson", function(req,res){
  res.sendFile(path + "/pictures/mel_gibson.jpg");
});
router.get("/jasonmomoa", function(req,res){
  res.sendFile(path + "/pictures/Jason_Momoa.jpg");
});
router.get("/chrishemsworth", function(req,res){
  res.sendFile(path + "/pictures/Chris_Hemsworth.jpg");
});

app.use("/", router);
app.use('/node_modules',  express.static(__dirname + '/node_modules'));
app.use('/style',  express.static(__dirname + '/style'));


app.listen(3000,function(){
    console.log('Node server running @ http://localhost:3000')
});

router.get('/credentials', function(req, res){
  var con = mysql.createConnection({
    host: "localhost",
    user: "isaiah",
    password: "PASSword",
    database : 'md',
});

con.connect(function(err) {
  if (err) res.send("error");
  con.query("SELECT * FROM USER;",  function (err, result) {
    if (err){
      res.send("Failure");
  }
    else {
      // res.send(result); //How to transfer this to app.js without it resulting in unidentified
      if(req.query.username == result[0]['User_name'] && req.query.password == result[0]['Password']){
        res.send("Success");
      }else{
        res.send("Failure");
      }

}
});
con.end();

});
});

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
  if (err) res.send("error");
    //quer = "INSERT * FROM "+ req.query.type +" WHERE NAME = \"" + req.query.name + "\""
  con.query("INSERT INTO REVIEW (reviewer_id, movie_id, description, rating) VALUES ( 2, (SELECT movie_id FROM MOVIE WHERE MOVIE.name = "+ JSON.stringify(req.query.movie) +"), \'"+ req.query.review +"\', "+ req.query.rating +") ",  function (err, result) {
    if (err){
      res.send("error");
  }
    else {
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
    if (err) res.send("error");
    var quer = [];
    if (req.query.type == "movie"){
      quer.push("SELECT * FROM MOVIE WHERE NAME = " + JSON.stringify(req.query.name) + ";");
      quer.push("SELECT fname, lname FROM ACTOR WHERE act_id IN (SELECT act_id FROM MOVIE_ACT WHERE movie_id = (SELECT movie_id FROM MOVIE WHERE name = "+ JSON.stringify(req.query.name) +"));");
      quer.push("SELECT avg(rating) FROM REVIEW WHERE movie_id = (SELECT movie_id FROM MOVIE WHERE name = " + JSON.stringify(req.query.name) + ");");
      quer.push("SELECT fname, lname FROM DIRECTOR WHERE director_id = (SELECT director_id FROM MOVIE_DIRECTORS WHERE movie_id = (SELECT movie_id FROM MOVIE WHERE NAME = " + JSON.stringify(req.query.name) + "));");
      quer.push("SELECT description, rating FROM REVIEW WHERE movie_id = (SELECT movie_id FROM MOVIE WHERE name = " + JSON.stringify(req.query.name) + ");");
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
        res.send("error");
      }
      else {
        prev.push(result);
    }
    });
  }
    setTimeout(function(){ res.send(prev); }, 100);
    con.end();

});
});

router.get('/retrieveReviews', function(req, res){
var con = mysql.createConnection({
  host: "localhost",
  user: "isaiah",
  password: "PASSword",
  database : 'md',
});

con.connect(function(err) {
  if (err) throw err;
    //quer = "INSERT * FROM "+ req.query.type +" WHERE NAME = \"" + req.query.name + "\""
    // "SELECT name FROM MOVIE WHERE movie_id IN (SELECT movie_id FROM MOVIE_ACT WHERE act_id = (SELECT act_id FROM ACTOR WHERE FNAME = \'" + fname + "\' AND LNAME = \'" + lname + "\'));"
  con.query("Drop VIEW IF EXISTS revToDelete;", function (err){
    if(err){
      throw err;
    }
  });
  con.query("CREATE VIEW revToDelete as (select review_id, name, description from (review LEFT JOIN movie ON review.movie_id=movie.movie_id));", function (err){
    if(err){
      throw err;
    }
  });
  con.query("SELECT * FROM revToDelete where name= " + JSON.stringify(req.query.movie) + ";", function (err, result) {
    if (err){
      throw err;
  }
    else {
      res.send(result); //How to transfer this to app.js without it resulting in unidentified
}
});
con.end();

});
});

router.get('/deleteReview', function(req, res){
  var con = mysql.createConnection({
    host: "localhost",
    user: "isaiah",
    password: "PASSword",
    database : 'md',
});

con.connect(function(err) {
  if (err) throw err;
  con.query("DELETE FROM REVIEW WHERE review_id=" + req.query.id + ";",  function (err, result) {
    if (err){
      throw err;
  }
    else {
      res.send(result); //How to transfer this to app.js without it resulting in unidentified
}
});
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
  if (err) res.send("error");
    //quer = "INSERT * FROM "+ req.query.type +" WHERE NAME = \"" + req.query.name + "\""
  con.query("SELECT * FROM MOVIE;",  function (err, result) {
    if (err){
      res.send("error");
  }
    else {
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
  if (err) res.send("error");
  con.query("SELECT * FROM SHOW_TIME WHERE movie_id = "+req.query.movie_id+";",  function (err, result) {
    if (err){
      res.send("error");
  }
    else {
      res.send(result);
}
});
con.end();

});
});

router.get('/buyTicket', function(req, res){
console.log(req.query.movie)
  var con = mysql.createConnection({
    host: "localhost",
    user: "isaiah",
    password: "PASSword",
    database : 'md',
});

con.connect(function(err) {
  if (err) res.send("error");
  console.log(req.query);
  con.query("CALL FindName("+ JSON.stringify(req.query.movie)+", "+JSON.stringify(req.query.date)+ ", "+ JSON.stringify(req.query.fname) + ", "+ JSON.stringify(req.query.lname)+ ", "+ JSON.stringify(req.query.time) + ", "+ req.query.cc +");",  function (err, result) {
    if (err){
      throw err;
      //res.send("error");
  }
    else {
      console.log(result);
      res.send(result); //How to transfer this to app.js without it resulting in unidentified
}
});
con.end();

});
});
