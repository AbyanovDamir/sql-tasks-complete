-- Задача 3: Менеджеры с подчиненными (PostgreSQL)
WITH RECURSIVE SubordinateTree AS (
    SELECT 
        ManagerID,
        EmployeeID,
        1 AS level
    FROM Employees
    WHERE ManagerID IS NOT NULL
    
    UNION ALL
    
    SELECT 
        st.ManagerID,
        e.EmployeeID,
        st.level + 1
    FROM SubordinateTree st
    JOIN Employees e ON st.EmployeeID = e.ManagerID
),
ManagerSubordinates AS (
    SELECT 
        ManagerID,
        COUNT(DISTINCT EmployeeID) AS total_subordinates
    FROM SubordinateTree
    GROUP BY ManagerID
),
EmployeeTasks AS (
    SELECT 
        AssignedTo,
        STRING_AGG(TaskName, ', ' ORDER BY TaskName) AS task_list
    FROM Tasks
    GROUP BY AssignedTo
),
EmployeeProjects AS (
    SELECT 
        e.EmployeeID,
        STRING_AGG(DISTINCT p.ProjectName, ', ' ORDER BY p.ProjectName) AS project_list
    FROM Employees e
    LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID
    LEFT JOIN Projects p ON d.DepartmentID = p.DepartmentID
    GROUP BY e.EmployeeID
)
SELECT 
    e.EmployeeID,
    e.Name AS EmployeeName,
    e.ManagerID,
    d.DepartmentName,
    r.RoleName,
    ep.project_list AS ProjectNames,
    et.task_list AS TaskNames,
    ms.total_subordinates AS TotalSubordinates
FROM Employees e
JOIN Roles r ON e.RoleID = r.RoleID
LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID
LEFT JOIN EmployeeTasks et ON e.EmployeeID = et.AssignedTo
LEFT JOIN EmployeeProjects ep ON e.EmployeeID = ep.EmployeeID
JOIN ManagerSubordinates ms ON e.EmployeeID = ms.ManagerID
WHERE r.RoleName = 'Менеджер'
ORDER BY e.Name;
