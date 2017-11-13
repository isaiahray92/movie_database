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
  ticket_num INT NOT NULL AUTO_INCREMENT,
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
INSERT INTO SEAT (seat_num, row_num) VALUES (2,1);

INSERT INTO THEATER_ROOM (num_of_seats) VALUES (10);
INSERT INTO THEATER_ROOM (num_of_seats) VALUES (100);

INSERT INTO CUSTOMER (fname, lname, reward) VALUES ('Isaiah', 'Herrera', 1);
INSERT INTO CUSTOMER (fname, lname, reward) VALUES ('John', 'Doe', 2);

INSERT INTO ACTOR (fname, lname, bio) VALUES ('Chris', 'Hemsworth', 'Born in Melbourne, Australia, to Leonie (van Os), a teacher of English, and Craig Hemsworth, a social-services counselor.');
INSERT INTO ACTOR (fname, lname, bio) VALUES ('Tom', 'Hiddleston', 'Thomas William Hiddleston, was born in Westminister, London, to Enlgish-born Diana Patricia (Servaes) and Scottish born James Norman Hiddleston.');
INSERT INTO ACTOR (fname, lname, bio) VALUES ('Cate', 'Blanchett', 'Cate Blanchett was born on May 14, 1969 in Melbourne, Victoria, Australia, to June (Gamble), an Australian teacher and property developer and Robert Dewett Blanchett Jr., an American advertising Executive.');
INSERT INTO ACTOR (fname, lname, bio) VALUES ('Will', 'Ferrell', 'John William Ferrell was born in Irving, California to Betty Kay (Overman), a teacher, and Roy Lee Ferrell Jr., a musician.');
INSERT INTO ACTOR (fname, lname, bio) VALUES ('Mark', 'Whalberg', 'American actor Mark Whalberg is one of a handful of respectfed entertainers who successfully made the transition from Teen Pop Idol to acclaimed actor.');
INSERT INTO ACTOR (fname, lname, bio) VALUES ('Mel', 'Gibson', 'Mel Columcillle Gerard Gibson was born January 3, 1956 in Peekskill, New York, USA, as a sixth of eleven children of Hutton Gibson, a railroad brakeman and Anne Patricia (Riley) Gibson (who died in December of 1990.)');

INSERT INTO DIRECTOR (fname, lname, bio) VALUES ('Taika', 'Waititi', 'Taiki Waititi, also known as Taika Cohen, hails from Raukokore region of the East Coast, and is of Te-Whanau-a-Apanui (father) and Jewish (mother) descent.');
INSERT INTO DIRECTOR (fname, lname, bio) VALUES ('Sean', 'Anders', 'Sean Anders is a writer and director, known for Horrible Bosses 2 (2014) and Daddys Home (2015).');

INSERT INTO GENRE (genre_name) VALUES ('Action');
INSERT INTO GENRE (genre_name) VALUES ('Adventure');
INSERT INTO GENRE (genre_name) VALUES ('Comedy');
INSERT INTO GENRE (genre_name) VALUES ('Sci-Fi');

INSERT INTO PRODUCTION_CO (name, owner, country_orgin) VALUES ('Marvel Studios', 'Kevin Feige', 'USA');
INSERT INTO PRODUCTION_CO (name, owner, country_orgin) VALUES ('Paramount Pictures', 'Jim Gianopulos', 'USA');

INSERT INTO LANGUAGES (language_name) VALUES ('English');
INSERT INTO LANGUAGES (language_name) VALUES ('Spanish');
INSERT INTO LANGUAGES (language_name) VALUES ('Mandarin');

INSERT INTO TICKET_POOL (num_of_sold, num_avail) VALUES (2, 10);
INSERT INTO TICKET_POOL (num_of_sold, num_avail) VALUES (0, 100);

INSERT INTO REVIEWER (type) VALUES ('Critic');
INSERT INTO REVIEWER (type) VALUES ('User');
INSERT INTO REVIEWER (type) VALUES ('Critic');

INSERT INTO MOVIE (name, release_date, run_time, production_CO) VALUES ('Thor: Ragnarok', '2017-11-03', 130, 1);
INSERT INTO MOVIE (name, release_date, run_time, production_CO) VALUES ('Daddy\'s Home 2', '2017-11-10', 100, 2);

INSERT INTO SHOW_TIME (movie_id, show_time, theater_num) VALUES (1, '02:30:00', 1);
INSERT INTO SHOW_TIME (movie_id, show_time, theater_num) VALUES (1, '6:00:00', 1);
INSERT INTO SHOW_TIME (movie_id, show_time, theater_num) VALUES (2, '12:30:00', 2);

