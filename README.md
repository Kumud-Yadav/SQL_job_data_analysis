# 📊 SQL Business Analyst Job Data Analysis

A comprehensive SQL-based analysis of the job market for **Business Analysts**. This project queries a database of job postings to uncover the highest-paying roles, the most in-demand skills, the highest-paying skills, and the most optimal skills to learn for anyone looking to enter or advance in the field.

---

## 🔍 Introduction
In a data-driven business environment, understanding job market trends is crucial. This project is a hands-on exploration of the global job market dataset to answer key career questions specifically for the **Business Analyst** role. 

The queries in this repository explore:
1. What are the top-paying remote Business Analyst jobs?
2. What skills are required for these top-paying jobs?
3. What are the most in-demand skills for Business Analysts?
4. What skills are associated with the highest average salaries?
5. What are the most optimal skills to learn (combining high demand and high salary)?

---

## 📝 Background
The analysis is built on a PostgreSQL relational database containing job market postings from 2023. The dataset includes detailed tables representing:
*   **`job_postings_fact`**: Core job post details (titles, salary, location, work-from-home, dates, etc.).
*   **`skills_dim`**: Directory of technical skills.
*   **`company_dim`**: Details about hiring companies.
*   **`skills_job_dim`**: A join table mapping specific skills to job postings.

The complete schema design and table loading scripts can be found in:
*   [1_create_database.sql]- Database initialization
*   [2_create_tables.sql]- Schema and table definition
*   [3_modify_tables.sql]- CSV bulk loading script

---

## 🛠️ Tools I Used
To perform this analysis, I leveraged several key tools:
1.  **PostgreSQL**: The relational database management system used to host and query the job postings data.
2.  **Visual Studio Code**: The primary integrated development environment (IDE) for writing and formatting the SQL queries.
3.  **SQLTools (VS Code Extension)**: Used to manage active database connections and execute queries directly within the code editor.
4.  **Git & GitHub**: For tracking script history, managing commits, and sharing this project.

---

## 📈 Analysis
The following sections document the five core analysis queries written to extract insights from the database.

### 1. Top Paying Business Analyst Jobs
*   **Goal**: Identify the top 10 highest-paying remote Business Analyst jobs.
*   **Approach**: Filter for remote positions (`job_location = 'Anywhere'`) with specified yearly salaries, sort descending, and limit to the top 10.
*   **SQL Query**: [1_top_paying_jobs.sql]

```sql
SELECT
    job_id,
    job_title,
    name AS company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Business Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```

---

### 2. Skills Required for Top Paying Jobs
*   **Goal**: Find the specific technical skills required for the 10 highest-paying Business Analyst roles identified above.
*   **Approach**: Join the results of Query 1 (using a Common Table Expression / CTE) with the `skills_job_dim` and `skills_dim` tables.
*   **SQL Query**: [2_top_paying_job_skills.sql]

```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        name AS company_name,
        salary_year_avg
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Business Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```
*   **Findings**: Employers consistently prioritize **SQL**, **Python**, **Excel**, and **Tableau**. These four skills form the core toolkit, while cloud technologies (GCP, BigQuery) and specialized BI tools (Looker) serve as valuable premium additions:
    
    | Job Title | Company | Salary (Avg/Yr) | Core Skills |
    | :--- | :--- | :---: | :--- |
    | Lead Business Intelligence Engineer | Noom | $220,000 | SQL, Python, Excel, Tableau, Looker, Chef |
    | Manager II, Applied Science | Uber | $214,500 | Python |
    | Senior Economy Designer | Harnham | $190,000 | SQL, Python, R |
    | Staff Revenue Operations Analyst | Gladly | $170,500 | Excel |
    | BI Analyst (Leadership Role) - GCP | CyberCoders | $162,500 | SQL, Python, BigQuery, GCP, Looker, Word, Sheets |
    | Manager Analytics and Reporting | CyberCoders | $145,000 | SQL, Excel, Tableau |
    | Business Strategy Analyst Senior | USAA | $138,640 | SQL, Python, R, SAS, Phoenix, Excel, Tableau |
    | Marketing Analytics Manager | Get It Recruit | $134,550 | Tableau |

---

### 3. Most In-Demand Skills for Business Analysts
*   **Goal**: Identify the top 5 most frequently requested skills across the entire database for Business Analyst postings.
*   **Approach**: Aggregate all postings for Business Analysts, group by skill names, count occurrences, and sort descending.
*   **SQL Query**: [3_top_demanded_skills.sql]

