-- Tabela: employees
-- employee_id (INTEGER): ID pracownika.
-- manager_id (INTEGER): ID menedżera (odnosi się do employee_id).
-- department_id (INTEGER): ID działu.
-- salary (DECIMAL): Wynagrodzenie.
-- hire_date (DATE): Data zatrudnienia.

-- Sumowanie wynagrodzeń w hierarchii:
-- Oblicz sumę wynagrodzeń wszystkich pracowników podległych każdemu menedżerowi.

-- WITH RECURSIVE employee_hierarchy AS (
--     -- Pierwszy poziom hierarchii: bezpośredni podwładni każdego menedżera
--     SELECT 
--         employee_id, 
--         manager_id, 
--         salary
--     FROM 
--         employees

--     UNION ALL

--     -- Rekurencyjna część: podwładni podwładnych
--     SELECT 
--         e.employee_id, 
--         e.manager_id, 
--         e.salary
--     FROM 
--         employees e
--     JOIN 
--         employee_hierarchy eh
--     ON 
--         e.manager_id = eh.employee_id
-- )
-- -- Suma wynagrodzeń dla każdego menedżera
-- SELECT 
--     manager_id, 
--     SUM(salary) AS total_salary
-- FROM 
--     employee_hierarchy
-- GROUP BY 
--     manager_id
-- ORDER BY 
--     manager_id;

-- Analiza zatrudnienia na przestrzeni lat:
-- Użyj CTE do podziału pracowników na grupy według roku zatrudnienia, a następnie policz liczbę pracowników zatrudnionych w każdym roku.
WITH cte AS (
    SELECT 
        employee_id, 
        YEAR(hire_date) AS rok_zatrudnienia
    FROM 
        employees
)
SELECT 
    c.rok_zatrudnienia, 
    COUNT(c.employee_id) AS liczba_pracownikow
FROM 
    cte c
GROUP BY 
    c.rok_zatrudnienia
ORDER BY 
    c.rok_zatrudnienia;


--średnie wynagrodzenie w każdym dziale, a następnie wylistuj pracowników, których wynagrodzenie jest wyższe od średniej w ich dziale
WITH CTE AS (
    SELECT 
        department_id, 
        AVG(salary) AS avg_salary
    FROM 
        employees
    GROUP BY 
        department_id
)
SELECT 
    e.department_id, 
    e.employee_id, 
    e.salary
FROM 
    employees e
JOIN 
    CTE c
ON 
    e.department_id = c.department_id
WHERE 
    e.salary > c.avg_salary;

-- Rekursywne CTE (hierarchia pracowników):
-- Znajdź wszystkich pracowników podlegających menedżerowi o ID = 1.
-- WITH RECURSIVE --employee_hierarchy AS (
--     SELECT 
--         employee_id, 
--         manager_id
--     FROM 
--         employees
--     WHERE 
--         manager_id = 1

--     UNION ALL

--     SELECT 
--         e.employee_id, 
--         e.manager_id
--     FROM 
--         employees e
--     JOIN 
--         employee_hierarchy eh
--     ON 
--         e.manager_id = eh.employee_id
-- )
-- SELECT * 
-- FROM employee_hierarchy;
