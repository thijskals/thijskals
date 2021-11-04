cd RSL


psql test


CREATE TABLE movies_title (
url text,
title text,
ReleaseDate text,
Distributor text,
Starring text,
Summary text,
Director text,
Genre text,
Rating text,
Runtime text,
Userscore text,
Metascore text,
scoreCounts text);


\copy movies_title FROM '/home/pi/RSL/moviesfrommeta.csv' delimiter ';' csv header ;


ALTER TABLE movies_title
ADD lexemestitle tsvector;


UPDATE movies_title SET lexemestitle = to_tsvector(title) ;


ALTER TABLE movies_title
ADD rank float4;


UPDATE movies_title SET rank = ts_rank(lexemestitle,plainto_tsquery((
SELECT title FROM movies_title WHERE url='skyfall'))) ;


CREATE TABLE recommendationsOnTitle AS
SELECT url, rank FROM movies_title WHERE rank > 0.01 ORDER BY rank DESC LIMIT 50;


\copy (select * from recommendationsOntitle) to '/home/pi/RSL/top13recommendationsOnTitle.csv' with csv ;
