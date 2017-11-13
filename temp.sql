CREATE TABLE SEAT
(
  seat_num INT,
  row_num INT,
  PRIMARY KEY(seat_num, row_num)
);

CREATE TABLE THEATER_ROOM
(
  theater_num INT NOT NULL AUTO_INCREMENT,
  num_of_seats INT,
  PRIMARY KEY(theater_num)
);

CREATE TABLE CUSTOMER
(
  fname VARCHAR(100) NOT NULL,
  lname VARCHAR(100) NOT NULL,
  reward VARCHAR(15),
  credit_card INT,
  PRIMARY KEY(fname,lname)
);

CREATE TABLE ACTOR
(
  act_id INT NOT NULL AUTO_INCREMENT,
  fname VARCHAR(100),
  lname VARCHAR(100),
  bio VARCHAR(1000),
  PRIMARY KEY(act_id)
);

CREATE TABLE DIRECTOR
(
  director_id INT NOT NULL AUTO_INCREMENT,
  fname VARCHAR(100),
  lname VARCHAR(100),
  bio VARCHAR(1000),
  PRIMARY KEY(director_id)
);

CREATE TABLE GENRE
(
  genre_name VARCHAR(100) NOT NULL,
  PRIMARY KEY(genre_name)
);

CREATE TABLE PRODUCTION_CO
(
  pc_id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(100),
  owner VARCHAR(100),
  country_orgin VARCHAR(100),
  PRIMARY KEY(pc_id)
);

CREATE TABLE LANGUAGES
(
  language_name VARCHAR(100) NOT NULL,
  PRIMARY KEY(language_name)
);

CREATE TABLE TICKET_POOL
(
  pool_id INT NOT NULL AUTO_INCREMENT,
  num_of_sold INT,
  num_avail INT,
  PRIMARY KEY(pool_id)
);

CREATE TABLE REVIEWER
(
  reviewer_id INT NOT NULL AUTO_INCREMENT,
  type VARCHAR(100),
  PRIMARY KEY(reviewer_id)
);

CREATE TABLE MOVIE
(
  movie_id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(100),
  release_date DATE,
  run_time INT,
  production_CO INT NOT NULL,
  PRIMARY KEY(movie_id),
  FOREIGN KEY (production_CO) REFERENCES PRODUCTION_CO(pc_id)
);

CREATE TABLE SHOW_TIME
(
  movie_id INT NOT NULL,
  show_time TIME NOT NULL,
  theater_num INT NOT NULL,
  PRIMARY KEY(movie_id, show_time, theater_num),
  FOREIGN KEY (movie_id) REFERENCES MOVIE(movie_id),
  FOREIGN KEY (theater_num) REFERENCES THEATER_ROOM(theater_num)
);

CREATE TABLE REVIEW
(
  review_id INT NOT NULL AUTO_INCREMENT,
  reviewer_id INT NOT NULL,
  movie_id INT NOT NULL,
  description VARCHAR(2000),
  rating INT,
  PRIMARY KEY(review_id),
  FOREIGN KEY (reviewer_id) REFERENCES REVIEWER(reviewer_id),
  FOREIGN KEY (movie_id) REFERENCES MOVIE(movie_id)
);

CREATE TABLE MOVIE_ACT
(
  movie_id INT NOT NULL,
  act_id INT NOT NULL,
  PRIMARY KEY(movie_id, act_id),
  FOREIGN KEY (movie_id) REFERENCES MOVIE(movie_id),
  FOREIGN KEY (act_id) REFERENCES ACTOR(act_id)
);

CREATE TABLE MOVIE_GENRE
(
  movie_id INT NOT NULL,
  genre_name VARCHAR(100) NOT NULL,
  PRIMARY KEY(movie_id, genre_name),
  FOREIGN KEY (movie_id) REFERENCES MOVIE(movie_id),
  FOREIGN KEY (genre_name) REFERENCES GENRE(genre_name)
);

CREATE TABLE MOVIE_DIRECTORS
(
  movie_id INT NOT NULL,
  director_id INT NOT NULL,
  PRIMARY KEY(movie_id, director_id),
  FOREIGN KEY (movie_id) REFERENCES MOVIE(movie_id),
  FOREIGN KEY (director_id) REFERENCES DIRECTOR(director_id)
);

CREATE TABLE LANGUAGES_AVAIL
(
  movie_id INT NOT NULL,
  language_name VARCHAR(100) NOT NULL,
  subtitiles_avail CHAR,
  PRIMARY KEY(movie_id, language_name),
  FOREIGN KEY(movie_id) REFERENCES MOVIE(movie_id),
  FOREIGN KEY(language_name) REFERENCES LANGUAGES(language_name)
);

