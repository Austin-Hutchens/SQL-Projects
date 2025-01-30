SELECT * 
FROM employees
LIMIT 5;

SELECT * 
FROM projects
LIMIT 5;

SELECT first_name, last_name
FROM employees
WHERE current_project IS NULL;

SELECT project_id, project_name
FROM projects
WHERE project_id NOT IN (
  SELECT current_project
  FROM employees
  WHERE current_project IS NOT NULL
);

SELECT p.project_name, COUNT(*)
FROM projects p
JOIN employees e ON e.current_project = p.project_id
WHERE e.current_project NOT NULL
GROUP BY p.project_name
ORDER BY COUNT(*) DESC
LIMIT 1;

SELECT p.project_name
FROM projects p
JOIN employees e ON e.current_project = p.project_id
WHERE e.current_project NOT NULL
GROUP BY p.project_name
HAVING COUNT(e.current_project) > 1
ORDER BY COUNT(*) DESC;

SELECT (COUNT(*) * 2) - (
  SELECT COUNT(*)
  FROM employees
  WHERE current_project IS NOT NULL
    AND position = 'Developer'
) AS 'Count'
FROM projects;

SELECT personality
FROM employees
GROUP BY personality
ORDER BY COUNT(personality) DESC
LIMIT 1;

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
