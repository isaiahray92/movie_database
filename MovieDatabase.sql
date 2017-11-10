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
  UNIQUE(theater_num),
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
  act_id INT NOT NULL UNIQUE,
  fname VARCHAR(15),
  flname VARCHAR(15),
  bio VARCHAR(15),
  PRIMARY KEY(act_id)
);

CREATE TABLE DIRECTOR
(
  director_id INT NOT NULL,
  fname VARCHAR(15),
  lname VARCHAR(15),
  bio VARCHAR(15),
  UNIQUE(director_id),
  PRIMARY KEY(director_id)
);

CREATE TABLE GENRE
(
  genre_name VARCHAR(15) NOT NULL UNIQUE,
  PRIMARY KEY(genre_name)
);

CREATE TABLE PRODUCTION_CO
(
  pc_id VARCHAR(15) NOT NULL,
  name VARCHAR(30),
  owner VARCHAR(30),
  country_orgin VARCHAR(15),
  UNIQUE(pc_id),
  PRIMARY KEY(pc_id)
);

CREATE TABLE LANGUAGES
(
  language_name VARCHAR(15) NOT NULL UNIQUE,
  PRIMARY KEY(language_name)
);

CREATE TABLE TICKET_POOL
(
  pool_id INT NOT NULL UNIQUE,
  num_of_sold INT,
  num_avail INT,
  PRIMARY KEY(pool_id)
);

CREATE TABLE REVIEWER
(
  reviewer_id INT NOT NULL UNIQUE,
  type VARCHAR(15),
  PRIMARY KEY(reviewer_id)
);

CREATE TABLE MOVIE
(
  movie_id INT NOT NULL,
  name VARCHAR(15),
  release_date DATE,
  run_time INT,
  production_CO VARCHAR(15) NOT NULL,
  UNIQUE(movie_id),
  PRIMARY KEY(movie_id),
  FOREIGN KEY (production_CO)
   REFERENCES PRODUCTION_CO(pc_id)
);

CREATE TABLE SHOW_TIME
(
  movie_id INT NOT NULL,
  show_time TIME NOT NULL,
  theater_num INT NOT NULL,
  UNIQUE(movie_id),
  PRIMARY KEY(movie_id, show_time, theater_num),
  FOREIGN KEY (movie_id)
   REFERENCES MOVIE(movie_id),
  FOREIGN KEY (theater_num)
   REFERENCES THEATER_ROOM(theater_num)
);

CREATE TABLE REVIEWS_MADE
(
  reviewer_id INT NOT NULL,
  review_id INT NOT NULL,
  movie_id INT NOT NULL,
  UNIQUE(movie_id),
  UNIQUE(reviewer_id),
  PRIMARY KEY (reviewer_id, review_id),
  FOREIGN KEY (reviewer_id)
   REFERENCES REVIEWER(reviewer_id),
  FOREIGN KEY (movie_id)
   REFERENCES MOVIE(movie_id)
);

CREATE TABLE REVIEW
(
  reviewer_id INT NOT NULL,
  review_id INT NOT NULL,
  description VARCHAR(15),
  rating INT,
  UNIQUE(reviewer_id),
  UNIQUE(review_id),
  PRIMARY KEY(review_id),
  FOREIGN KEY (reviewer_id)
   REFERENCES REVIEWER(reviewer_id)
);

CREATE TABLE MOVIE_REVIEWS
(
  movie_id INT NOT NULL,
  review_id INT NOT NULL,
  UNIQUE(movie_id),
  UNIQUE(review_id),
  PRIMARY KEY(movie_id, review_id),
  FOREIGN KEY (movie_id)
   REFERENCES MOVIE(movie_id),
  FOREIGN KEY (review_id)
   REFERENCES REVIEW(review_id)
);

CREATE TABLE MOVIE_ACT
(
  movie_id INT NOT NULL UNIQUE,
  act_id INT NOT NULL UNIQUE,
  PRIMARY KEY(movie_id, act_id),
  FOREIGN KEY (movie_id)
   REFERENCES MOVIE(movie_id),
  FOREIGN KEY (act_id)
   REFERENCES ACTOR(act_id)
);

CREATE TABLE MOVIE_GENRE
(
  movie_id INT NOT NULL UNIQUE,
  genre_name VARCHAR(15) NOT NULL,
  PRIMARY KEY(movie_id, genre_name),
  FOREIGN KEY (movie_id)
   REFERENCES MOVIE(movie_id),
  FOREIGN KEY (genre_name)
   REFERENCES GENRE(genre_name)
);

CREATE TABLE MOVIE_DIRECTORS
(
  movie_id INT NOT NULL UNIQUE,
  director_id INT NOT NULL UNIQUE,
  PRIMARY KEY(movie_id, director_id),
  FOREIGN KEY (movie_id)
   REFERENCES MOVIE(movie_id),
  FOREIGN KEY (director_id)
   REFERENCES DIRECTOR(director_id)
);

CREATE TABLE LANGUAGES_AVAIL
(
  movie_id INT NOT NULL UNIQUE,
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
  seat_num INT UNIQUE,
  row_num INT,
  movie INT NOT NULL UNIQUE,
  theater INT NOT NULL UNIQUE,
  ticket_num INT NOT NULL UNIQUE,
  PRIMARY KEY(ticket_num),
  FOREIGN KEY (fname,lname)
   REFERENCES CUSTOMER(fname,lname),
  FOREIGN KEY (seat_num,row_num)
   REFERENCES SEAT(seat_num,row_num),
  FOREIGN KEY (movie)
   REFERENCES MOVIE(movie_id),
  FOREIGN KEY (theater)
   REFERENCES THEATER_ROOM(theater_num)
);

CREATE TABLE TICKET_SALES
(
  pool_id INT NOT NULL UNIQUE,
  ticket_num INT NOT NULL UNIQUE,
  PRIMARY KEY(pool_id,ticket_num),
  FOREIGN KEY(pool_id) REFERENCES TICKET_POOL(pool_id),
  FOREIGN KEY(ticket_num) REFERENCES TICKET(ticket_num)
);
