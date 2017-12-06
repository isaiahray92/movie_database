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
  show_date DATE NOT NULL,
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

CREATE TABLE USER
(
  User_name VARCHAR(30),
  Password VARCHAR(30),
  PRIMARY KEY(User_name)
);

INSERT INTO USER (User_name, Password) VALUES ('USERNAME','PASSWORD');

INSERT INTO SEAT (seat_num, row_num) VALUES (1,1);
INSERT INTO SEAT (seat_num, row_num) VALUES (2,1);

INSERT INTO THEATER_ROOM (num_of_seats) VALUES (10);
INSERT INTO THEATER_ROOM (num_of_seats) VALUES (100);
INSERT INTO THEATER_ROOM (num_of_seats) VALUES (50);

INSERT INTO CUSTOMER (fname, lname, reward) VALUES ('Isaiah', 'Herrera', 1);
INSERT INTO CUSTOMER (fname, lname, reward) VALUES ('John', 'Doe', 2);
INSERT INTO CUSTOMER (fname, lname, reward) VALUES ('Matthew', 'Gerber', 3);
INSERT INTO CUSTOMER (fname, lname, reward) VALUES ('Cole', 'Polychronis', 4);
INSERT INTO CUSTOMER (fname, lname, reward) VALUES ('Taylor', 'Page', 5);

INSERT INTO ACTOR (fname, lname, bio) VALUES ('Chris', 'Hemsworth', 'Born in Melbourne, Australia, to Leonie (van Os), a teacher of English, and Craig Hemsworth, a social-services counselor.');
INSERT INTO ACTOR (fname, lname, bio) VALUES ('Tom', 'Hiddleston', 'Thomas William Hiddleston, was born in Westminister, London, to Enlgish-born Diana Patricia (Servaes) and Scottish born James Norman Hiddleston.');
INSERT INTO ACTOR (fname, lname, bio) VALUES ('Cate', 'Blanchett', 'Cate Blanchett was born on May 14, 1969 in Melbourne, Victoria, Australia, to June (Gamble), an Australian teacher and property developer and Robert Dewett Blanchett Jr., an American advertising Executive.');
INSERT INTO ACTOR (fname, lname, bio) VALUES ('Will', 'Ferrell', 'John William Ferrell was born in Irving, California to Betty Kay (Overman), a teacher, and Roy Lee Ferrell Jr., a musician.');
INSERT INTO ACTOR (fname, lname, bio) VALUES ('Mark', 'Whalberg', 'American actor Mark Whalberg is one of a handful of respectfed entertainers who successfully made the transition from Teen Pop Idol to acclaimed actor.');
INSERT INTO ACTOR (fname, lname, bio) VALUES ('Mel', 'Gibson', 'Mel Columcillle Gerard Gibson was born January 3, 1956 in Peekskill, New York, USA, as a sixth of eleven children of Hutton Gibson, a railroad brakeman and Anne Patricia (Riley) Gibson (who died in December of 1990.)');
INSERT INTO ACTOR (fname, lname, bio) VALUES ('Ben', 'Affleck', 'American actor and filmmaker Benjamin Géza Affleck-Boldt was born on August 15, 1972 in Berkeley, California, and was raised in Cambridge, Massachusetts.');
INSERT INTO ACTOR (fname, lname, bio) VALUES ('Gal', 'Gadot', 'Gal Gadot is an Israeli actress, singer, martial artist, and model.');
INSERT INTO ACTOR (fname, lname, bio) VALUES ('Jason', 'Momoa', 'Joseph Jason Namakaeha Momoa was born on August 1, 1979 in Honolulu, Hawaii. He is the son of Coni (Lemke), a photographer, and Joseph Momoa, a painter.');
INSERT INTO ACTOR (fname, lname, bio) VALUES ('Matt', 'Passmore', 'Matt Passmore was born on December 24, 1973 in Wynnum-Manly, Queensland, Australia as Matthew Passmore. He is an actor and producer, known for The Glades (2010), Jigsaw (2017) and McLeod\'s Daughters (2001).');
INSERT INTO ACTOR (fname, lname, bio) VALUES ('Tobin', 'Bell', 'Tobin Bell is an American actor with a career in film, television and theater spanning three decades. He was born in Queens, New York and raised in Weymouth, Mass.');
INSERT INTO ACTOR (fname, lname, bio) VALUES ('Callum', 'Rennie', 'Callum Keith Rennie was born in England, raised in Alberta, Canada and came late to acting - he discovered theatre in Edmonton at the age of 25.');
INSERT INTO ACTOR (fname, lname, bio) VALUES ('Mila', 'Kunis', 'Mila Kunis was born Milena Markovna Kunis to a Jewish family in Chernivtsi, Ukraine, USSR (now independent Ukraine).');
INSERT INTO ACTOR (fname, lname, bio) VALUES ('Kristen', 'Bell', 'Kristen Anne Bell (born 1980) is an American actress and singer.');
INSERT INTO ACTOR (fname, lname, bio) VALUES ('Kathryn', 'Hahn', 'Kathryn Hahn was born in Westchester, Illinois, but her family then moved to Cleveland, Ohio, where she spent most of her time growing up.');

