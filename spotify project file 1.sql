-- create table
DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);


--EDA

select COUNT(*) from spotify;
select COUNT(DISTINCT album) from spotify;
select COUNT(DISTINCT artist) from spotify;
select DISTINCT album_type from spotify;


select duration_min from spotify;
select MAX(duration_min) from spotify;
select MIN(duration_min) from spotify;
select * from spotify
WHERE duration_min =0;
--Deleting the songs with duration=0
DELETE from spotify
WHERE duration_min =0;

SELECT DISTINCT channel from spotify;
SELECT DISTINCT most_played_on from spotify;


------------------------------------------------>>>>>>>>>>>>>>
-- EASY CATEGORY PROBS(group by, subqueries):

--1.Retrieve the names of all tracks that have more than 1 billion streams.
select * from spotify
where stream >1000000000;

--2.List all albums along with their respective artists.
SELECT album, artist from spotify
order by 1;  --order by first column

--3.Get the total number of comments for tracks where licensed = TRUE.
-- select distinct licensed from spotify;
select sum(comments) as total_comments
	from spotify
where licensed = true;     --we can use ILIKE also


--4.Find all tracks that belong to the album type single.
select * from spotify
where album_type ILIKE 'single';


--5.Count the total number of tracks by each artist.
select 
	artist,     --1
	COUNT(*)as total_songs   --2
	from spotify
GROUP BY artist
ORDER BY 2 ASC;


-- MEDIUM CATEGORY PROBS(group by, subqueries):

--1.Calculate the average danceability of tracks in each album.
select
	album, 
	AVG(danceability)
	from spotify
GROUP BY 1
ORDER BY 2 desc
;

--2.Find the top 5 tracks with the highest energy values.
SELECT track, MAX(energy)
FROM spotify
GROUP BY 1
ORDER BY 2 desc
	LIMIT 5;


--3.List all tracks along with their views and likes where official_video = TRUE.
SELECT track, SUM(views), SUM(likes)
from spotify
WHERE official_video='true'
GROUP BY track;


--4.For each album, calculate the total views of all associated tracks.
SELECT album, track , SUM(views) as total_views
from spotify
GROUP BY 1, 2
ORDER BY 3 DESC;


--5.Retrieve the track names that have been streamed on Spotify more than YouTube.
SELECT track from spotify
WHERE most_played_on= 'Spotify'
GROUP BY track;