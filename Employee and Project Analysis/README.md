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

```
SELECT first_name, last_name
FROM employees
WHERE current_project IS NULL;
```

### 3. **Unassigned Projects**
- List projects that do not have any employees assigned to them.

### 4. **Most Popular Project**
- Determine the project with the highest number of employees.

### 5. **Projects with More Than One Employee**
- Retrieve projects that have more than one employee assigned.

### 6. **Developer Count Calculation**
- Compute a count based on the number of developers assigned to projects.

### 7. **Most Common Personality Type**
- Find the most frequent personality type among employees.

### 8. **Most Popular Personality Type in a Project**
- Identify the most common personality type assigned to a project.

### 9. **Employees Working on the Most Common Personality-Type Project**
- List employees working on a project where the dominant personality type is the most common in the dataset.

### 10. **Personality Compatibility Analysis**
- Analyze how many employees have personality types considered "incompatible" based on predefined personality match criteria.

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