INSERT INTO DIRECTOR (fname, lname, bio) VALUES ('Taika', 'Waititi', 'Taiki Waititi, also known as Taika Cohen, hails from Raukokore region of the East Coast, and is of Te-Whanau-a-Apanui (father) and Jewish (mother) descent.');
INSERT INTO DIRECTOR (fname, lname, bio) VALUES ('Sean', 'Anders', 'Sean Anders is a writer and director, known for Horrible Bosses 2 (2014) and Daddys Home (2015).');
INSERT INTO DIRECTOR (fname, lname, bio) VALUES ('Zack', 'Snyder', 'Zachary Edward "Zack" Snyder (born March 1, 1966) is an American film director, film producer, and screenwriter, best known for action and science fiction films.');
INSERT INTO DIRECTOR (fname, lname, bio) VALUES ('Michael', 'Spierig', 'Michael Spierig was born in Germany. He is a director and writer, known for Predestination (2014), Daybreakers (2009) and Undead (2003).');
INSERT INTO DIRECTOR (fname, lname, bio) VALUES ('Jon', 'Lucas', 'Jon Lucas is a writer and producer, known for The Hangover (2009), The Hangover Part II (2011) and The Hangover Part III (2013).');

INSERT INTO GENRE (genre_name) VALUES ('Action');
INSERT INTO GENRE (genre_name) VALUES ('Adventure');
INSERT INTO GENRE (genre_name) VALUES ('Comedy');
INSERT INTO GENRE (genre_name) VALUES ('Sci-Fi');
INSERT INTO GENRE (genre_name) VALUES ('Fantasy');
INSERT INTO GENRE (genre_name) VALUES ('Crime');
INSERT INTO GENRE (genre_name) VALUES ('Horror');
INSERT INTO GENRE (genre_name) VALUES ('Mystery');

INSERT INTO PRODUCTION_CO (name, owner, country_orgin) VALUES ('Marvel Studios', 'Kevin Feige', 'USA');
INSERT INTO PRODUCTION_CO (name, owner, country_orgin) VALUES ('Paramount Pictures', 'Jim Gianopulos', 'USA');
INSERT INTO PRODUCTION_CO (name, owner, country_orgin) VALUES ('DC Entertainment', 'Diane Nelson', 'USA');
INSERT INTO PRODUCTION_CO (name, owner, country_orgin) VALUES ('Twisted Pictures', 'Mark Burg', 'USA');
INSERT INTO PRODUCTION_CO (name, owner, country_orgin) VALUES ('Huayi Brothers Media', 'Wang Zhongjun', 'China');

INSERT INTO LANGUAGES (language_name) VALUES ('English');
INSERT INTO LANGUAGES (language_name) VALUES ('Spanish');
INSERT INTO LANGUAGES (language_name) VALUES ('Mandarin');

INSERT INTO TICKET_POOL (num_of_sold, num_avail) VALUES (2, 10);
INSERT INTO TICKET_POOL (num_of_sold, num_avail) VALUES (1, 100);
INSERT INTO TICKET_POOL (num_of_sold, num_avail) VALUES (2, 50);

