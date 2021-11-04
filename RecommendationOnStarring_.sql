cd RSL


psql test


CREATE TABLE movies_starring (
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


\copy movies_starring FROM '/home/pi/RSL/moviesfrommeta.csv' delimiter ';' csv header ;


ALTER TABLE movies_starring
ADD lexemesStarring tsvector;


UPDATE movies_starring SET lexemesStarring = to_tsvector(Starring) ;


ALTER TABLE movies_starring
ADD rank float4;


UPDATE movies_starring SET rank = ts_rank(lexemesStarring,plainto_tsquery((
SELECT Starring FROM movies_starring WHERE url='skyfall'))) ;


CREATE TABLE recommendationsOnStarring AS
SELECT url, rank FROM movies_starring WHERE rank > 0.1 ORDER BY rank DESC LIMIT 50;


\copy (select * from recommendationsOnStarring) to '/home/pi/RSL/top13recommendationsOnStarring.csv' with csv ;
