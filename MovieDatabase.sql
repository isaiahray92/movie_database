/*CREATE TABLE MOVIE
(
movie VARCHAR(15),
name VARCHAR(15),
release_date DATE,
run_time
PRIMARY KEY(Movie_id),
FOREIGN KEY(genres) REFERENCES
);*/



CREATE TABLE TICKET
(
  start_time INT,
  end_time INT,
  PRIMARY KEY(ticket_num),
  FOREIGN KEY(fname) REFERENCES CUSTOMER(fname),
  FOREIGN KEY(lname) REFERENCES CUSTOMER(lname),
  FOREIGN KEY(seat_num) REFERENCES SEAT(seat_num),
  FOREIGN KEY(row_num) REFERENCES SEAT(row_num),
  FOREIGN KEY(movie) REFERENCES MOVIE(movie_id),
  FOREIGN KEY(theater) REFERENCES THEATER_ROOM(theater_num)
);


CREATE TABLE SEAT
(
  PRIMARY KEY(seat_num),
  PRIMARY KEY(row_num)
);

CREATE TABLE THEATER_ROOM
(
  start_end INT,
  end_time INT,
  PRIMARY KEY(theater_num),
);


CREATE TABLE SHOW_TIME
(
  PRIMARY KEY(movie_id, show_time, theater_num),
  FOREIGN KEY(movie_id) REFERENCES MOVIE(movie_id),
  FOREIGN KEY(theater_num) REFERENCES THEATER_ROOM(theater_num)
);

CREATE TABLE CUSTOMER
(
  reward VARCHAR(15),
  credit_card INT,
  PRIMARY KEY(fname,lname)
);

CREATE TABLE SEAT
(
  PRIMARY KEY(seat_num),
  PRIMARY KEY(row_num)
);

CREATE TABLE REVIEW
(
  description CHARVAR(50), -- I DONT KNOW IF THIS IS RESONABLE
  rating INT,
  type CHARVAR(15),
  FOREIGN KEY(reviewer) REFERENCES REVIEWS_MADE(reviewer_id)
);


CREATE TABLE REVIEWS_MADE
(
  PRIMARY KEY(reviewer_id, review_id),
  FOREIGN KEY(reviewer_id) REFERENCES MOVIE(reviewr_id),
  FOREIGN KEY(movie_id) REFERENCES MOVIE(movie_id)
);


CREATE TABLE MOVE_REVIEWS
(
  PRIMARY KEY(movie_id, review_id),
  FOREIGN KEY(movie_id, review_id)
);

CREATE TABLE ACTOR
(
  fname VARCHAR(15),
  flname VARCHAR(15),
  bio VARCHAR(100),
  PRIMARY KEY(act_id)
);

CREATE TABLE MOVIE_ACT
(
  PRIMARY KEY(movie_id, act_id),
  FOREIGN KEY(movie_id) REFERENCES MOVIE(movie_id),
  FOREIGN KEY(act_id) REFERENCES ACTOR(act_id)
);

CREATE TABLE MOVIE_GENRE
(
  PRIMARY KEY(movie_id, genre_name),
  FOREIGN KEY(movie_id) REFERENCES GENRE(movie_id),
  FOREIGN KEY(genre_name) REFERENCES GENRE(genre_name)
);

CREATE TABLE MOVIE_DIRECTORS
(
  PRIMARY KEY(movie_id, director_id)
  FOREIGN KEY(movie_id) REFERENCES DIRECTOR(movie_id),
  FOREIGN KEY(director_id) REFERENCES DIRECTOR(director_id)
);

CREATE TABLE DIRECTOR
(
  fname VARCHAR(15),
  lname VARCHAR(15),
  bio VARCHAR(100),
  PRIMARY KEY(director_id)
);

CREATE TABLE GENRE
(
  PRIMARY KEY(genre_name)
);

CREATE TABLE PRODCUTION_CO
(
  name VARCHAR(15),
  owner VARCHAR(15),
  country_orgin VARCHAR(15),
  PRIMARY KEY(pc_id)
);


CREATE TABLE TICKET_SALES
(
  PRIMARY KEY(pool_id, ticket_num),
  FOREIGN KEY(pool_id) REFERENCES TICKET_POOL(pool_id),
  FOREIGN KEY(ticket_num) REFERENCES TICKET(ticket_num)
);


CREATE TABLE LANGUAGES
(
  PRIMARY KEY(language_name)
);

CREATE TABLE LANGUAGES_AVAIL
(
  subtitiles_avail VARCHAR(15)
  PRIMARY KEY(movie_id, language_name)
  FOREIGN KEY(movie_id) REFERENCES MOVIE(movie_id),
  FOREIGN KEY(language_name) REFERENCES LANGUAGES(language_name)
);


/*
DUMPING DATA INTO TABLE
*/