INSERT INTO REVIEWER (type) VALUES ('Critic');
INSERT INTO REVIEWER (type) VALUES ('User');
INSERT INTO REVIEWER (type) VALUES ('Critic');

INSERT INTO MOVIE (name, release_date, run_time, production_CO) VALUES ('Thor: Ragnarok', '2017-11-03', 130, 1);
INSERT INTO MOVIE (name, release_date, run_time, production_CO) VALUES ('Daddy\'s Home 2', '2017-11-10', 100, 2);
INSERT INTO MOVIE (name, release_date, run_time, production_CO) VALUES ('Justice League', '2017-11-17', 120, 3);
INSERT INTO MOVIE (name, release_date, run_time, production_CO) VALUES ('Jigsaw', '2017-10-27', 92, 4);
INSERT INTO MOVIE (name, release_date, run_time, production_CO) VALUES ('A Bad Mom\'s Christmas', '2017-11-01', 104, 5);

INSERT INTO SHOW_TIME (movie_id, show_time, theater_num, show_date) VALUES (1, '02:30:00', 1, '2017-12-25');
INSERT INTO SHOW_TIME (movie_id, show_time, theater_num, show_date) VALUES (1, '06:00:00', 1, '2017-12-25');
INSERT INTO SHOW_TIME (movie_id, show_time, theater_num, show_date) VALUES (2, '12:30:00', 2, '2017-12-25');
INSERT INTO SHOW_TIME (movie_id, show_time, theater_num, show_date) VALUES (3, '09:15:00', 3, '2017-12-25');
INSERT INTO SHOW_TIME (movie_id, show_time, theater_num, show_date) VALUES (4, '11:45:00', 2, '2017-12-25');
INSERT INTO SHOW_TIME (movie_id, show_time, theater_num, show_date) VALUES (5, '05:50:00', 3, '2017-12-25');

INSERT INTO REVIEW (reviewer_id, movie_id, description, rating) VALUES (1, 1, 'Ragnarok is a neon-infused fantasy of what superhero films could look like. There are gigantic monsters and beautiful women; zombie armies and a big spooky dog; an evil witch and Jeff Goldblum, but this isn\'t just a wacky movie made for the sake of wackiness. Ragnarok is the child of confident filmmaking and understanding of what the Thor franchise could have always been.', 5);
INSERT INTO REVIEW (reviewer_id, movie_id, description, rating) VALUES (2, 1, 'I had the opportunity to witness this goofy nonsense with my Father, who was a big fan of the Thor comics in his youth, and what he saw on screen destroyed everything he, and later, I, would come to enjoy about the titular character, who has been reduced to a comedic buffoon.', 1);
INSERT INTO REVIEW (reviewer_id, movie_id, description, rating) VALUES (3, 2, 'Daddy\'s Home 2 had the potential of being comedic and fun like how the first film was. But like most comedy sequels, this one was a dud with most of the laughs already shown in the trailers. While the rest of the 90 or so minutes being completely a drag and boring. The first film was a lot of fun with the concept of step dad vs. dad with Will Ferrell vs. Mark Wahlberg. They do make a perfect comedic duo.', 3);
INSERT INTO REVIEW (reviewer_id, movie_id, description, rating) VALUES (2, 2, 'Daddy\'s Home 2 is silly and over-the-top, and much like the first film isn\'t short of a few eye-rollers and missteps; there may not be a dance- off, but they don\'t shy away from that level of comicality. This sequel contains more slapstick humor, but in turn that also means more laughs.', 4);
INSERT INTO REVIEW (reviewer_id, movie_id, description, rating) VALUES (1, 3, 'Don\'t listen to the Marvel fans. This movie is great, tons of fun and LOTS of action. The characters are great and the story is fast-paced. The Flash steals the show and Aquaman is no longer a joke. Batman and Wonder Woman are always great and Superman.... Well, you\'ll just have to see it for your self. You can\'t ask for a better time at the movies!', 5);
INSERT INTO REVIEW (reviewer_id, movie_id, description, rating) VALUES (1, 3, '"Justice League" doesn’t have anyone with the witty way with a line Robert Downey Jr. brings to Ironman, or the swagger of Chris Hemsworth (Thor) to carry it. But Momoa’s bemused physicality has its own cockiness, Miller’s wide-eyed Flash innocence and Gadot’s commitment to earnest, brave and spoiling for a fight Diana put “The Avengers” on notice.', 3);
INSERT INTO REVIEW (reviewer_id, movie_id, description, rating) VALUES (3, 4, 'If you don’t like Saw, this isn’t going to change your mind – but it’s skillful, satisfying schlock and respectful of its fanbase. And the final death is a show-stopping coup de grace.', 3);
INSERT INTO REVIEW (reviewer_id, movie_id, description, rating) VALUES (2, 4, 'There are a couple of impressive set pieces in “Jigsaw,” but the traps seem fairly rudimentary, and it’s up to the camera work to provide the needed jolts.', 2);
INSERT INTO REVIEW (reviewer_id, movie_id, description, rating) VALUES (1, 5, 'This movie consists of a boring story line with an unnecessary Christmas theme. While some of the actors gave me hope of this movie being watchable, you will only feel dread as it drags on and on without any memorable scenes and a bronze lining of generic nonsensical comedy. Nothing but a seasonal money grab, huge waste of time.', 1);
INSERT INTO REVIEW (reviewer_id, movie_id, description, rating) VALUES (1, 5, 'It’s by no means good, but there are moments of effective emotion and comedy that make up for some of the dumber jokes, and sheer charisma largely carries it along.', 1)

