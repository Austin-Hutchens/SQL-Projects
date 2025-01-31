# SQL Employee & Project Analysis

This project involves SQL queries to analyze employee data and project assignments. The dataset includes employees with attributes such as name, position, and personality type, as well as projects they are currently assigned to.

## Features & Queries

### 1. **Basic Data Exploration**
- Retrieve the first five records from the `employees` and `projects` tables.

```sql
SELECT * 
FROM employees
LIMIT 5;
```

| employee_id | first_name | last_name | location | position  | personality | current_project |
|------------|------------|-----------|----------|-----------|-------------|----------------|
| 1          | Shannan    | Arlow     | MO       | Designer  | ISTJ        | 2              |
| 2          | Philippe   | Fownes    | NY       | Designer  | ENFJ        | 2              |
| 3          | Ambrosi    | Dawkes    | TX       | Designer  | ISTP        | NULL           |
| 4          | Mordy      | Mosdall   | FL       | Developer | ISTP        | NULL           |
| 5          | Kalie      | Yearsley  | IL       | Developer | ESTJ        | 2              |



```sql
SELECT * 
FROM projects
LIMIT 5;
```

| project_id | project_name  | start_date  | end_date    |
|------------|--------------|------------|------------|
| 1          | AlienInvasion | 2021-01-09 | 2022-06-30 |
| 2          | RocketRush    | 2021-01-26 | 2022-12-14 |
| 3          | ZombieStorm   | 2021-05-08 | 2022-10-02 |
| 4          | BravoBoxing   | 2021-06-21 | 2022-07-10 |
| 5          | ExtremeJets   | 2021-05-20 | 2022-04-07 |



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

| project_id | project_name       |
|------------|-------------------|
| 8          | CycleScenes       |
| 9      


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
| project_name | count(*) |
|-------------|---------|
| FistsOfFury | 5       |


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

| project_name  |
|--------------|
| FistsOfFury  |
| RocketRush   |
| ExtremeJets  |


### 6. **Developer Count Calculation**
- Each project needs two developers, this query computes a count that tells us how many open developer spots there are based on the number of developers currently assigned to projects.

```sql
SELECT (COUNT(*) * 2) - (
  SELECT COUNT(*)
  FROM employees
  WHERE current_project IS NOT NULL
    AND position = 'Developer'
) AS 'Count'
FROM projects;
```

| Count |
|-------|
| 17    |



### 7. **Most Common Personality Type**
- Find the most frequent personality type among employees.

```sql
SELECT personality
FROM employees
GROUP BY personality
ORDER BY COUNT(personality) DESC
LIMIT 1;
```

| personality |
|-------------|
| ENFJ        |



### 8. **Most Popular Personality Type in a Project**
- Identifies the project assigned to people with the most common personality type

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

| project_name  |
|---------------|
| RocketRush    |
| BravoBoxing   |
| AlienInvasion |



### 9. **Employees Working on the Most Common Personality-Type Project**
- This query retrieves information about employees who are assigned to a project and share the most common personality type among all employees currently assigned to a project.
  
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

| First Name | Last Name | Personality | Project Name  |
|------------|-----------|-------------|---------------|
| Shannan    | Arlow     | ISTJ        | RocketRush    |
| Mirella    | Parram    | ISTJ        | MMA2K         |
| Lacy       | Escritt   | ISTJ        | FistsOfFury   |




### 10. **Personality Compatibility Analysis**
- This query calculates the number of employees each person is considered 'incompatible' with based on their Myers-Briggs personality type, according to predefined compatibility criteria.


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

| first_name | last_name      | personality | project_name  | INCOMPATIBLE |
|------------|----------------|-------------|---------------|--------------|
| Shannan    | Arlow          | ISTJ        | RocketRush    | 15           |
| Philippe   | Fownes         | ENFJ        | RocketRush    | 20           |
| Kalie      | Yearsley       | ESTJ        | RocketRush    | 15           |
| Hannis     | Galea          | ESTJ        | ZombieStorm   | 15           |
| Mirella    | Parram         | ISTJ        | MMA2K         | 15           |
| Delphinia  | Ferrant        | ENFP        | ExtremeJets   | 25           |
| Ingeborg   | Prickett       | ENFJ        | BravoBoxing   | 20      



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
