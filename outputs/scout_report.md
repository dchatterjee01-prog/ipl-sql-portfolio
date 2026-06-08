# 🏏 IPL 2020 Franchise Scout Report
### Budget: ₹10 Crore | Target: 2 Batsmen + 2 Bowlers

---

## Methodology

All recommendations are derived from a 5-query analytical pipeline applied to IPL 2018 and 2019 data:

1. **Consistency Score** — Weighted formula across average, strike rate, and milestone innings
2. **YoY Form Analysis** — Average and SR improvement from 2018 → 2019
3. **Team Dependency** — % contribution to team runs (window function)
4. **Bowling Impact Score** — Wickets vs economy vs average trade-off
5. **Value Per Match** — Impact delivered per game played
6. **Final Score** — Combined CTE scoring model (40% consistency, 30% improvement, 30% value)

---

## Final Picks

### 🏏 Batsman 1 — Andre Russell (KKR)
- **Final Score:** 74.68
- **2019 Stats:** 510 runs | Avg 56.67 | SR 204.82 | 4 fifties
- **YoY Improvement:** +27.94 average | +20 SR
- **Why:** Most explosive batsman in the tournament AND most improved. SR of 204 is untouchable. High floor, extreme ceiling.

### 🏏 Batsman 2 — KL Rahul (KXIP)
- **Final Score:** 59.93
- **2019 Stats:** 593 runs | Avg 53.91 | SR 135.39 | 6 fifties | 1 century
- **Why:** Highest volume scorer with consistent fifties. Safe, reliable batting anchor. Perfect complement to Russell's explosiveness.

### 🎯 Bowler 1 — Rashid Khan (SRH)
- **Final Score:** 67.37
- **2019 Stats:** 21 wickets | ER 6.74 | SR 19.43
- **Why:** Best economy AND wickets combination in the dataset. Middle-over strangler AND breakthrough bowler. World class.

### 🎯 Bowler 2 — Jasprit Bumrah (MI)
- **Final Score:** 50.98
- **2019 Stats:** 17 wickets | ER 6.89 | Death bowling specialist
- **Why:** Second best economy in the list. Every over creates pressure. Elite death bowler — the rarest T20 asset.

---

## Squad Balance Assessment

| Attribute | Coverage |
|---|---|
| Explosive batting | Russell ✅ |
| Reliable run-scoring | Rahul ✅ |
| Middle-over control | Rashid ✅ |
| Death bowling | Bumrah ✅ |
| Budget headroom | Remaining funds for all-rounders ✅ |

---

*All analysis conducted in MySQL. Queries available in the `/queries` folder.*
