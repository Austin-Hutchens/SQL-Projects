# SQL Employee & Project Analysis

This project involves SQL queries to analyze employee data and project assignments. The dataset includes employees with attributes such as name, position, and personality type, as well as projects they are currently assigned to.

## Features & Queries

### 1. **Basic Data Exploration**
- Retrieve the first five records from the `employees` and `projects` tables.

```sql
SELECT * 
FROM employees
LIMIT 5;

SELECT * 
FROM projects
LIMIT 5;
```


### 2. **Employees Without a Project**
- Identify employees who are not currently assigned to any project.

```sql
SELECT first_name, last_name
FROM employees
WHERE current_project IS NULL;
```

### 3. **Unassigned Projects**
- List projects that do not have any employees assigned to them.

```sql
SELECT project_id, project_name
FROM projects
WHERE project_id NOT IN (
  SELECT current_project
  FROM employees
  WHERE current_project IS NOT NULL
);
```

### 4. **Most Popular Project**
- Determine the project with the highest number of employees.

```sql
SELECT p.project_name, COUNT(*)
FROM projects p
JOIN employees e ON e.current_project = p.project_id
WHERE e.current_project NOT NULL
GROUP BY p.project_name
ORDER BY COUNT(*) DESC
LIMIT 1;
```

### 5. **Projects with More Than One Employee**
- Retrieve projects that have more than one employee assigned.

```sql
SELECT p.project_name
FROM projects p
JOIN employees e ON e.current_project = p.project_id
WHERE e.current_project NOT NULL
GROUP BY p.project_name
HAVING COUNT(e.current_project) > 1
ORDER BY COUNT(*) DESC;
```

### 6. **Developer Count Calculation**
- Compute a count based on the number of developers assigned to projects.

```sql
SELECT (COUNT(*) * 2) - (
  SELECT COUNT(*)
  FROM employees
  WHERE current_project IS NOT NULL
    AND position = 'Developer'
) AS 'Count'
FROM projects;
```

### 7. **Most Common Personality Type**
- Find the most frequent personality type among employees.

```sql
SELECT personality
FROM employees
GROUP BY personality
ORDER BY COUNT(personality) DESC
LIMIT 1;
```

### 8. **Most Popular Personality Type in a Project**
- Identify the most common personality type assigned to a project.

```sql
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
```

### 9. **Employees Working on the Most Common Personality-Type Project**
- List employees working on a project where the dominant personality type is the most common in the dataset.

```sql
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
```


### 10. **Personality Compatibility Analysis**
- Analyze how many employees have personality types considered "incompatible" based on predefined personality match criteria.


```sql
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
```



## Potential Improvements
- **Data Normalization:** Ensure personality types are standardized.
- **Indexing & Performance Optimization:** Improve query performance for large datasets.
- **Visualization:** Use tools like Power BI or Tableau to present insights graphically.

## Technologies Used
- SQL (Standard ANSI SQL)
- Relational Database (e.g., PostgreSQL, MySQL, SQLite)

## How to Use
1. Run the provided SQL queries in your preferred database system.
2. Modify queries as needed for custom analysis.
3. Explore the dataset and optimize queries based on performance.

---

Feel free to contribute or suggest improvements! 🚀