INSERT INTO MOVIE_ACT (movie_id, act_id) VALUES (1, 1);
INSERT INTO MOVIE_ACT (movie_id, act_id) VALUES (1, 2);
INSERT INTO MOVIE_ACT (movie_id, act_id) VALUES (1, 3);
INSERT INTO MOVIE_ACT (movie_id, act_id) VALUES (2, 4);
INSERT INTO MOVIE_ACT (movie_id, act_id) VALUES (2, 5);
INSERT INTO MOVIE_ACT (movie_id, act_id) VALUES (2, 6);
INSERT INTO MOVIE_ACT (movie_id, act_id) VALUES (3, 7);
INSERT INTO MOVIE_ACT (movie_id, act_id) VALUES (3, 8);
INSERT INTO MOVIE_ACT (movie_id, act_id) VALUES (3, 9);
INSERT INTO MOVIE_ACT (movie_id, act_id) VALUES (4, 10);
INSERT INTO MOVIE_ACT (movie_id, act_id) VALUES (4, 11);
INSERT INTO MOVIE_ACT (movie_id, act_id) VALUES (4, 12);
INSERT INTO MOVIE_ACT (movie_id, act_id) VALUES (5, 13);
INSERT INTO MOVIE_ACT (movie_id, act_id) VALUES (5, 14);
INSERT INTO MOVIE_ACT (movie_id, act_id) VALUES (5, 15);


INSERT INTO MOVIE_GENRE (movie_id, genre_name) VALUES (1, 'Action');
INSERT INTO MOVIE_GENRE (movie_id, genre_name) VALUES (1, 'Adventure');
INSERT INTO MOVIE_GENRE (movie_id, genre_name) VALUES (1, 'Comedy');
INSERT INTO MOVIE_GENRE (movie_id, genre_name) VALUES (1, 'Sci-Fi');
INSERT INTO MOVIE_GENRE (movie_id, genre_name) VALUES (2, 'Comedy');
INSERT INTO MOVIE_GENRE (movie_id, genre_name) VALUES (3, 'Action');
INSERT INTO MOVIE_GENRE (movie_id, genre_name) VALUES (3, 'Adventure');
INSERT INTO MOVIE_GENRE (movie_id, genre_name) VALUES (3, 'Sci-Fi');
INSERT INTO MOVIE_GENRE (movie_id, genre_name) VALUES (3, 'Fantasy');
INSERT INTO MOVIE_GENRE (movie_id, genre_name) VALUES (4, 'Crime');
INSERT INTO MOVIE_GENRE (movie_id, genre_name) VALUES (4, 'Horror');
INSERT INTO MOVIE_GENRE (movie_id, genre_name) VALUES (4, 'Mystery');
INSERT INTO MOVIE_GENRE (movie_id, genre_name) VALUES (5, 'Adventure');
INSERT INTO MOVIE_GENRE (movie_id, genre_name) VALUES (5, 'Comedy');