INSERT INTO REVIEW (reviewer_id, movie_id, description, rating) VALUES (1, 1, 'Ragnarok is a neon-infused fantasy of what superhero films could look like. There are gigantic monsters and beautiful women; zombie armies and a big spooky dog; an evil witch and Jeff Goldblum, but this isn\'t just a wacky movie made for the sake of wackiness. Ragnarok is the child of confident filmmaking and understanding of what the Thor franchise could have always been.', 5);
INSERT INTO REVIEW (reviewer_id, movie_id, description, rating) VALUES (2, 1, 'I had the opportunity to witness this goofy nonsense with my Father, who was a big fan of the Thor comics in his youth, and what he saw on screen destroyed everything he, and later, I, would come to enjoy about the titular character, who has been reduced to a comedic buffoon.', 1);
INSERT INTO REVIEW (reviewer_id, movie_id, description, rating) VALUES (3, 2, 'Daddy\'s Home 2 had the potential of being comedic and fun like how the first film was. But like most comedy sequels, this one was a dud with most of the laughs already shown in the trailers. While the rest of the 90 or so minutes being completely a drag and boring. The first film was a lot of fun with the concept of step dad vs. dad with Will Ferrell vs. Mark Wahlberg. They do make a perfect comedic duo.', 3);
INSERT INTO REVIEW (reviewer_id, movie_id, description, rating) VALUES (2, 2, 'Daddy\'s Home 2 is silly and over-the-top, and much like the first film isn\'t short of a few eye-rollers and missteps; there may not be a dance- off, but they don\'t shy away from that level of comicality. This sequel contains more slapstick humor, but in turn that also means more laughs.', 4);

INSERT INTO MOVIE_ACT (movie_id, act_id) VALUES (1, 1);
INSERT INTO MOVIE_ACT (movie_id, act_id) VALUES (1, 2);
INSERT INTO MOVIE_ACT (movie_id, act_id) VALUES (1, 3);
INSERT INTO MOVIE_ACT (movie_id, act_id) VALUES (2, 4);
INSERT INTO MOVIE_ACT (movie_id, act_id) VALUES (2, 5);
INSERT INTO MOVIE_ACT (movie_id, act_id) VALUES (2, 6);

INSERT INTO MOVIE_GENRE (movie_id, genre_name) VALUES (1, 'Action');
INSERT INTO MOVIE_GENRE (movie_id, genre_name) VALUES (1, 'Adventure');
INSERT INTO MOVIE_GENRE (movie_id, genre_name) VALUES (1, 'Comedy');
INSERT INTO MOVIE_GENRE (movie_id, genre_name) VALUES (1, 'Sci-Fi');
INSERT INTO MOVIE_GENRE (movie_id, genre_name) VALUES (2, 'Comedy');

INSERT INTO MOVIE_DIRECTORS (movie_id, director_id) VALUES (1, 1);
INSERT INTO MOVIE_DIRECTORS (movie_id, director_id) VALUES (2, 2);

INSERT INTO LANGUAGES_AVAIL (movie_id, language_name, subtitiles_avail) VALUES (1, 'English', 'T');
INSERT INTO LANGUAGES_AVAIL (movie_id, language_name, subtitiles_avail) VALUES (1, 'Spanish', 'F');
INSERT INTO LANGUAGES_AVAIL (movie_id, language_name, subtitiles_avail) VALUES (1, 'Mandarin', 'T');
INSERT INTO LANGUAGES_AVAIL (movie_id, language_name, subtitiles_avail) VALUES (2, 'English', 'F');
INSERT INTO LANGUAGES_AVAIL (movie_id, language_name, subtitiles_avail) VALUES (2, 'Spanish', 'F');

INSERT INTO TICKET (movie_date, start_time, fname, lname, seat_num, row_num, movie, theater) VALUES ('2017-12-22', '10:40:00', 'Isaiah', 'Herrera', 1, 1, 1, 1);
INSERT INTO TICKET (movie_date, start_time, fname, lname, seat_num, row_num, movie, theater) VALUES ('2017-12-22', '10:40:00', 'John', 'Doe', 2, 1, 1, 1);

INSERT INTO TICKET_SALES (pool_id, ticket_num) VALUES (1, 1);
INSERT INTO TICKET_SALES (pool_id, ticket_num) VALUES (1, 2);
