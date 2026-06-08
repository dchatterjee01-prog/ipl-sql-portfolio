USE ipl_analysis;

-- Row count verification
SELECT 'batsmen_2018' AS table_name, COUNT(*) AS row_count FROM batsmen_2018
UNION ALL
SELECT 'batsmen_2019', COUNT(*) FROM batsmen_2019
UNION ALL
SELECT 'bowlers_2018', COUNT(*) FROM bowlers_2018
UNION ALL
SELECT 'bowlers_2019', COUNT(*) FROM bowlers_2019;

-- Peek at batsmen data
SELECT * FROM batsmen_2018 LIMIT 5;

-- Check HS column
SELECT Player, HS FROM batsmen_2018 WHERE HS LIKE '%*%' LIMIT 10;

-- Peek at bowlers data
SELECT * FROM bowlers_2019 LIMIT 5;
