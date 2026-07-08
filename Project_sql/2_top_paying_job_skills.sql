/*
Question: What skills are required for top paying Business Analyst role?
- Use the top 10 highest paying Business Analyst jobs from first query
- Add the specific skills required for this role
- Why? It provides a detailed look at which high paying job demands certain skills,
    helping job seekers to understand which skill to develop to aligh with top salaries
*/

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
    salary_year_avg DESC

/*
The dataset shows that employers consistently prioritize SQL, Python, Excel, and Tableau.
These four skills form the core toolkit for modern business analysts, while cloud technologies (BigQuery, GCP) and
specialized analytics tools (R, SAS) serve as valuable additions that can help candidates stand out for higher-paying roles.

-If you're preparing for business analyst roles, the skills should be prioritized as:
1- SQL
2- Python
3- Excel
4- Tableau

[
  {
    "job_id": 502610,
    "job_title": "Lead Business Intelligence Engineer",
    "company_name": "Noom",
    "salary_year_avg": "220000.0",
    "skills": "sql"
  },
  {
    "job_id": 502610,
    "job_title": "Lead Business Intelligence Engineer",
    "company_name": "Noom",
    "salary_year_avg": "220000.0",
    "skills": "python"
  },
  {
    "job_id": 502610,
    "job_title": "Lead Business Intelligence Engineer",
    "company_name": "Noom",
    "salary_year_avg": "220000.0",
    "skills": "excel"
  },
  {
    "job_id": 502610,
    "job_title": "Lead Business Intelligence Engineer",
    "company_name": "Noom",
    "salary_year_avg": "220000.0",
    "skills": "tableau"
  },
  {
    "job_id": 502610,
    "job_title": "Lead Business Intelligence Engineer",
    "company_name": "Noom",
    "salary_year_avg": "220000.0",
    "skills": "looker"
  },
  {
    "job_id": 502610,
    "job_title": "Lead Business Intelligence Engineer",
    "company_name": "Noom",
    "salary_year_avg": "220000.0",
    "skills": "chef"
  },
  {
    "job_id": 112859,
    "job_title": "Manager II, Applied Science - Marketplace Dynamics",
    "company_name": "Uber",
    "salary_year_avg": "214500.0",
    "skills": "python"
  },
  {
    "job_id": 17458,
    "job_title": "Senior Economy Designer",
    "company_name": "Harnham",
    "salary_year_avg": "190000.0",
    "skills": "sql"
  },
  {
    "job_id": 17458,
    "job_title": "Senior Economy Designer",
    "company_name": "Harnham",
    "salary_year_avg": "190000.0",
    "skills": "python"
  },
  {
    "job_id": 17458,
    "job_title": "Senior Economy Designer",
    "company_name": "Harnham",
    "salary_year_avg": "190000.0",
    "skills": "r"
  },
  {
    "job_id": 416185,
    "job_title": "Staff Revenue Operations Analyst",
    "company_name": "Gladly",
    "salary_year_avg": "170500.0",
    "skills": "excel"
  },
  {
    "job_id": 1099753,
    "job_title": "REMOTE - Business Intelligence Analyst (Leadership Role) - GCP",
    "company_name": "CyberCoders",
    "salary_year_avg": "162500.0",
    "skills": "sql"
  },
  {
    "job_id": 1099753,
    "job_title": "REMOTE - Business Intelligence Analyst (Leadership Role) - GCP",
    "company_name": "CyberCoders",
    "salary_year_avg": "162500.0",
    "skills": "python"
  },
  {
    "job_id": 1099753,
    "job_title": "REMOTE - Business Intelligence Analyst (Leadership Role) - GCP",
    "company_name": "CyberCoders",
    "salary_year_avg": "162500.0",
    "skills": "bigquery"
  },
  {
    "job_id": 1099753,
    "job_title": "REMOTE - Business Intelligence Analyst (Leadership Role) - GCP",
    "company_name": "CyberCoders",
    "salary_year_avg": "162500.0",
    "skills": "gcp"
  },
  {
    "job_id": 1099753,
    "job_title": "REMOTE - Business Intelligence Analyst (Leadership Role) - GCP",
    "company_name": "CyberCoders",
    "salary_year_avg": "162500.0",
    "skills": "looker"
  },
  {
    "job_id": 1099753,
    "job_title": "REMOTE - Business Intelligence Analyst (Leadership Role) - GCP",
    "company_name": "CyberCoders",
    "salary_year_avg": "162500.0",
    "skills": "word"
  },
  {
    "job_id": 1099753,
    "job_title": "REMOTE - Business Intelligence Analyst (Leadership Role) - GCP",
    "company_name": "CyberCoders",
    "salary_year_avg": "162500.0",
    "skills": "sheets"
  },
  {
    "job_id": 1313937,
    "job_title": "Manager Analytics and Reporting",
    "company_name": "CyberCoders",
    "salary_year_avg": "145000.0",
    "skills": "sql"
  },
  {
    "job_id": 1313937,
    "job_title": "Manager Analytics and Reporting",
    "company_name": "CyberCoders",
    "salary_year_avg": "145000.0",
    "skills": "excel"
  },
  {
    "job_id": 1313937,
    "job_title": "Manager Analytics and Reporting",
    "company_name": "CyberCoders",
    "salary_year_avg": "145000.0",
    "skills": "tableau"
  },
  {
    "job_id": 106225,
    "job_title": "Business Strategy Analyst Senior (Hybrid)",
    "company_name": "USAA",
    "salary_year_avg": "138640.0",
    "skills": "sql"
  },
  {
    "job_id": 106225,
    "job_title": "Business Strategy Analyst Senior (Hybrid)",
    "company_name": "USAA",
    "salary_year_avg": "138640.0",
    "skills": "python"
  },
  {
    "job_id": 106225,
    "job_title": "Business Strategy Analyst Senior (Hybrid)",
    "company_name": "USAA",
    "salary_year_avg": "138640.0",
    "skills": "r"
  },
  {
    "job_id": 106225,
    "job_title": "Business Strategy Analyst Senior (Hybrid)",
    "company_name": "USAA",
    "salary_year_avg": "138640.0",
    "skills": "sas"
  },
  {
    "job_id": 106225,
    "job_title": "Business Strategy Analyst Senior (Hybrid)",
    "company_name": "USAA",
    "salary_year_avg": "138640.0",
    "skills": "phoenix"
  },
  {
    "job_id": 106225,
    "job_title": "Business Strategy Analyst Senior (Hybrid)",
    "company_name": "USAA",
    "salary_year_avg": "138640.0",
    "skills": "excel"
  },
  {
    "job_id": 106225,
    "job_title": "Business Strategy Analyst Senior (Hybrid)",
    "company_name": "USAA",
    "salary_year_avg": "138640.0",
    "skills": "tableau"
  },
  {
    "job_id": 106225,
    "job_title": "Business Strategy Analyst Senior (Hybrid)",
    "company_name": "USAA",
    "salary_year_avg": "138640.0",
    "skills": "sas"
  },
  {
    "job_id": 661103,
    "job_title": "Marketing Analytics Manager",
    "company_name": "Get It Recruit - Marketing",
    "salary_year_avg": "134550.0",
    "skills": "tableau"
  }
]
*/