CREATE TABLE TICKET
(
  movie_date DATE,
  start_time TIME NOT NULL,
  fname VARCHAR(100),
  lname VARCHAR(100),
  seat_num INT,
  row_num INT,
  movie INT NOT NULL,
  theater INT NOT NULL,
  ticket_num INT NOT NULL,
  PRIMARY KEY(ticket_num),
  FOREIGN KEY (fname,lname) REFERENCES CUSTOMER(fname,lname),
  FOREIGN KEY (seat_num,row_num) REFERENCES SEAT(seat_num,row_num),
  FOREIGN KEY (movie) REFERENCES MOVIE(movie_id),
  FOREIGN KEY (theater) REFERENCES THEATER_ROOM(theater_num)
);

CREATE TABLE TICKET_SALES
(
  pool_id INT NOT NULL,
  ticket_num INT NOT NULL,
  PRIMARY KEY(pool_id,ticket_num),
  FOREIGN KEY(pool_id) REFERENCES TICKET_POOL(pool_id),
  FOREIGN KEY(ticket_num) REFERENCES TICKET(ticket_num)
);

INSERT INTO SEAT (seat_num, row_num) VALUES (1,1);
INSERT INTO SEAT (seat_num, row_num) VALUES (2,2);

INSERT INTO THEATER_ROOM (num_of_seats) VALUES (10);
INSERT INTO THEATER_ROOM (num_of_seats) VALUES (100);

INSERT INTO CUSTOMER (fname, lname, reward) VALUES ('Isaiah', 'Herrera', 1);
INSERT INTO CUSTOMER (fname, lname, reward) VALUES ('John', 'Doe', 2);

INSERT INTO ACTOR (fname, lname, bio) VALUES ('Chris', 'Pratt', 'His bio.');
INSERT INTO ACTOR (fname, lname, bio) VALUES ('Chris', 'Hemsworth', 'Also his bio.');

INSERT INTO DIRECTOR (fname, lname, bio) VALUES ('Chris', 'Matt', 'His bio.');
INSERT INTO DIRECTOR (fname, lname, bio) VALUES ('James', 'Cameron', 'His bio v2.');

INSERT INTO GENRE (genre_name) VALUES ('Sci-Fi');
INSERT INTO GENRE (genre_name) VALUES ('Silent');

INSERT INTO PRODUCTION_CO (name, owner, country_orgin) VALUES ('Dreamworks', 'Walt Disney', 'Japan');
INSERT INTO PRODUCTION_CO (name, owner, country_orgin) VALUES ('Sony', 'Dolby', 'United States');

INSERT INTO LANGUAGES (language_name) VALUES ('Thai');
INSERT INTO LANGUAGES (language_name) VALUES ('Spanish');

INSERT INTO TICKET_POOL (num_of_sold, num_avail) VALUES (1, 10);
INSERT INTO TICKET_POOL (num_of_sold, num_avail) VALUES (1, 100);

INSERT INTO REVIEWER (type) VALUES ('Critic');
INSERT INTO REVIEWER (type) VALUES ('User');

INSERT INTO MOVIE (name, release_date, run_time, production_CO) VALUES ('Sound of Music', '2017-03-22', 201, 1);
INSERT INTO MOVIE (name, release_date, run_time, production_CO) VALUES ('Mulan', '2019-09-02', 120, 2);

INSERT INTO SHOW_TIME (movie_id, show_time, theater_num) VALUES (1, '12:30:25', 1);
INSERT INTO SHOW_TIME (movie_id, show_time, theater_num) VALUES (2, '16:45:00', 2);

INSERT INTO REVIEW (reviewer_id, movie_id, description, rating) VALUES (1, 1, 'Good movie', 5);
INSERT INTO REVIEW (reviewer_id, movie_id, description, rating) VALUES (2, 1, 'Terrible', 2);

INSERT INTO MOVIE_ACT (movie_id, act_id) VALUES (1, 1);
INSERT INTO MOVIE_ACT (movie_id, act_id) VALUES (2, 2);

INSERT INTO MOVIE_GENRE (movie_id, genre_name) VALUES (1, 'Sci-Fi');
INSERT INTO MOVIE_GENRE (movie_id, genre_name) VALUES (2, 'Silent');

INSERT INTO MOVIE_DIRECTORS (movie_id, director_id) VALUES (1, 1);
INSERT INTO MOVIE_DIRECTORS (movie_id, director_id) VALUES (2, 2);

INSERT INTO LANGUAGES_AVAIL (movie_id, language_name, subtitiles_avail) VALUES (1, 'Thai', 'T');
INSERT INTO LANGUAGES_AVAIL (movie_id, language_name, subtitiles_avail) VALUES (2, 'Spanish', 'F');

INSERT INTO TICKET (movie_date, start_time, fname, lname, seat_num, row_num, movie, theater, ticket_num) VALUES ('2017-03-22', '12:30:25', 'Isaiah', 'Herrera', 1, 1, 1, 1, 1);
INSERT INTO TICKET (movie_date, start_time, fname, lname, seat_num, row_num, movie, theater, ticket_num) VALUES ('2019-09-02', '16:45:00', 'John', 'Doe', 2, 2, 2, 2, 2);

INSERT INTO TICKET_SALES (pool_id, ticket_num) VALUES (1, 1);
INSERT INTO TICKET_SALES (pool_id, ticket_num) VALUES (2, 2);
