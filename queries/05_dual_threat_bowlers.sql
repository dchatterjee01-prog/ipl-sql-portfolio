USE ipl_analysis;

-- QUERY 4: Dual-Threat Bowlers (Economical + Wicket-Taking)
-- Business question: Who gives you control AND breakthroughs?
-- Formula: (Wkts x 10) - (ER x 5) - (Avg x 0.5)

SELECT
    Player,
    Team,
    Wkts,
    Avg,
    E_R,
    S_R,
    ROUND((Wkts * 10) - (E_R * 5) - (Avg * 0.5), 2) AS bowling_impact_score
FROM bowlers_2019
WHERE Overs >= 20
ORDER BY bowling_impact_score DESC
LIMIT 10;
