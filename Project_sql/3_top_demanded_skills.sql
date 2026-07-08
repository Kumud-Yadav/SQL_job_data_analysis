/*
Question: What are the most demanded skills for Business Analyst?
- Join job postings to Inner join table similar to query 2
- Identify the TOP 5 in-demand skills for business analyst
- Focus on all job postings no limiting on job data retrieve
- Why? Retreives the top 5 skills with the highest demand in the job market,
    providing insights for most valuable skills for job seekers.
*/

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
Limit 5

