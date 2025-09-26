USE mydb;

-- =========================================================
-- 10 LEFT JOIN QUERIES
-- =========================================================

-- 1. List all project managers and their developers (even if no devs assigned)
SELECT pm.username AS manager, d.username AS developer
FROM project_managers pm
LEFT JOIN developers d ON pm.employee_code = d.project_managers_employee_code;

-- 2. List all projects with assigned Python projects if available
SELECT ph.name AS project, py.client_comments
FROM projects_history ph
LEFT JOIN python_projects py ON ph.project_code = py.project_code;

-- 3. List projects with any linked income
SELECT ph.name, inc.`total_income (USD)`
FROM projects_history ph
LEFT JOIN income_projects inc ON ph.project_code = inc.projects_history_project_code;

-- 4. Show all clients and their project history
SELECT c.username, ph.name AS project_name
FROM client_details c
LEFT JOIN projects_history ph ON c.projects_history_project_code = ph.project_code;

-- 5. Managers with their projects (even if project_code is null)
SELECT pm.username AS manager, ph.name AS project
FROM project_managers pm
LEFT JOIN projects_history ph ON pm.project_code = ph.project_code;

-- 6. Projects with their Splunk monitoring results
SELECT ph.name, sm.number_incidents
FROM projects_history ph
LEFT JOIN splunk_monitoring sm ON ph.project_code = sm.project_code;

-- 7. Projects with AWS usage if applicable
SELECT ph.name, aws.number_of_regions
FROM projects_history ph
LEFT JOIN AWS_cloud aws ON ph.project_code = aws.project_code;

-- 8. Developers with the income of their project
SELECT d.username, inc.`total_income (USD)`
FROM developers d
LEFT JOIN income_projects inc ON d.project_code = inc.projects_history_project_code;

-- 9. Clients with total spent on their project
SELECT c.username, r.`total_spent (USD)`
FROM client_details c
LEFT JOIN resources_invested r ON c.projects_history_project_code = r.projects_history_project_code;

-- 10. Projects with Azure usage if available
SELECT ph.name, az.number_of_regions
FROM projects_history ph
LEFT JOIN Azure_cloud az ON ph.project_code = az.project_code;


-- =========================================================
-- 10 RIGHT JOIN QUERIES
-- =========================================================

-- 1. Show developers and their managers (ensuring managers always appear)
SELECT d.username AS developer, pm.username AS manager
FROM developers d
RIGHT JOIN project_managers pm ON d.project_managers_employee_code = pm.employee_code;

-- 2. Show project income (ensuring income rows always appear)
SELECT ph.name, inc.`total_income (USD)`
FROM projects_history ph
RIGHT JOIN income_projects inc ON ph.project_code = inc.projects_history_project_code;

-- 3. Show Splunk monitoring for all projects (even if no project name available)
SELECT ph.name, sm.monitor_comments
FROM projects_history ph
RIGHT JOIN splunk_monitoring sm ON ph.project_code = sm.project_code;

-- 4. Show Java projects with base project details
SELECT ph.name, jp.client_comments
FROM projects_history ph
RIGHT JOIN java_projects jp ON ph.project_code = jp.project_code;

-- 5. Show Python projects with base project details
SELECT ph.name, py.client_comments
FROM projects_history ph
RIGHT JOIN python_projects py ON ph.project_code = py.project_code;

-- 6. Show Javascript projects with base project details
SELECT ph.name, js.client_comments
FROM projects_history ph
RIGHT JOIN javascript_projects js ON ph.project_code = js.project_code;

-- 7. Show Azure usage with base project
SELECT ph.name, az.number_of_regions
FROM projects_history ph
RIGHT JOIN Azure_cloud az ON ph.project_code = az.project_code;

-- 8. Show AWS usage with base project
SELECT ph.name, aws.number_of_regions
FROM projects_history ph
RIGHT JOIN AWS_cloud aws ON ph.project_code = aws.project_code;

-- 9. Show GCP usage with base project
SELECT ph.name, gcp.number_of_regions
FROM projects_history ph
RIGHT JOIN GCP_cloud gcp ON ph.project_code = gcp.project_code;

-- 10. Show client history with base client
SELECT c.username, ch.Number_of_projects
FROM client_details c
RIGHT JOIN client_history ch ON c.email = ch.client_details_email;


-- =========================================================
-- 10 INNER JOIN QUERIES
-- =========================================================

-- 1. Join projects with their income and spent resources
SELECT ph.name, inc.`total_income (USD)`, r.`total_spent (USD)`
FROM projects_history ph
INNER JOIN income_projects inc ON ph.project_code = inc.projects_history_project_code
INNER JOIN resources_invested r ON ph.project_code = r.projects_history_project_code;

