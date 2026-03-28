-- Задача 2: Подчиненные Ивана Иванова с подсчетом подчиненных и задач (PostgreSQL)
WITH RECURSIVE EmployeeHierarchy AS (
    SELECT 
        EmployeeID,
        Name,
        ManagerID,
        DepartmentID,
        RoleID
    FROM Employees
    WHERE EmployeeID = 1
    
    UNION ALL
    
    SELECT 
        e.EmployeeID,
        e.Name,
        e.ManagerID,
        e.DepartmentID,
        e.RoleID
    FROM Employees e
    INNER JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
),
EmployeeTasks AS (
    SELECT 
        AssignedTo,
        COUNT(*) AS task_count,
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
),
SubordinateCount AS (
    SELECT 
        ManagerID,
        COUNT(*) AS total_subordinates
    FROM Employees
    GROUP BY ManagerID
)
SELECT 
    eh.EmployeeID,
    eh.Name AS EmployeeName,
    eh.ManagerID,
    d.DepartmentName,
    r.RoleName,
    ep.project_list AS ProjectNames,
    et.task_list AS TaskNames,
    COALESCE(et.task_count, 0) AS TotalTasks,
    COALESCE(sc.total_subordinates, 0) AS TotalSubordinates
FROM EmployeeHierarchy eh
LEFT JOIN Departments d ON eh.DepartmentID = d.DepartmentID
LEFT JOIN Roles r ON eh.RoleID = r.RoleID
LEFT JOIN EmployeeTasks et ON eh.EmployeeID = et.AssignedTo
LEFT JOIN EmployeeProjects ep ON eh.EmployeeID = ep.EmployeeID
LEFT JOIN SubordinateCount sc ON eh.EmployeeID = sc.ManagerID
ORDER BY eh.Name;
