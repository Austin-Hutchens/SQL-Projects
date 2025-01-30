-- 1. Select the first 5 records from the employees and projects table

SELECT * 
FROM employees
LIMIT 5;

SELECT * 
FROM projects
LIMIT 5;

-- 2. Select the first and last names of employees who are not assigned to any project

SELECT first_name, last_name
FROM employees
WHERE current_project IS NULL;

-- 3. Select the project ID and project name where the project ID is not assigned to any employee

SELECT project_id, project_name
FROM projects
WHERE project_id NOT IN (
  SELECT current_project
  FROM employees
  WHERE current_project IS NOT NULL
);


-- 4. Select the project name and the count of employees working on that project, ordered by the highest count

SELECT p.project_name, COUNT(*)
FROM projects p
JOIN employees e ON e.current_project = p.project_id
WHERE e.current_project NOT NULL
GROUP BY p.project_name
ORDER BY COUNT(*) DESC
LIMIT 1;


-- 5. Select the project name where more than one employee is assigned, ordered by the highest count

SELECT p.project_name
FROM projects p
JOIN employees e ON e.current_project = p.project_id
WHERE e.current_project NOT NULL
GROUP BY p.project_name
HAVING COUNT(e.current_project) > 1
ORDER BY COUNT(*) DESC;


-- 6. Calculate a custom count based on employees working on projects and developers' count

SELECT (COUNT(*) * 2) - (
  SELECT COUNT(*)
  FROM employees
  WHERE current_project IS NOT NULL
    AND position = 'Developer'
) AS 'Count'
FROM projects;


-- 7. Select the most common personality type among employees

SELECT (COUNT(*) * 2) - (
SELECT personality
FROM employees
GROUP BY personality
ORDER BY COUNT(personality) DESC
LIMIT 1;


-- 8. Select the project name where the most common personality type is assigned to employees

SELECT project_name
FROM projects p
JOIN employees e ON p.project_id = e.current_project
WHERE personality = (
  SELECT personality
  FROM employees
  GROUP BY personality
  ORDER BY COUNT(personality) DESC
  LIMIT 1
);


-- 9. Select first name, last name, personality, and project name for employees with the most common personality type

SELECT project_name
SELECT e.first_name, e.last_name, e.personality, p.project_name
FROM employees e 
JOIN projects p ON e.current_project = p.project_id
WHERE personality = (
  SELECT personality
  FROM employees
  WHERE current_project IS NOT NULL
  GROUP BY personality
  ORDER BY COUNT(personality) DESC
  LIMIT 1
);


-- 10. Select first name, last name, personality, project name, and the count of incompatible personalities

SELECT e.first_name, e.last_name, e.personality, p.project_name,
CASE
  WHEN personality = 'INFP' 
  THEN (SELECT COUNT(*)
        FROM employees
        WHERE personality IN ('ISFP', 'ESFP', 'ISTP', 'ESTP', 'ISFJ', 'ESFJ', 'ISTJ', 'ESTJ'))
  WHEN personality = 'ENFP'
  THEN (SELECT COUNT(*)
        FROM employees
        WHERE personality IN ('ISFP', 'ESFP', 'ISTP', 'ESTP', 'ISFJ', 'ESFJ', 'ISTJ', 'ESTJ'))
  WHEN personality = 'INFJ'
  THEN (SELECT COUNT(*)
        FROM employees
        WHERE personality IN ('ISFP', 'ESFP', 'ISTP', 'ESTP', 'ISFJ', 'ESFJ', 'ISTJ', 'ESTJ'))
  WHEN personality = 'ENFJ'
  THEN (SELECT COUNT(*)
        FROM employees
        WHERE personality IN ('ESFP', 'ISTP', 'ESTP', 'ISFJ', 'ESFJ', 'ISTJ', 'ESTJ'))
  WHEN personality = 'ISFP'
  THEN (SELECT COUNT(*)
        FROM employees
        WHERE personality IN ('INFP', 'ENFP', 'INFJ'))
  WHEN personality = 'ESFP'
  THEN (SELECT COUNT(*)
        FROM employees
        WHERE personality IN ('INFP', 'ENFP', 'INFJ', 'ENFJ'))
  WHEN personality = 'ISTP'
  THEN (SELECT COUNT(*)
        FROM employees
        WHERE personality IN ('INFP', 'ENFP', 'INFJ', 'ENFJ'))
  WHEN personality = 'ESTP'
  THEN (SELECT COUNT(*)
        FROM employees
        WHERE personality IN ('INFP', 'ENFP', 'INFJ', 'ENFJ'))
  WHEN personality = 'ISFJ'
  THEN (SELECT COUNT(*)
        FROM employees
        WHERE personality IN ('INFP', 'ENFP', 'INFJ', 'ENFJ'))
  WHEN personality = 'ESFJ'
  THEN (SELECT COUNT(*)
        FROM employees
        WHERE personality IN ('INFP', 'ENFP', 'INFJ', 'ENFJ'))
  WHEN personality = 'ISTJ'
  THEN (SELECT COUNT(*)
        FROM employees
        WHERE personality IN ('INFP', 'ENFP', 'INFJ', 'ENFJ'))
  WHEN personality = 'ESTJ'
  THEN (SELECT COUNT(*)
        FROM employees
        WHERE personality IN ('INFP', 'ENFP', 'INFJ', 'ENFJ'))
  ELSE 0
END AS 'INCOMPATIBLE'
FROM employees e
JOIN projects p ON e.current_project = p.project_id;