-- 2. Join projects with Splunk monitoring incidents
SELECT ph.name, sm.number_incidents
FROM projects_history ph
INNER JOIN splunk_monitoring sm ON ph.project_code = sm.project_code;

-- 3. Join project managers with projects
SELECT pm.username, ph.name
FROM project_managers pm
INNER JOIN projects_history ph ON pm.project_code = ph.project_code;

-- 4. Join developers with project managers
SELECT d.username, pm.username AS manager
FROM developers d
INNER JOIN project_managers pm ON d.project_managers_employee_code = pm.employee_code;

-- 5. Join clients with their project income
SELECT c.username, inc.`total_income (USD)`
FROM client_details c
INNER JOIN income_projects inc ON c.projects_history_project_code = inc.projects_history_project_code;

-- 6. Join Java projects with monitoring
SELECT jp.name, sm.number_incidents
FROM java_projects jp
INNER JOIN splunk_monitoring sm ON jp.project_code = sm.project_code;

-- 7. Join Python projects with resources invested
SELECT py.name, r.`total_spent (USD)`
FROM python_projects py
INNER JOIN resources_invested r ON py.project_code = r.projects_history_project_code;

-- 8. Join Javascript projects with cloud usage (Azure)
SELECT js.name, az.number_of_regions
FROM javascript_projects js
INNER JOIN Azure_cloud az ON js.project_code = az.project_code;

-- 9. Join AI chatbot project with GCP cloud
SELECT py.name, gcp.number_of_regions
FROM python_projects py
INNER JOIN GCP_cloud gcp ON py.project_code = gcp.project_code;

-- 10. Join projects with time invested
SELECT ph.name, TIMESTAMPDIFF(DAY, t.start_time, t.finish_time) AS days_spent
FROM projects_history ph
INNER JOIN time_invested t ON ph.project_code = t.projects_history_project_code;


-- =========================================================
-- FULL DATABASE BIG JOIN QUERY
-- =========================================================
-- Join projects, managers, developers, clients, income, spending, and monitoring

SELECT 
  ph.name AS project,
  pm.username AS manager,
  d.username AS developer,
  c.username AS client,
  inc.`total_income (USD)` AS income,
  r.`total_spent (USD)` AS spending,
  sm.number_incidents AS incidents
FROM projects_history ph
LEFT JOIN project_managers pm ON ph.project_code = pm.project_code
LEFT JOIN developers d ON ph.project_code = d.project_code
LEFT JOIN client_details c ON ph.project_code = c.projects_history_project_code
LEFT JOIN income_projects inc ON ph.project_code = inc.projects_history_project_code
LEFT JOIN resources_invested r ON ph.project_code = r.projects_history_project_code
LEFT JOIN splunk_monitoring sm ON ph.project_code = sm.project_code;


-- =========================================================
-- GROUP BY QUERIES
-- =========================================================

-- 1. Average income per project
SELECT ph.name, AVG(inc.`total_income (USD)`) AS avg_income
FROM projects_history ph
JOIN income_projects inc ON ph.project_code = inc.projects_history_project_code
GROUP BY ph.name;

-- 2. Total spent per project
SELECT ph.name, SUM(r.`total_spent (USD)`) AS total_spent
FROM projects_history ph
JOIN resources_invested r ON ph.project_code = r.projects_history_project_code
GROUP BY ph.name;

-- 3. Number of developers per manager
SELECT pm.username AS manager, COUNT(d.employee_code) AS num_devs
FROM project_managers pm
LEFT JOIN developers d ON pm.employee_code = d.project_managers_employee_code
GROUP BY pm.username;


-- =========================================================
-- HAVING QUERIES
-- =========================================================

-- 1. Projects with avg income > 200,000
SELECT ph.name, AVG(inc.`total_income (USD)`) AS avg_income
FROM projects_history ph
JOIN income_projects inc ON ph.project_code = inc.projects_history_project_code
GROUP BY ph.name
HAVING AVG(inc.`total_income (USD)`) > 200000;

-- 2. Managers with more than 1 developer
SELECT pm.username, COUNT(d.employee_code) AS num_devs
FROM project_managers pm
JOIN developers d ON pm.employee_code = d.project_managers_employee_code
GROUP BY pm.username
HAVING COUNT(d.employee_code) > 1;

-- 3. Projects with more than 3 monitoring incidents
SELECT ph.name, SUM(sm.number_incidents) AS total_incidents
FROM projects_history ph
JOIN splunk_monitoring sm ON ph.project_code = sm.project_code
GROUP BY ph.name
HAVING SUM(sm.number_incidents) > 3;

