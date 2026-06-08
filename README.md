# 🏏 IPL Franchise Scout — SQL Portfolio Project

> *"If I had ₹10 Crore to buy 2 batsmen and 2 bowlers for IPL 2020 — who do I pick, and why?"*

A recruiter-level SQL portfolio project framed as a **Franchise Scout Analysis** — not a student assignment. Every query answers a real business question. The final deliverable is a consulting-style player acquisition recommendation backed entirely by data.

---

## 📌 Project Summary

| Item | Detail |
|---|---|
| **Tool** | MySQL 8.0 + MySQL Workbench |
| **Data** | IPL 2018 & 2019 — Batsmen & Bowlers stats |
| **Rows** | 200 rows across 4 tables |
| **Techniques** | JOINs, CTEs, Window Functions, UNION ALL, Custom Scoring |
| **Goal** | Player acquisition recommendation within ₹10 Crore budget |

---

## 📁 Folder Structure

```
ipl_sql_portfolio/
│
├── data/
│   ├── batsmen_2018.csv
│   ├── batsmen_2019.csv
│   ├── bowlers_2018.csv
│   └── bowlers_2019.csv
│
├── queries/
│   ├── 00_data_import.py
│   ├── 01_data_verification.sql
│   ├── 02_consistency_score.sql
│   ├── 03_yoy_form_analysis.sql
│   ├── 04_team_dependency.sql
│   ├── 05_dual_threat_bowlers.sql
│   ├── 06_value_per_match.sql
│   └── 07_final_recommendation.sql
│
├── outputs/
│   └── scout_report.md
│
└── README.md
```

---

## 🗄️ Dataset Details

**4 CSV files — IPL 2018 & 2019 (Top 50 players each year)**

**Batsmen columns:** `Player, Team, Mat, Inns, NO, Runs, HS, Hundreds, Fifties, Avg, S_R, Fours, Sixs`

**Bowlers columns:** `Player, Team, Mat, Overs, Mdns, Runs, Wkts, Avg, E_R, S_R, Four_Wickets`

**Known data quality handled:**
- `HS` column stored as `VARCHAR` due to not-out notation (`91*`) in source data
- Column name inconsistency (`Four_Wickets` vs `Four_wickets`) normalised during import
- MySQL Wizard import row-drop issue fixed using Python (`mysql-connector-python`)

---

## 🛠️ Setup & Import

**Prerequisites:**
```bash
pip install pandas mysql-connector-python
```

**Run the import script:**
```bash
python queries/00_data_import.py
```

This script:
- Creates the `ipl_analysis` database automatically
- Creates all 4 tables with correct schema
- Loads all 200 rows from CSV files
- Handles column name normalisation

---

## 📊 Queries & Business Questions

### Query 1 — Consistency Score
**Business question:** Who are the most reliable run-scorers, not just big hitters?

Custom formula: `(Avg × 0.5) + (SR × 0.3) + ((Fifties + Centuries×2) × 5)`

→ File: `queries/02_consistency_score.sql`

---

### Query 2 — Year-on-Year Form Analysis
**Business question:** Who improved heading into IPL 2020? Form matters more than reputation.

Uses `JOIN` across 2018 and 2019 tables to compute average and SR improvement per player.

→ File: `queries/03_yoy_form_analysis.sql`

---

### Query 3 — Team Dependency Analysis
**Business question:** Which teams are dangerously over-reliant on one player?

Uses **Window Function** `SUM() OVER (PARTITION BY Team)` to calculate each player's % contribution to team runs.

→ File: `queries/04_team_dependency.sql`

---

### Query 4 — Dual-Threat Bowlers
**Business question:** Who gives you control AND wickets? The rarest commodity in T20.

Custom formula: `(Wkts×10) − (ER×5) − (Avg×0.5)`

→ File: `queries/05_dual_threat_bowlers.sql`

---

### Query 5 — Value Per Match
**Business question:** Who consistently delivers every single game?

Uses `UNION ALL` to combine batsmen and bowlers into a single impact ranking.

→ File: `queries/06_value_per_match.sql`

---

### Final Query — ₹10 Crore Recommendation
**Business question:** Given all evidence, who are the best 2 batsmen and 2 bowlers to buy?

Uses **CTEs** (`WITH` clauses) to combine consistency, YoY improvement, and value index into a single `final_score`.

→ File: `queries/07_final_recommendation.sql`

---

## 🏆 Final Scout Recommendation

| # | Player | Role | Key Metric | Rationale |
|---|---|---|---|---|
| 1 | **Andre Russell** | Batsman | SR 204, Avg 56, +27.94 YoY | Most explosive + most improved player in 2019 |
| 2 | **KL Rahul** | Batsman | 593 runs, 6 fifties, SR 135 | Highest volume + reliability, safe batting anchor |
| 3 | **Rashid Khan** | Bowler | ER 6.74, 21 wickets | Best economy + wickets combo, world-class spinner |
| 4 | **Jasprit Bumrah** | Bowler | ER 6.89, death specialist | Pressure every over, elite T20 death bowler |

**Total budget utilised: ₹10 Crore**
**Balance: Squad depth preserved for all-rounders and backup roles**

---

## 💡 Key SQL Techniques Demonstrated

| Technique | Used In |
|---|---|
| `JOIN` across multiple tables | YoY Form Analysis |
| `UNION ALL` | Value Per Match (batsmen + bowlers combined) |
| Window Function `SUM() OVER (PARTITION BY)` | Team Dependency Analysis |
| CTE (`WITH` clause) | Final Recommendation Query |
| Custom scoring formulas | Consistency Score, Bowling Impact, Final Score |
| Data type handling (`VARCHAR` → numeric) | HS column in batsmen tables |
| Python-based bulk import | `00_data_import.py` |

---

## 👤 Author

**Dwaipayan Chatterjee**
M.Sc. Economics — West Bengal State University
GitHub: [@dchatterjee01-prog](https://github.com/dchatterjee01-prog)

---

*This project is framed as a Franchise Scout Analysis. Every query answers a business question. The goal was not just to write SQL — but to think like an analyst.*
