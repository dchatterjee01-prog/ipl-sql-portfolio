USE ipl_analysis;

-- FINAL QUERY: The Rs.10 Crore Squad Selection
-- Combining consistency, YoY improvement, and value per match into one final_score
-- Technique: CTEs (WITH clauses) + UNION ALL

WITH batsman_scores AS (
    SELECT
        b19.Player,
        b19.Team,
        'Batsman' AS role,
        ROUND((b19.Avg * 0.5) + (b19.S_R * 0.3) + ((b19.Fifties + b19.Hundreds * 2) * 5), 2) AS consistency_score,
        ROUND(b19.Avg - b18.Avg, 2) AS avg_improvement,
        ROUND(b19.Runs / b19.Mat * b19.S_R / 100, 2) AS value_index
    FROM batsmen_2019 b19
    JOIN batsmen_2018 b18 ON b19.Player = b18.Player
    WHERE b19.Inns >= 8 AND b18.Inns >= 8
),
bowler_scores AS (
    SELECT
        b19.Player,
        b19.Team,
        'Bowler' AS role,
        ROUND((b19.Wkts * 10) - (b19.E_R * 5) - (b19.Avg * 0.5), 2) AS consistency_score,
        ROUND(b19.Wkts - b18.Wkts, 2) AS avg_improvement,
        ROUND(b19.Wkts / b19.Mat * (10 - b19.E_R), 2) AS value_index
    FROM bowlers_2019 b19
    JOIN bowlers_2018 b18 ON b19.Player = b18.Player
    WHERE b19.Overs >= 20 AND b18.Overs >= 20
)

SELECT
    Player,
    Team,
    role,
    consistency_score,
    avg_improvement,
    value_index,
    ROUND((consistency_score * 0.4) + (avg_improvement * 0.3) + (value_index * 0.3), 2) AS final_score
FROM batsman_scores
UNION ALL
SELECT
    Player,
    Team,
    role,
    consistency_score,
    avg_improvement,
    value_index,
    ROUND((consistency_score * 0.4) + (avg_improvement * 0.3) + (value_index * 0.3), 2) AS final_score
FROM bowler_scores
ORDER BY role, final_score DESC
LIMIT 20;
