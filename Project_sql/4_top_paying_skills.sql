/*
What are the top skills based on salary?
- Look at average salary associated with each skill for Business Analyst role
- Focuses on role with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Business analyst and
    help identify the most financially rewarding skill to acquire or improve
*/

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
Limit 25

/*
-AI, machine learning, and data science skills (NumPy, Pandas, TensorFlow, PyTorch, Scikit-learn) dominate the highest-paying roles, highlighting the growing demand for advanced analytics expertise.
-Big data and cloud technologies (Hadoop, Snowflake, MongoDB, Cassandra, Airflow) are highly valued, reflecting the industry's shift toward scalable, cloud-based data solutions.
-Technical and specialized programming skills command the highest salaries, showing that business analysts with strong coding and data engineering capabilities earn a significant premium.

[
  {
    "skills": "chef",
    "average_salary": "220000"
  },
  {
    "skills": "numpy",
    "average_salary": "157500"
  },
  {
    "skills": "ruby",
    "average_salary": "150000"
  },
  {
    "skills": "hadoop",
    "average_salary": "139201"
  },
  {
    "skills": "julia",
    "average_salary": "136100"
  },
  {
    "skills": "airflow",
    "average_salary": "135410"
  },
  {
    "skills": "phoenix",
    "average_salary": "135248"
  },
  {
    "skills": "electron",
    "average_salary": "131000"
  },
  {
    "skills": "c",
    "average_salary": "123329"
  },
  {
    "skills": "pytorch",
    "average_salary": "120333"
  },
  {
    "skills": "tensorflow",
    "average_salary": "120333"
  },
  {
    "skills": "seaborn",
    "average_salary": "120000"
  },
  {
    "skills": "matlab",
    "average_salary": "120000"
  },
  {
    "skills": "matplotlib",
    "average_salary": "120000"
  },
  {
    "skills": "scikit-learn",
    "average_salary": "120000"
  },
  {
    "skills": "nosql",
    "average_salary": "119330"
  },
  {
    "skills": "mongodb",
    "average_salary": "118667"
  },
  {
    "skills": "snowflake",
    "average_salary": "112543"
  },
  {
    "skills": "looker",
    "average_salary": "110581"
  },
  {
    "skills": "pandas",
    "average_salary": "110558"
  },
  {
    "skills": "node.js",
    "average_salary": "110000"
  },
  {
    "skills": "elasticsearch",
    "average_salary": "110000"
  },
  {
    "skills": "mxnet",
    "average_salary": "110000"
  },
  {
    "skills": "chainer",
    "average_salary": "110000"
  },
  {
    "skills": "cassandra",
    "average_salary": "108488"
  }
]
*/