INSERT INTO MOVIE_DIRECTORS (movie_id, director_id) VALUES (1, 1);
INSERT INTO MOVIE_DIRECTORS (movie_id, director_id) VALUES (2, 2);
INSERT INTO MOVIE_DIRECTORS (movie_id, director_id) VALUES (3, 3);
INSERT INTO MOVIE_DIRECTORS (movie_id, director_id) VALUES (4, 4);
INSERT INTO MOVIE_DIRECTORS (movie_id, director_id) VALUES (5, 5);

INSERT INTO LANGUAGES_AVAIL (movie_id, language_name, subtitiles_avail) VALUES (1, 'English', 'T');
INSERT INTO LANGUAGES_AVAIL (movie_id, language_name, subtitiles_avail) VALUES (1, 'Spanish', 'F');
INSERT INTO LANGUAGES_AVAIL (movie_id, language_name, subtitiles_avail) VALUES (1, 'Mandarin', 'T');
INSERT INTO LANGUAGES_AVAIL (movie_id, language_name, subtitiles_avail) VALUES (2, 'English', 'T');
INSERT INTO LANGUAGES_AVAIL (movie_id, language_name, subtitiles_avail) VALUES (2, 'Spanish', 'F');
INSERT INTO LANGUAGES_AVAIL (movie_id, language_name, subtitiles_avail) VALUES (3, 'English', 'T');
INSERT INTO LANGUAGES_AVAIL (movie_id, language_name, subtitiles_avail) VALUES (3, 'Spanish', 'F');
INSERT INTO LANGUAGES_AVAIL (movie_id, language_name, subtitiles_avail) VALUES (4, 'English', 'T');
INSERT INTO LANGUAGES_AVAIL (movie_id, language_name, subtitiles_avail) VALUES (4, 'Spanish', 'T');
INSERT INTO LANGUAGES_AVAIL (movie_id, language_name, subtitiles_avail) VALUES (4, 'Mandarin', 'F');
INSERT INTO LANGUAGES_AVAIL (movie_id, language_name, subtitiles_avail) VALUES (5, 'English', 'T');
INSERT INTO LANGUAGES_AVAIL (movie_id, language_name, subtitiles_avail) VALUES (5, 'Spanish', 'F');
INSERT INTO LANGUAGES_AVAIL (movie_id, language_name, subtitiles_avail) VALUES (5, 'Mandarin', 'F');

INSERT INTO TICKET (movie_date, start_time, fname, lname, seat_num, row_num, movie, theater) VALUES ('2017-12-22', '10:40:00', 'Isaiah', 'Herrera', 1, 1, 1, 1);
INSERT INTO TICKET (movie_date, start_time, fname, lname, seat_num, row_num, movie, theater) VALUES ('2017-12-22', '10:40:00', 'John', 'Doe', 2, 1, 1, 1);
INSERT INTO TICKET (movie_date, start_time, fname, lname, seat_num, row_num, movie, theater) VALUES ('2017-11-27', '09:15:00', 'Cole', 'Polychronis', 2, 1, 3, 3);
INSERT INTO TICKET (movie_date, start_time, fname, lname, seat_num, row_num, movie, theater) VALUES ('2017-11-30', '11:45:00', 'Matthew', 'Gerber', 1, 1, 4, 2);
INSERT INTO TICKET (movie_date, start_time, fname, lname, seat_num, row_num, movie, theater) VALUES ('2017-12-23', '05:50:00', 'Taylor', 'Page', 2, 1, 5, 3);

INSERT INTO TICKET_SALES (pool_id, ticket_num) VALUES (1, 1);
INSERT INTO TICKET_SALES (pool_id, ticket_num) VALUES (1, 2);
