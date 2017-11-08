CREATE TABLE SEAT
(
  seat_num INT,
  row_num INT,
  PRIMARY KEY(seat_num, row_num)
);

CREATE TABLE THEATER_ROOM
(
  theater_num INT NOT NULL,
  num_of_seats INT,
  PRIMARY KEY(theater_num)
);

CREATE TABLE CUSTOMER
(
  fname VARCHAR(15) NOT NULL,
  lname VARCHAR(15) NOT NULL,
  reward VARCHAR(15),
  credit_card INT,
  PRIMARY KEY(fname,lname)
);

CREATE TABLE ACTOR
(
  act_id INT NOT NULL,
  fname VARCHAR(15),
  flname VARCHAR(15),
  bio VARCHAR(65535),
  PRIMARY KEY(act_id)
);

CREATE TABLE DIRECTOR
(
  director_id INT NOT NULL,
  fname VARCHAR(15),
  lname VARCHAR(15),
  bio VARCHAR(65535),
  PRIMARY KEY(director_id)
);

CREATE TABLE GENRE
(
  genre_name VARCHAR(15) NOT NULL UNIQUE,
  PRIMARY KEY(genre_name)
);

CREATE TABLE PRODUCTION_CO
(
  pc_id INT NOT NULL,
  name VARCHAR(30),
  owner VARCHAR(30),
  country_orgin VARCHAR(15),
  PRIMARY KEY(pc_id)
);

CREATE TABLE LANGUAGES
(
  language_name VARCHAR(15) NOT NULL UNIQUE,
  PRIMARY KEY(language_name)
);

CREATE TABLE TICKET_POOL
(
  pool_id INT NOT NULL,
  num_of_sold INT,
  num_avail INT,
  PRIMARY KEY(pool_id)
);

CREATE TABLE REVIEWER
(
  reviewer_id INT NOT NULL,
  type VARCHAR(15),
  PRIMARY KEY(reviewer_id)
);

CREATE TABLE MOVIE
(
  movie_id INT NOT NULL,
  name VARCHAR(15),
  release_date DATE,
  run_time INT,
  production_CO VARCHAR(15),
  PRIMARY KEY(movie_id),
  FOREIGN KEY(production_CO) REFERENCES PRODUCTION_CO(pc_id)
);

CREATE TABLE SHOW_TIME
(
  movie_id INT NOT NULL,
  show_time TIME NOT NULL,
  theater_num INT NOT NULL,
  PRIMARY KEY(movie_id, show_time, theater_num),
  FOREIGN KEY(movie_id) REFERENCES MOVIE(movie_id),
  FOREIGN KEY(theater_num) REFERENCES THEATER_ROOM(theater_num)
);

CREATE TABLE REVIEWS_MADE
(
  reviewer_id INT NOT NULL,
  review_id INT NOT NULL,
  PRIMARY KEY(reviewer_id, review_id),
  FOREIGN KEY(reviewer_id) REFERENCES MOVIE(reviewr_id),
  FOREIGN KEY(movie_id) REFERENCES MOVIE(movie_id)
);

CREATE TABLE REVIEW
(
  review_id INT,
  description VARCHAR(65535),
  rating INT,
  PRIMARY KEY(review_id),
  FOREIGN KEY(reviewer) REFERENCES REVIEWS_MADE(reviewer_id)
);

CREATE TABLE MOVIE_REVIEWS
(
  movie_id INT NOT NULL,
  review_id INT NOT NULL,
  PRIMARY KEY(movie_id, review_id),
  FOREIGN KEY(movie_id) REFERENCES MOVIE(movie_id),
  FOREIGN KEY(review_id) REFERENCES REVIEW(review_id)
);

CREATE TABLE MOVIE_ACT
(
  movie_id INT NOT NULL,
  act_id INT NOT NULL,
  PRIMARY KEY(movie_id, act_id),
  FOREIGN KEY(movie_id) REFERENCES MOVIE(movie_id),
  FOREIGN KEY(act_id) REFERENCES ACTOR(act_id)
);

CREATE TABLE MOVIE_GENRE
(
  movie_id INT NOT NULL,
  genre_name VARCHAR(15) NOT NULL,
  PRIMARY KEY(movie_id, genre_name),
  FOREIGN KEY(movie_id) REFERENCES GENRE(movie_id),
  FOREIGN KEY(genre_name) REFERENCES GENRE(genre_name)
);

CREATE TABLE MOVIE_DIRECTORS
(
  movie_id INT NOT NULL,
  director_id INT NOT NULL,
  PRIMARY KEY(movie_id, director_id)
  FOREIGN KEY(movie_id) REFERENCES DIRECTOR(movie_id),
  FOREIGN KEY(director_id) REFERENCES DIRECTOR(director_id)
);

CREATE TABLE LANGUAGES_AVAIL
(
  movie_id INT NOT NULL,
  language_name VARCHAR(15) NOT NULL,
  subtitiles_avail CHAR,
  PRIMARY KEY(movie_id, language_name),
  FOREIGN KEY(movie_id) REFERENCES MOVIE(movie_id),
  FOREIGN KEY(language_name) REFERENCES LANGUAGES(language_name)
);

CREATE TABLE TICKET
(
  movie_date DATE,
  start_time TIME NOT NULL,
  fname VARCHAR(15),
  lname VARCHAR(15),
  seat_num INT,
  row_num INT,
  movie INT NOT NULL,
  theater INT NOT NULL,
  PRIMARY KEY(ticket_num),
  FOREIGN KEY(start_time) REFERENCES SHOW_TIME(show_time),
  FOREIGN KEY(fname) REFERENCES CUSTOMER(fname),
  FOREIGN KEY(lname) REFERENCES CUSTOMER(lname),
  FOREIGN KEY(seat_num) REFERENCES SEAT(seat_num),
  FOREIGN KEY(row_num) REFERENCES SEAT(row_num),
  FOREIGN KEY(movie) REFERENCES MOVIE(movie_id),
  FOREIGN KEY(theater) REFERENCES THEATER_ROOM(theater_num)
);

CREATE TABLE TICKET_SALES
(
  pool_id INT NOT NULL,
  ticket_num INT NOT NULL,
  PRIMARY KEY(pool_id, ticket_num),
  FOREIGN KEY(pool_id) REFERENCES TICKET_POOL(pool_id),
  FOREIGN KEY(ticket_num) REFERENCES TICKET(ticket_num)
);
