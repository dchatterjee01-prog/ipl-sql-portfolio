USE ipl_analysis;

-- QUERY 5: Best Value Players (Impact Per Match)
-- Business question: Who consistently delivers every single game?
-- Technique: UNION ALL to combine batsmen and bowlers in one ranking

SELECT
    Player,
    Team,
    'Batsman' AS role,
    Mat,
    Runs,
    ROUND(Runs / Mat, 2) AS runs_per_match,
    ROUND(S_R, 2) AS strike_rate,
    ROUND((Runs / Mat) * (S_R / 100), 2) AS value_index
FROM batsmen_2019
WHERE Mat >= 10

UNION ALL

SELECT
    Player,
    Team,
    'Bowler' AS role,
    Mat,
    Wkts AS runs,
    ROUND(Wkts / Mat, 2) AS runs_per_match,
    ROUND(E_R, 2) AS strike_rate,
    ROUND((Wkts / Mat) * (10 - E_R), 2) AS value_index
FROM bowlers_2019
WHERE Mat >= 10 AND Overs >= 20

ORDER BY value_index DESC
LIMIT 15;
