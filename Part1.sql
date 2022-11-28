--Select Basics Tutorial 0

SELECT population FROM world
  WHERE name = 'Germany';
  
SELECT name, population FROM world
  WHERE name IN ('Sweden', 'Norway', 'Denmark');

SELECT name, area FROM world
  WHERE area BETWEEN 200000 AND 250000;


----------------------------------------------------------------------------------------
--SELECT names Tutorial 1

--1 
--Find the country that start with Y

SELECT name FROM world
  WHERE name LIKE 'Y%';

--2
--Find the countries that end with y

SELECT name FROM world
  WHERE name LIKE '%Y';

--3
--Find the countries that contain the letter x

SELECT name FROM world
  WHERE name LIKE '%x%';

--4. Find the countries that end with land

SELECT name FROM world
  WHERE name LIKE '%land';

--5. Find the countries that start with C and end with ia

SELECT name FROM world
  WHERE name LIKE 'C%ia';

--6. Find the country that has oo in the name

SELECT name FROM world
  WHERE name LIKE '%oo%';

--7. Find the countries that have three or more a in the name

SELECT name FROM world
  WHERE name LIKE '%a%a%a%';

--8. Find the countries that have "t" as the second character.

SELECT name FROM world
 WHERE name LIKE '_t%'
ORDER BY name;

--9. Find the countries that have two "o" characters separated by two others.

SELECT name FROM world
 WHERE name LIKE '%o__o%';

--10. Find the countries that have exactly four characters.

SELECT name FROM world
 WHERE name LIKE '____';

--11. Find the country where the name is the capital city.

SELECT name
  FROM world
 WHERE name = capital;

--12. Find the country where the capital is the country plus "City".

SELECT name
  FROM world
 WHERE capital = concat(name, ' City');

--13. Find the capital and the name where the capital includes the name of the country.

SELECT capital,name FROM world WHERE capital LIKE concat('%', name, '%');

--14. Find the capital and the name where the capital is an extension of name of the country.

SELECT name, capital FROM world WHERE capital LIKE concat('%', name, '%') AND capital > name;

--15. Show the name and the extension where the capital is an extension of name of the country.

SELECT name, REPLACE(capital, name, '') 
    FROM world WHERE capital LIKE concat('%', name, '%') AND capital > name;

----------------------------------------------------------------------------------------
--SELECT from WORLD Tutorial 2


--1 show the name, continent and population of all countries.

SELECT name, continent, population
  FROM world;

-- 2. Show the name for the countries that have a population of at least
-- 200 million. 200 million is 200000000, there are eight zeros.

SELECT name
  FROM world
 WHERE population > 200000000;

-- 3. Give the name and the per capita GDP for those countries
-- with a population of at least 200 million.

SELECT name, gdp/population
  FROM world
 WHERE population > 200000000;

-- 4. Show the name and population in millions for the countries
-- of the continent 'South America'. Divide the population by 1000000
-- to get population in millions.

SELECT name, population/1000000
  FROM world
 WHERE continent = 'South America';

-- 5. Show the name and population for France, Germany, Italy.

SELECT name, population
  FROM world
 WHERE name IN ('France', 'Germany', 'Italy');

-- 6. Show the countries which have a name that includes the word 'United'.

SELECT name
  FROM world
 WHERE name LIKE 'United%';

-- 7. Show the countries that are big by area or big by population.
-- Show name, population and area.

SELECT name, population, area
  FROM world
 WHERE area > 3000000
    OR population > 250000000;

-- 8. Show the countries that are big by area or big by population
-- but not both. Show name, population and area.

SELECT name, population, area
  FROM world
 WHERE area > 3000000
   XOR population > 250000000;

-- 9. For South America show population in millions and GDP in billions
-- both to 2 decimal places.

SELECT name, ROUND(population/1000000, 2), ROUND(gdp/1000000000, 2)
  FROM world
 WHERE continent = 'South America';

