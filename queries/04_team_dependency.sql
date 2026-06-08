USE ipl_analysis;

-- QUERY 3: Team Dependency Analysis
-- Business question: Which teams have a single-player risk?
-- Technique: Window Function — SUM() OVER (PARTITION BY Team)

SELECT
    Team,
    Player,
    Runs,
    ROUND(Runs * 100.0 / SUM(Runs) OVER (PARTITION BY Team), 2) AS pct_of_team_runs
FROM batsmen_2019
ORDER BY Team, pct_of_team_runs DESC;
