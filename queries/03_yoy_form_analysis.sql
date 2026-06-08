USE ipl_analysis;

-- QUERY 2: Year-on-Year Form Analysis (2018 vs 2019)
-- Business question: Who IMPROVED heading into IPL 2020? Form matters more than reputation.

SELECT
    b19.Player,
    b19.Team,
    b18.Runs AS runs_2018,
    b19.Runs AS runs_2019,
    b18.Avg  AS avg_2018,
    b19.Avg  AS avg_2019,
    ROUND(b19.Avg - b18.Avg, 2) AS avg_improvement,
    b18.S_R  AS sr_2018,
    b19.S_R  AS sr_2019,
    ROUND(b19.S_R - b18.S_R, 2) AS sr_improvement
FROM batsmen_2019 b19
JOIN batsmen_2018 b18 ON b19.Player = b18.Player
WHERE b19.Inns >= 8 AND b18.Inns >= 8
ORDER BY avg_improvement DESC
LIMIT 10;
