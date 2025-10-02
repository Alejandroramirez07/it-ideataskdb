USE mydb;

-- =========================================================
-- 10 LEFT JOIN QUERIES
-- =========================================================

-- 1. List all project managers and their developers
SELECT pm.username AS manager, d.username AS developer
FROM project_managers pm
LEFT JOIN developers d ON pm.employee_code = d.employee_code;

-- 2. List all projects with assigned Python projects if available
SELECT p.name AS project, py.client_comments
FROM projects p
LEFT JOIN python_projects py ON p.project_code = py.project_code;

-- 3. List projects with any linked income
SELECT p.name, inc.total_income_usd
FROM projects p
LEFT JOIN income_projects inc ON p.project_code = inc.project_code;

-- 4. Show all clients and their project history
SELECT c.username, p.name AS project_name
FROM client_details c
LEFT JOIN projects p ON c.project_code = p.project_code;

-- 5. Managers with their projects (even if project_code is null)
SELECT pm.username AS manager, p.name AS project
FROM project_managers pm
LEFT JOIN projects p ON pm.project_code = p.project_code;

-- 6. Projects with their Splunk monitoring results
SELECT p.name, sm.number_incidents
FROM projects p
LEFT JOIN splunk_monitoring sm ON p.project_code = sm.project_code;

-- 7. Projects with AWS usage if applicable
SELECT p.name, aws.number_of_regions
FROM projects p
LEFT JOIN AWS_cloud aws ON p.project_code = aws.project_code;

-- 8. Developers with the income of their project
SELECT d.username, inc.total_income_usd
FROM developers d
LEFT JOIN income_projects inc ON d.project_code = inc.project_code;

-- 9. Clients with total spent on their project
SELECT c.username, r.total_spent_usd
FROM client_details c
LEFT JOIN resources_invested r ON c.project_code = r.project_code;

-- 10. Projects with Azure usage if available
SELECT p.name, az.number_of_regions
FROM projects p
LEFT JOIN Azure_cloud az ON p.project_code = az.project_code;


-- =========================================================
-- 10 RIGHT JOIN QUERIES
-- =========================================================

-- 1. Show developers and their managers (ensuring managers always appear)
SELECT d.username AS developer, pm.username AS manager
FROM developers d
RIGHT JOIN project_managers pm ON d.employee_code = pm.employee_code;

-- 2. Show project income (ensuring income rows always appear)
SELECT p.name, inc.total_income_usd
FROM projects p
RIGHT JOIN income_projects inc ON p.project_code = inc.project_code;

-- 3. Show Splunk monitoring for all projects (even if no project name available)
SELECT p.name, sm.monitor_comments
FROM projects p
RIGHT JOIN splunk_monitoring sm ON p.project_code = sm.project_code;

-- 4. Show Java projects with base project details
SELECT p.name, jp.client_comments
FROM projects p
RIGHT JOIN java_projects jp ON p.project_code = jp.project_code;

-- 5. Show Python projects with base project details
SELECT p.name, py.client_comments
FROM projects p
RIGHT JOIN python_projects py ON p.project_code = py.project_code;

-- 6. Show Javascript projects with base project details
SELECT p.name, js.client_comments
FROM projects p
RIGHT JOIN javascript_projects js ON p.project_code = js.project_code;

-- 7. Show Azure usage with base project
SELECT p.name, az.number_of_regions
FROM projects p
RIGHT JOIN Azure_cloud az ON p.project_code = az.project_code;

-- 8. Show AWS usage with base project
SELECT p.name, aws.number_of_regions
FROM projects p
RIGHT JOIN AWS_cloud aws ON p.project_code = aws.project_code;

-- 9. Show GCP usage with base project
SELECT p.name, gcp.number_of_regions
FROM projects p
RIGHT JOIN GCP_cloud gcp ON p.project_code = gcp.project_code;

-- 10. Show client history with base client
SELECT c.username, ch.number_of_projects
FROM client_details c
RIGHT JOIN client_history ch ON c.email = ch.client_email;


-- =========================================================
-- 10 INNER JOIN QUERIES
-- =========================================================

-- 1. Join projects with their income and spent resources
SELECT p.name, inc.total_income_usd, r.total_spent_usd
FROM projects p
INNER JOIN income_projects inc ON p.project_code = inc.project_code
INNER JOIN resources_invested r ON p.project_code = r.project_code;

-- 2. Join projects with Splunk monitoring incidents
SELECT p.name, sm.number_incidents
FROM projects p
INNER JOIN splunk_monitoring sm ON p.project_code = sm.project_code;

-- 3. Join project managers with projects
SELECT pm.username, p.name
FROM project_managers pm
INNER JOIN projects p ON pm.project_code = p.project_code;

-- 4. Join developers with project managers
SELECT d.username, pm.username AS manager
FROM developers d
INNER JOIN project_managers pm ON d.employee_code = pm.employee_code;

-- 5. Join clients with their project income
SELECT c.username, inc.total_income_usd
FROM client_details c
INNER JOIN income_projects inc ON c.project_code = inc.project_code;

-- 6. Join Java projects with monitoring
SELECT jp.name, sm.number_incidents
FROM java_projects jp
INNER JOIN splunk_monitoring sm ON jp.project_code = sm.project_code;

-- 7. Join Python projects with resources invested
SELECT py.name, r.total_spent_usd
FROM python_projects py
INNER JOIN resources_invested r ON py.project_code = r.project_code;

-- 8. Join Javascript projects with cloud usage (Azure)
SELECT js.name, az.number_of_regions
FROM javascript_projects js
INNER JOIN Azure_cloud az ON js.project_code = az.project_code;

-- 9. Join AI chatbot project with GCP cloud
SELECT py.name, gcp.number_of_regions
FROM python_projects py
INNER JOIN GCP_cloud gcp ON py.project_code = gcp.project_code;

-- 10. Join projects with time invested
SELECT p.name, TIMESTAMPDIFF(DAY, t.start_time, t.finish_time) AS days_spent
FROM projects p
INNER JOIN time_invested t ON p.project_code = t.project_code;


-- =========================================================
-- FULL DATABASE BIG JOIN QUERY
-- =========================================================
-- Join projects, managers, developers, clients, income, spending, and monitoring

SELECT 
  p.name AS project,
  pm.username AS manager,
  d.username AS developer,
  c.username AS client,
  inc.total_income_usd AS income,
  r.total_spent_usd AS spending,
  sm.number_incidents AS incidents
FROM projects p
LEFT JOIN project_managers pm ON p.project_code = pm.project_code
LEFT JOIN developers d ON p.project_code = d.project_code
LEFT JOIN client_details c ON p.project_code = c.project_code
LEFT JOIN income_projects inc ON p.project_code = inc.project_code
LEFT JOIN resources_invested r ON p.project_code = r.project_code
LEFT JOIN splunk_monitoring sm ON p.project_code = sm.project_code;


-- =========================================================
-- GROUP BY QUERIES
-- =========================================================

-- 1. Average income per project
SELECT p.name, AVG(inc.total_income_usd) AS avg_income
FROM projects p
JOIN income_projects inc ON p.project_code = inc.project_code
GROUP BY p.name;

-- 2. Total spent per project
SELECT p.name, SUM(r.total_spent_usd) AS total_spent
FROM projects p
JOIN resources_invested r ON p.project_code = r.project_code
GROUP BY p.name;

-- 3. Number of developers per manager
SELECT pm.username AS manager, COUNT(d.employee_code) AS num_developers
FROM project_managers pm
LEFT JOIN developers d ON pm.employee_code = d.employee_code
GROUP BY pm.username;

