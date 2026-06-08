USE ipl_analysis;

-- QUERY 1: Top Batsmen by Consistency Score (2019)
-- Business question: Who are the most RELIABLE run-scorers, not just big hitters?
-- Formula: (Avg x 0.5) + (SR x 0.3) + ((Fifties + Centuries x 2) x 5)

SELECT
    Player,
    Team,
    Runs,
    Inns,
    Avg,
    S_R,
    Fifties,
    Hundreds,
    ROUND((Avg * 0.5) + (S_R * 0.3) + ((Fifties + Hundreds * 2) * 5), 2) AS consistency_score
FROM batsmen_2019
WHERE Inns >= 8
ORDER BY consistency_score DESC
LIMIT 10;
