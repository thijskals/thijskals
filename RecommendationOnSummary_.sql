cd RSL


psql test


CREATE TABLE movies (
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


\copy movies FROM '/home/pi/RSL/moviesfrommeta.csv' delimiter ';' csv header ;


ALTER TABLE movies
ADD lexemesSummary tsvector;


UPDATE movies SET lexemesSummary = to_tsvector(Summary) ;


ALTER TABLE movies
ADD rank float4;


UPDATE movies SET rank = ts_rank(lexemesSummary,plainto_tsquery((
SELECT Summary FROM movies WHERE url='skyfall'))) ;


CREATE TABLE recommendationsOnSummary AS
SELECT url, rank FROM movies WHERE rank > 0.1 ORDER BY rank DESC LIMIT 50;


\copy (select * from recommendationsOnSummary) to '/home/pi/RSL/top13recommendationsOnSummary.csv' with csv ;
