-- Creating Table 

CREATE TABLE matches (
    match_id INT PRIMARY KEY,
    team VARCHAR(100) NOT NULL,
    opponent_team VARCHAR(100) NOT NULL,
    match_date DATE NOT NULL,
    venue VARCHAR(100),
    season VARCHAR(10),
    runs_scored INT NOT NULL,
    wickets_lost INT NOT NULL,
    overs_faced INT NOT NULL,
    runs_conceded INT NOT NULL,
    wickets_taken INT NOT NULL,
    match_result VARCHAR(100),
    man_of_the_match VARCHAR(100)
);

------------------------------------------------------------------------------------------------
-- Importing Data Into Table 

COPY
matches (match_id, team, opponent_team, match_date, venue, season, runs_scored, wickets_lost,
overs_faced, runs_conceded, wickets_taken, match_result, man_of_the_match)
FROM 'C:\NextLeap\Cases\Case 8 SQL\Case 4 Data - SQL Basics - matches.csv'
DELIMITER ','
CSV HEADER;

select * from matches;

----------------------------------------------------------------------------------------------

-- Q1: Total Matches Won by Each Team
SELECT match_result AS team, COUNT(*) AS total_wins 
FROM matches 
WHERE match_result IS NOT NULL 
GROUP BY match_result 
ORDER BY total_wins DESC;


-- Q2: Top Teams with High Average Runs Scored (>130 runs, >50 matches)
SELECT team, ROUND(AVG(runs_scored), 2) AS avg_runs, COUNT(*) AS total_matches 
FROM matches 
GROUP BY team 
HAVING AVG(runs_scored) > 130 AND COUNT(*) > 50 
ORDER BY avg_runs DESC;


-- Q3: Matches with Low Wickets Lost (fewer than 3 wickets)
SELECT match_id, team, runs_scored, wickets_lost 
FROM matches 
WHERE wickets_lost < 3;


-- Q4: Average Runs Conceded Rounded to Two Decimal Places
SELECT ROUND(AVG(runs_conceded), 2) AS avg_runs_conceded 
FROM matches;


-- Q5: Matches at Specific Venues (venues starting with 'M')
SELECT match_id, match_date, venue, team 
FROM matches 
WHERE venue LIKE 'M%';


-- Q6: Total Runs Scored with Run Rate Calculations
SELECT 
    SUM(runs_scored) AS total_runs, 
    ROUND(CAST(SUM(runs_scored) AS NUMERIC) / SUM(overs_faced), 2) AS overall_run_rate 
FROM matches;


-- Q7: Top Bowlers / Teams Based on Wickets Taken (>200 wickets, Top 3)
SELECT team, SUM(wickets_taken) AS total_wickets 
FROM matches 
GROUP BY team 
HAVING SUM(wickets_taken) > 200 
ORDER BY total_wickets DESC 
LIMIT 3;


