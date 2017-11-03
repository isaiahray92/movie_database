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
FOREIGN(movie_id) REFERENCES MOVIE(movie_id),
FOREIGN(theater_num) REFERENCES THEATER_ROOM(theater_num)
);

CREATE TABLE CUSTOMER 
(
reward VARCHAR(15),
credit_card INT,
PRIMARY KEY(fname),
PRIMARY KEY(lname)
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
FOREIGN KEY(reviewer) REFEENCES REVIEWS_MADE(reviewer_id)
);
























