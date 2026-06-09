<div align="center">

# 🏏 IPL Franchise Scout Analysis
### A SQL-Powered Player Acquisition Model

[![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Python](https://img.shields.io/badge/Python-3.x-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![Status](https://img.shields.io/badge/Status-Complete-0f9b6e?style=for-the-badge)]()
[![Rows](https://img.shields.io/badge/Data-200_Rows-e8a838?style=for-the-badge)]()

<br>

> **"If I had ₹10 Crore to buy 2 batsmen and 2 bowlers for IPL 2020 — who do I pick, and why?"**

*This is not a student assignment. Every query answers a real business question.*
*The final deliverable is a consulting-style player acquisition recommendation — backed entirely by data.*

<br>

[📊 View Presentation](https://cheery-cranachan-51ca07.netlify.app/outputs/ipl_presentation.html) &nbsp;·&nbsp; [📄 Scout Report](outputs/scout_report.md) &nbsp;·&nbsp; [🗄️ SQL Queries](queries/)

</div>

---

## 🎯 The Business Problem

Franchise decisions in T20 cricket are often driven by big names and gut feel. Reputation is a lagging indicator — it tells you who *was* good, not who *is* in form. I built a **5-query SQL pipeline** to answer the franchise scouting question with data.

---

## ⚡ Quick Summary

| | |
|---|---|
| 🛢️ **Database** | MySQL 8.0 + MySQL Workbench |
| 🐍 **Import** | Python (`pandas` + `mysql-connector-python`) |
| 📦 **Dataset** | IPL 2018 & 2019 — 200 rows across 4 tables |
| 🔧 **SQL Techniques** | JOINs · CTEs · Window Functions · UNION ALL · Custom Scoring |
| 🏆 **Output** | Data-driven squad recommendation within ₹10 Crore |

---

## 🗺️ Analytical Pipeline

```
Business Question → SQL Query → Insight → Recommendation
```

| # | Business Question | SQL Technique | Key Finding |
|---|---|---|---|
| Q1 | Who are the most **consistent** run-scorers? | Custom weighted formula | Warner 127.76 · Russell 109.78 |
| Q2 | Who **improved** heading into 2020? | `JOIN` across 2 seasons | Russell +27.94 avg · Pandya +58 SR |
| Q3 | Which teams are **over-reliant** on one player? | `SUM() OVER (PARTITION BY)` | Warner = 34.67% of SRH runs |
| Q4 | Who are the **dual-threat** bowlers? | Multi-metric impact formula | Rashid ER 6.74 · 21 wickets |
| Q5 | Who delivers **value per match**? | `UNION ALL` combined ranking | Warner 82.97 · Russell 74.61 |
| 🏆 | **Final squad selection** | `WITH` CTE composite score | Russell · Rahul · Rashid · Bumrah |

---

## 🏆 Final Scout Recommendation

> *Combined scoring model: Consistency (40%) + YoY Improvement (30%) + Value per Match (30%)*

<table>
  <tr>
    <th>Pick</th>
    <th>Player</th>
    <th>Role</th>
    <th>Team</th>
    <th>Key Stats</th>
    <th>Final Score</th>
    <th>Why</th>
  </tr>
  <tr>
    <td>🥇</td>
    <td><strong>Andre Russell</strong></td>
    <td>Batsman</td>
    <td>KKR</td>
    <td>SR 204 · Avg 56 · +27.94 YoY</td>
    <td><strong>74.68</strong></td>
    <td>Most explosive + most improved in 2019</td>
  </tr>
  <tr>
    <td>🥈</td>
    <td><strong>KL Rahul</strong></td>
    <td>Batsman</td>
    <td>KXIP</td>
    <td>593 runs · 6 fifties · SR 135</td>
    <td><strong>59.93</strong></td>
    <td>Highest volume + safest batting anchor</td>
  </tr>
  <tr>
    <td>🥇</td>
    <td><strong>Rashid Khan</strong></td>
    <td>Bowler</td>
    <td>SRH</td>
    <td>21 wkts · ER 6.74 · SR 19.43</td>
    <td><strong>67.37</strong></td>
    <td>Best economy + wickets combo in dataset</td>
  </tr>
  <tr>
    <td>🥈</td>
    <td><strong>Jasprit Bumrah</strong></td>
    <td>Bowler</td>
    <td>MI</td>
    <td>17 wkts · ER 6.89 · death specialist</td>
    <td><strong>50.98</strong></td>
    <td>Pressure every over · elite T20 death bowler</td>
  </tr>
</table>

---

## 💡 SQL Techniques Demonstrated

```sql
-- Window Function: Team Dependency Analysis
SELECT Player, Team,
    ROUND(Runs * 100.0 / SUM(Runs) OVER (PARTITION BY Team), 2) AS pct_of_team_runs
FROM batsmen_2019
ORDER BY Team, pct_of_team_runs DESC;
```

```sql
-- CTE: Final Composite Scoring Model
WITH batsman_scores AS (
    SELECT b19.Player, b19.Team,
        ROUND((b19.Avg*0.5)+(b19.S_R*0.3)+((b19.Fifties+b19.Hundreds*2)*5),2) AS consistency_score,
        ROUND(b19.Avg - b18.Avg, 2) AS avg_improvement
    FROM batsmen_2019 b19
    JOIN batsmen_2018 b18 ON b19.Player = b18.Player
    WHERE b19.Inns >= 8 AND b18.Inns >= 8
)
SELECT *, ROUND((consistency_score*0.4)+(avg_improvement*0.3), 2) AS final_score
FROM batsman_scores
ORDER BY final_score DESC;
```

| Technique | File | Purpose |
|---|---|---|
| `JOIN` across tables | `03_yoy_form_analysis.sql` | Compare 2018 vs 2019 performance |
| `SUM() OVER (PARTITION BY)` | `04_team_dependency.sql` | Player % contribution to team runs |
| `WITH` CTE | `07_final_recommendation.sql` | Multi-step composite scoring |
| `UNION ALL` | `06_value_per_match.sql` | Combine batsmen + bowlers in one ranking |
| Custom formula | `02_consistency_score.sql` | Weighted consistency index |
| Python bulk import | `00_data_import.py` | Auto-create DB + load all 4 tables |

---

## 📁 Repository Structure

```
ipl_sql_portfolio/
│
├── 📂 data/
│   ├── batsmen_2018.csv        ← 50 rows · 13 columns
│   ├── batsmen_2019.csv        ← 50 rows · 13 columns
│   ├── bowlers_2018.csv        ← 50 rows · 11 columns
│   └── bowlers_2019.csv        ← 50 rows · 11 columns
│
├── 📂 queries/
│   ├── 00_data_import.py       ← Python: auto-create DB + load CSVs
│   ├── 01_data_verification.sql
│   ├── 02_consistency_score.sql
│   ├── 03_yoy_form_analysis.sql
│   ├── 04_team_dependency.sql
│   ├── 05_dual_threat_bowlers.sql
│   ├── 06_value_per_match.sql
│   └── 07_final_recommendation.sql
│
├── 📂 outputs/
│   ├── ipl_presentation.html   ← Interactive 10-slide deck
│   └── scout_report.md         ← Consulting-style final report
│
└── README.md
```

---

## 🛠️ Setup & Run

**1. Install dependencies:**
```bash
pip install pandas mysql-connector-python
```

**2. Run the import script:**
```bash
python queries/00_data_import.py
```

**3. Open MySQL Workbench and run queries in order:**
```
queries/01 → 02 → 03 → 04 → 05 → 06 → 07
```

---

## 🗄️ Data Quality Handling

| Issue | Solution |
|---|---|
| `HS` column has not-out notation (`91*`) | Stored as `VARCHAR` — strip `*` when casting numerically |
| Column name mismatch (`Four_Wickets` vs `Four_wickets`) | Normalised in Python import script |
| MySQL Wizard dropped 6 rows on import | Fixed by switching to Python bulk insert |

---

<div align="center">

## 👤 Author

**Daipayan Chatterjee**

[![GitHub](https://img.shields.io/badge/GitHub-dchatterjee01--prog-181717?style=for-the-badge&logo=github)](https://github.com/dchatterjee01-prog)

<br>

*This project is framed as a Franchise Scout Analysis.*
*Every query answers a business question.*
*The goal was not just to write SQL — but to think like an analyst.*

</div>