```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Business Analyst'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
```
*   **Findings**: Out of **49,160** total Business Analyst job postings in the database, the top 5 in-demand skills are heavily dominated by data querying and spreadsheet tools:
    
    | Rank | Skill | Job Postings Count | Market Demand Rate (%) |
    | :---: | :--- | :---: | :---: |
    | 1 | **SQL** | 17,372 | 35.3% |
    | 2 | **Excel** | 17,134 | 34.9% |
    | 3 | **Tableau** | 9,324 | 19.0% |
    | 4 | **Power BI** | 9,251 | 18.8% |
    | 5 | **Python** | 8,097 | 16.5% |

---

### 4. High-Paying Skills based on Salary
*   **Goal**: Determine which technical skills are associated with the highest average salaries for remote Business Analysts.
*   **Approach**: Average the yearly salary for remote postings grouped by skill, focus on postings with defined salaries, and display the top 25.
*   **SQL Query**: [4_top_paying_skills.sql]

```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Business Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    average_salary DESC
LIMIT 25;
```
*   **Findings**: High-paying skills are dominated by advanced analytics, programming, and big data/DevOps technologies.
    *   **Advanced Analytics & ML**: Python libraries like `NumPy` ($157,500), `PyTorch` ($120,333), `TensorFlow` ($120,333), and `Pandas` ($110,558) earn top salaries.
    *   **Data Pipelines & Infrastructure**: Tools like `Hadoop` ($139,201), `Airflow` ($135,410), `MongoDB` ($118,667), and `Snowflake` ($112,543) command significant premiums.
    *   **Specialized Automation**: `Chef` sits at the top ($220,000) due to its specialized nature in system configuration and infrastructure management for DevOps-integrated analyst roles.

---

### 5. Most Optimal Skills to Learn
*   **Goal**: Identify "optimal" skills to target—defined as skills that are both high in demand and command high average salaries for remote roles.
*   **Approach**: Combine the metrics from Query 3 and Query 4 using CTEs. Filter for skills requested in more than 10 remote job postings to avoid anomalies.
*   **SQL Query**: [5_optimal_skills.sql]

```sql
WITH skills_demand AS (
    SELECT 
        skills_job_dim.skill_id,
        skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Business Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY
        skills_job_dim.skill_id,
        skills_dim.skills
),

 average_salary AS (
    SELECT 
        skills_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS average_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Business Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY
        skills_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    average_salary
FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    average_salary DESC,
    demand_count DESC
LIMIT 25;
```
*   **Findings**: The results pinpoint the ultimate learning path for Business Analysts. High-demand skills with high average salaries include:
    
    | Skill | Remote Demand Count | Average Salary ($) | Strategic Advice |
    | :--- | :---: | :---: | :--- |
    | **Python** | 20 | $116,516 | High salary potential; learn for scripting, automation, and advanced data work. |
    | **Tableau** | 27 | $104,233 | Essential for Business Intelligence and building interactive dashboards. |
    | **SQL** | 42 | $99,120 | Absolute core skill; has the highest demand and a solid salary baseline. |
    | **Excel** | 31 | $94,132 | High demand; crucial for day-to-day modeling, statistics, and business analysis. |
    | **Power BI** | 12 | $90,448 | Strong alternative/complement to Tableau for corporate Microsoft environments. |

---

## 🧠 What I Learned
Through this project, I significantly improved my SQL and analytical capabilities:
*   **Complex Joins**: Mastered joining fact tables (`job_postings_fact`) with multiple dimension tables (`skills_dim`, `company_dim`, `skills_job_dim`) using `LEFT` and `INNER` joins to merge text tags with metrics.
*   **Common Table Expressions (CTEs)**: Structured complicated multi-stage queries (such as Query 2 and Query 5) into clean, logical blocks rather than nested subqueries.
*   **Aggregation & Filtering**: Utilized `GROUP BY`, `COUNT()`, and `AVG()` while filtering out null salary ranges (`IS NOT NULL`) to ensure cleaner data averages.
*   **Database Indexing**: Learned the practical benefits of index creation on foreign key columns (`idx_company_id`, `idx_skill_id`, `idx_job_id`) to accelerate query execution times.

---

## 🎯 Conclusion
For an aspiring or practicing **Business Analyst**, this dataset provides clear, data-driven directions:
1.  **Foundational Mastery is Non-Negotiable**: **SQL** and **Excel** are the gatekeepers. Over 35% of all job postings require them. You must master these to get your foot in the door.
2.  **Dashboarding Pays**: Visualisation skills (specifically **Tableau**) have a large remote demand and lead to six-figure salaries ($104,233 average).
3.  **Learn Python to Maximize Income**: Business Analysts who pick up scripting/data science skills in **Python** earn the highest average salaries ($116,516) among the high-demand toolsets.