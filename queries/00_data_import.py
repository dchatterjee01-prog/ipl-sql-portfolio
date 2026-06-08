import pandas as pd
import mysql.connector

DB_PASSWORD = "root"
DB_USER     = "root"

FILES = {
    "batsmen_2018": r"C:\Users\daipa\OneDrive\Desktop\IVY\SQL\IPL\batsmen_2018.csv",
    "batsmen_2019": r"C:\Users\daipa\OneDrive\Desktop\IVY\SQL\IPL\batsmen_2019.csv",
    "bowlers_2018": r"C:\Users\daipa\OneDrive\Desktop\IVY\SQL\IPL\bowlers_2018.csv",
    "bowlers_2019": r"C:\Users\daipa\OneDrive\Desktop\IVY\SQL\IPL\bowlers_2019.csv",
}

# Step 1 — Connect WITHOUT specifying database
conn = mysql.connector.connect(
    host="localhost",
    user=DB_USER,
    password=DB_PASSWORD,
)
cursor = conn.cursor()

# Step 2 — Create database if it doesn't exist, then use it
cursor.execute("CREATE DATABASE IF NOT EXISTS ipl_analysis")
cursor.execute("USE ipl_analysis")
conn.database = "ipl_analysis"
print("✅ Database ipl_analysis ready")

# Step 3 — Create all 4 tables
cursor.execute("""
CREATE TABLE IF NOT EXISTS batsmen_2018 (
    Player VARCHAR(100), Team VARCHAR(100), Mat INT, Inns INT,
    NO INT, Runs INT, HS VARCHAR(10), Hundreds INT, Fifties INT,
    Avg DECIMAL(6,2), S_R DECIMAL(6,2), Fours INT, Sixs INT
)""")

cursor.execute("""
CREATE TABLE IF NOT EXISTS batsmen_2019 (
    Player VARCHAR(100), Team VARCHAR(100), Mat INT, Inns INT,
    NO INT, Runs INT, HS VARCHAR(10), Hundreds INT, Fifties INT,
    Avg DECIMAL(6,2), S_R DECIMAL(6,2), Fours INT, Sixs INT
)""")

cursor.execute("""
CREATE TABLE IF NOT EXISTS bowlers_2018 (
    Player VARCHAR(100), Team VARCHAR(100), Mat INT,
    Overs DECIMAL(6,1), Mdns INT, Runs INT, Wkts INT,
    Avg DECIMAL(6,2), E_R DECIMAL(6,2), S_R DECIMAL(6,2),
    Four_Wickets INT
)""")

cursor.execute("""
CREATE TABLE IF NOT EXISTS bowlers_2019 (
    Player VARCHAR(100), Team VARCHAR(100), Mat INT,
    Overs DECIMAL(6,1), Mdns INT, Runs INT, Wkts INT,
    Avg DECIMAL(6,2), E_R DECIMAL(6,2), S_R DECIMAL(6,2),
    Four_Wickets INT
)""")

conn.commit()
print("✅ All 4 tables created successfully")

# Step 4 — Insert data from CSVs
insert_queries = {
    "batsmen_2018": "INSERT INTO batsmen_2018 (Player,Team,Mat,Inns,NO,Runs,HS,Hundreds,Fifties,Avg,S_R,Fours,Sixs) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",
    "batsmen_2019": "INSERT INTO batsmen_2019 (Player,Team,Mat,Inns,NO,Runs,HS,Hundreds,Fifties,Avg,S_R,Fours,Sixs) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",
    "bowlers_2018": "INSERT INTO bowlers_2018 (Player,Team,Mat,Overs,Mdns,Runs,Wkts,Avg,E_R,S_R,Four_Wickets) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",
    "bowlers_2019": "INSERT INTO bowlers_2019 (Player,Team,Mat,Overs,Mdns,Runs,Wkts,Avg,E_R,S_R,Four_Wickets) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",
}

for table, filepath in FILES.items():
    df = pd.read_csv(filepath)
    df.columns = [col.strip() for col in df.columns]
    if 'Four_wickets' in df.columns:
        df.rename(columns={'Four_wickets': 'Four_Wickets'}, inplace=True)
    rows = [tuple(row) for _, row in df.iterrows()]
    cursor.executemany(insert_queries[table], rows)
    conn.commit()
    print(f"✅ {table}: {cursor.rowcount} rows inserted")

# Step 5 — Close connection
cursor.close()
conn.close()
print("\n🎉 All tables loaded. Ready to analyse!")