SELECT 
      job_title_short AS title,
      job_location AS location,
      job_posted_date::DATE AS date
FROM 
    job_postings_fact;


CREATE TABLE January_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;


CREATE TABLE February_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;


CREATE TABLE March_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;    

SELECT job_posted_date 
FROM february_jobs


--Subqueries: query nested inside a larger query

--It can be used in SELECT, FROM, and WHERE clauses.

SELECT *
FROM ( -- SubQuery starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs;
-- SubQuery ends here

--eg2. of subqueries
SELECT name AS company_name
FROM company_dim
WHERE company_id IN (
    SELECT
        company_id
    FROM
        job_postings_fact
    WHERE
        job_no_degree_mention = true
)


--Common Table Expressions (CTEs): define a temporary result set that you can reference

   -- Can reference within a SELECT, INSERT, UPDATE, or DELETE statement
   -- Defined with WITH



WITH january_jobs AS ( -- CTE definition starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) -- CTE definition ends here

SELECT *
FROM january_jobs;


--eg2 ,CTES

/*
Find the companies that have the most job ...
- Get the total number of job postings per ...
- Return the total number of jobs with the ...
*/

WITH company_job_count AS (
    SELECT
        company_id,
        COUNT(*)
    FROM
        job_postings_fact
    GROUP BY
        company_id
)

SELECT *
FROM company_job_count


WITH company_job_count AS (
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY
        company_id
)

SELECT
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM
    company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY
    total_jobs DESC


    /*
Find the top 5 skills most frequently requested
in remote (work-from-home) Data Analyst job postings.
*/

-- CTE: count how many remote Data Analyst postings mention each skill
WITH remote_job_skills AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count                -- number of postings per skill
    FROM
        skills_job_dim AS skills_to_job        -- links skills to job postings
    INNER JOIN job_postings_fact AS job_postings
        ON job_postings.job_id = skills_to_job.job_id
    WHERE
        job_postings.job_work_from_home = True AND              -- remote jobs only
        job_postings.job_title_short = 'Data Analyst'           -- Data Analyst roles only
    GROUP BY
        skill_id
)

-- Main query: attach skill names to the counts and keep the top 5
SELECT
    skills.skill_id,
    skills AS skill_name,                      -- "skills" column from skills_dim
    skill_count
FROM remote_job_skills
INNER JOIN skills_dim AS skills
    ON skills.skill_id = remote_job_skills.skill_id
ORDER BY
    skill_count DESC                           -- most in-demand skills first
LIMIT 5;


/*UNION Operators

Combine result sets of two or more SELECT statements into a single result set.

    UNION: Remove duplicate rows
    UNION ALL: Includes all duplicate rows

⚠️ Note: Each SELECT statement within the UNION must have the same number of columns in the result sets with similar data types.
/*

-- Get jobs and companies from January

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs

UNION

-- Get jobs and companies from February
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs

     
     
     
    /* UNION ALL


  --  UNION ALL - combine the result of two or more SELECT statements
    --They need to have the same amount of columns, and the data type must match



SELECT column_name
FROM table_one

UNION ALL -- combine the two tables

SELECT column_name
FROM table_two;

    Returns all rows, even duplicates (unlike UNION)
        Personal Note: I mostly use this to combine two tables together

/*

-- Get jobs and companies from January
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs

UNION ALL

-- Get jobs and companies from February
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs

UNION ALL -- combine another table

-- Get jobs and companies from March
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs




/*
Find job postings from the first quarter that have a salary greater than ...
- Combine job posting tables from the first quarter of 2023 (Jan-Mar)
- Gets job postings with an average yearly salary > $70,000
*/

SELECT
    quarter1_job_postings.job_title_short,
    quarter1_job_postings.job_location,
    quarter1_job_postings.job_via,
    quarter1_job_postings.job_posted_date::DATE
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS quarter1_job_postings
WHERE
    quarter1_job_postings.salary_year_avg > 70000 AND
    quarter1_job_postings.job_title_short = 'Data Analyst'
ORDER BY
    quarter1_job_postings.salary_year_avg    

    --OR
    /*
Find job postings from the first quarter that have a salary greater than ...
- Combine job posting tables from the first quarter of 2023 (Jan-Mar)
- Gets job postings with an average yearly salary > $70,000
*/

SELECT
    job_title_short,
    job_location,
    job_via,
    job_posted_date::DATE
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS quarter1_job_postings
WHERE
    salary_year_avg > 70000 AND
    job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg

    