-- 10. Show per-capita GDP for the trillion dollar countries
-- to the nearest $1000.

SELECT name, ROUND(gdp/population, -3)
  FROM world
 WHERE gdp > 1000000000000;

-- 11. Show the name and capital where the name and the capital have
-- the same number of characters.

SELECT name, capital
  FROM world
 WHERE LENGTH(name) = LENGTH(capital);

-- 12. Show the name and the capital where the first letters of each match.
-- Don't include countries where the name and the capital are the same word.

SELECT name, capital
  FROM world
 WHERE LEFT(name, 1) = LEFT(capital, 1)
   AND name <> capital;

-- 13. Find the country that has all the vowels and no spaces in its name.

SELECT name
  FROM world
 WHERE name     LIKE '%a%'
   AND name     LIKE '%e%'
   AND name     LIKE '%i%'
   AND name     LIKE '%o%'
   AND name     LIKE '%u%'
   AND name NOT LIKE '% %';


----------------------------------------------------------------------------------------------------
--SELECT from Nobel Tutorial 3

--1 Change the query shown so that it displays Nobel prizes for 1950.

SELECT *
  FROM nobel
 WHERE yr = 1950


--2 Show who won the 1962 prize for literature.

SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'literature'

--3 Show the year and subject that won 'Albert Einstein' his prize.

SELECT yr, subject
  FROM nobel
WHERE winner = 'Albert Einstein';

--4 Give the name of the 'peace' winners since the year 2000, including 2000.

SELECT winner
  From nobel
WHERE subject = 'peace' AND yr >= 2000;

--5 Show all details (yr, subject, winner) of the literature prize winners for 1980 to 1989 inclusive.

SELECT *
  FROM nobel
WHERE subject = 'literature' AND yr BETWEEN 1980 AND 1989;

--6 Show all details of the presidential winners:

--Theodore Roosevelt
--Thomas Woodrow Wilson
--Jimmy Carter
--Barack Obama

SELECT * FROM nobel
 WHERE winner IN ('Theodore Roosevelt',
                  'Woodrow Wilson',
                  'Jimmy Carter',
                  'Barack Obama')

--7 Show the winners with first name John

SELECT winner FROM nobel
 WHERE winner LIKE 'JOHN%'

--8 Show the Physics winners for 1980 together with the Chemistry winners for 1984.

SELECT * FROM nobel
 WHERE (subject = 'Physics' AND yr = 1980)
 OR (subject = 'Chemistry' AND yr = 1984)

--9 Show the winners for 1980 excluding the Chemistry and Medicine

SELECT * FROM nobel 
 WHERE yr = 1980 
 AND subject NOT IN ('CHEMISTRY',
                     'MEDICINE')

--10 Show who won a 'Medicine' prize in an early year (before 1910, not including 1910) together with winners of a 'Literature' prize in a later year (after 2004, including 2004)

SELECT * FROM nobel 
 WHERE (subject = 'Medicine' AND yr < 1910)
 OR (subject = 'Literature' AND yr >= 2004)

--11 Find all details of the prize won by PETER GRÜNBERG

SELECT * FROM nobel
 WHERE winner = 'PETER GRÜNBERG'

--12 Find all details of the prize won by EUGENE O'NEILL

SELECT * FROM nobel
 WHERE winner = 'EUGENE O''NEILL'

--13  Knights in order
--List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order.

SELECT winner, yr, subject FROM nobel 
 WHERE winner LIKE 'Sir%'
 ORDER BY yr DESC, winner 

--14 The expression subject IN ('Chemistry','Physics') can be used as a value - it will be 0 or 1.
--Show the 1984 winners and subject ordered by subject and winner name; but list Chemistry and Physics last.

SELECT winner, subject 
  FROM nobel
  WHERE yr=1984
  ORDER BY subject IN ('Physics','Chemistry'), subject,winner
