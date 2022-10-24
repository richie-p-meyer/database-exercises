USE albums_db;

SELECT * 
FROM albums;

DESCRIBE albums;

SELECT DISTINCT artist
FROM albums;

SELECT release_date
FROM albums;

/*
How many rows are in the albums table?
31

How many unique artist names are in the albums table?
23

What is the primary key for the albums table?
id

What is the oldest release date for any album in the albums table? What is the most recent release date?
Oldest - 1967
Most Recent - 2011

*/

-- The name of all albums by Pink Floyd

SELECT name
FROM albums
WHERE artist = 'Pink Floyd';

-- The Dark Side of the Moon, The Wall

-- The year Sgt. Pepper's Lonely Hearts Club Band was released
SELECT release_date
FROM albums
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";
-- 1967

-- The genre for the album Nevermind
SELECT genre
FROM albums
WHERE name = 'Nevermind';
-- Grunge, Alternative rock

-- Which albums were released in the 1990s
SELECT name
FROM albums
WHERE release_date BETWEEN '1990-01-01' AND '1999-12-31';
/*
The Bodyguard
Jagged Little Pill
Come On Over
Falling into You
Let's Talk About Love
Dangerous
The Immaculate Collection
Titanic: Music from the Motion Picture
Metallica
Nevermind
Supernatural
*/

-- Which albums had less than 20 million certified sales
SELECT name
FROM albums
WHERE sales <= 20000000;
-- All of them (31)

/*
All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
*/
SELECT name
FROM albums
WHERE genre = 'Rock';
/*
Sgt. Pepper's Lonely Hearts Club Band
1
Abbey Road
Born in the U.S.A.
Supernatural

The genre must match 'Rock' exactly.
*/
