select * from countrylanguage;
select * from city;
select capital from country;

--1. What are the top 10 most populous cities in the dataset?  
SELECT id , name , population
FROM city
ORDER BY population DESC
LIMIT 10;

-- *2. Which continent has the highest average population density?*** 

SELECT continent , ROUND(AVG(population/surfacearea):: NUMERIC,4) AS AVG_POP_DENS
FROM country
GROUP BY continent
ORDER BY AVG_POP_DENS DESC
LIMIT 1;



-- *3. What are the top 10 largest countries by surface area?

SELECT code , name , surfacearea
FROM country
ORDER BY surfacearea DESC
LIMIT 10;

-- *6. Which country has the highest GNP per capita?
SELECT code,name,
CASE 
WHEN population = 0 THEN '0'
ELSE ROUND((gnp/population)*10^6 ::numeric, 2)
END AS gnp_per_captia
FROM country
ORDER BY gnp_per_captia DESC
LIMIT 1;

-- *9. How many countries have English as an official language?  
SELECT COUNT(countrycode) AS ENG_COUNTRIES
FROM countrylanguage
WHERE language = 'English' AND isofficial = true;


-- *10. What is the average life expectancy for each continent?  
SELECT continent, ROUND(AVG(lifeexpectancy)) AS AVG_life_exp
FROM country
GROUP BY continent; 

-- *12. Which countries have the highest population density?

SELECT code, name, ROUND(population/surfacearea :: NUMERIC,4) AS AVG_POP_DENS
FROM country
GROUP BY code, name
ORDER BY AVG_POP_DENS DESC
;

-- *13. What percentage of each country's population lives in its capital 

SELECT 
    co.name AS country,
    ci.name AS capital_city,
    ROUND(
        (ci.population::NUMERIC / co.population) * 100, 
        2
    ) AS percentage_in_capital
FROM country co
JOIN city ci 
    ON co.capital = ci.id 
ORDER BY percentage_in_capital DESC;
-- *14. Which continents have the highest number of official languages? 
SELECT 
c.continent,
COUNT(*) AS official_language_count
FROM country c
JOIN countrylanguage cl 
ON c.code = cl.countrycode
WHERE cl.isofficial = true 
GROUP BY c.continent
ORDER BY official_language_count DESC;
-- *15. What is the average GNP per continent? 
SELECT continent,ROUND(AVG(gnp), 2) AS average_gnp
FROM country
GROUP BY continent
ORDER BY average_gnp DESC;


For Schema 'https://www.db-fiddle.com/f/teuRYv6YW1a6dYQC6RJwxu/214'
