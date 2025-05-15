## 🏏 IPL Auction Strategy using SQL

![YouTube Banner - IPL Auction Strategy with SQL (1)](https://github.com/user-attachments/assets/380766ff-688c-41d6-8633-06cf0175c805)



### 📌 Project Overview

This project focuses on building a data-driven strategy to form an ideal IPL team for an auction using SQL queries and cricket match datasets. It revolves around analyzing player performances using match and ball-by-ball data to identify top batsmen, bowlers, all-rounders, and wicketkeepers — within auction budget constraints.

### 🎯 Problem Statement

As part of a fantasy IPL auction scenario, the challenge is to select an optimal squad of players (batsmen, bowlers, all-rounders, and wicketkeepers) using statistical evidence from IPL match data. The team must be formed based on performance metrics like Strike Rate, Bowling Economy, Batting/Bowling Average, and more — without exceeding the set budget limits.

---

### 🎯 Objectives

* To create and import IPL match and ball-level data using SQL.
* To derive key performance metrics for various player roles.
* To identify top-performing players suitable for IPL auction bidding.
* To build advanced queries for team and venue-level insights.
* To gain hands-on experience in SQL data cleaning, analysis, and table creation.

---

### 🗃️ Data Used

* **IPL\_Matches.csv**
* **IPL\_Ball.csv**

Two key tables were created and populated:

* `IPL_Matches`
* `IPL_Ball`

Additional tables such as `Deliveries`, `Matches`, `deliveries_v02`, and `deliveries_v03` were generated for deeper insights.

---

### 📊 Key SQL Modules Covered

| 📌 Analysis Area    | ✅ Query Output                                      |
| ------------------- | --------------------------------------------------- |
| Batsman Strike Rate | Top 10 batsmen with S.R > 130 (min 500 balls faced) |
| Batsman Average     | Players with high average (min 2 seasons)           |
| Hard-Hitters        | Players with most boundary runs                     |
| Bowler Economy      | Bowlers with economy < 7 (min 500 balls bowled)     |
| Bowler Strike Rate  | Best strike rate bowlers                            |
| All-Rounders        | Best combined batting & bowling metrics             |
| Wicket Keepers      | Evaluated by batting + stumping/catching efficiency |
| Additional Queries  | Dot balls, boundaries, venue stats, etc.            |

---

### 🧠 Additional Insights

* Count of cities hosting IPL matches
* Boundaries and dot ball statistics
* Year-wise run analysis at Eden Gardens
* Top bowlers conceding extra runs
* Venue-wise performance aggregation

---

### 📌 Tools & Technologies Used

* **SQL (MySQL/PostgreSQL)** – For querying and data analysis
* **Excel/CSV files** – For importing datasets
* **Data Cleaning & Transformation** – Using SQL statements
* **GitHub** – For project version control and documentation

---

### 📝 Conclusion

This project strengthened my data handling and analytical skills using SQL. I gained experience in:

* Data modeling
* Writing efficient SQL queries
* Extracting actionable cricket insights
* Building a full SQL-based data project from scratch

> 💬 *“This project opened my eyes to how powerful SQL can be in data analysis and decision-making, even in the domain of sports analytics.”*

---

### 📌 How to Run

If you'd like to reproduce this project:

1. Clone this repository.
2. Set up MySQL or PostgreSQL database.
3. Import the provided IPL datasets into respective tables.
4. Run the queries in the SQL file to generate insights.
5. Customize criteria and filters as needed!

---


### 📬 Contact

* **Md Adil Muzaffar**
* 📧 [adilmuzaffar96@gmail.com](mailto:adilmuzaffar96@gmail.com)
* 📱 +91 8507053209
* 🌐 [LinkedIn](https://www.linkedin.com/in/mdadilmuzaffar/) | [GitHub](https://github.com/mdadilmuzaffar24) |

---

