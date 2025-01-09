-- Masz dwie tabele:

-- employees:

-- employee_id (INTEGER): ID pracownika.
-- first_name (TEXT): Imię pracownika.
-- last_name (TEXT): Nazwisko pracownika.
-- department_id (INTEGER): ID działu.
-- salary (DECIMAL): Wynagrodzenie.
-- departments:

-- department_id (INTEGER): ID działu.
-- department_name (TEXT): Nazwa działu.
-- Zadania:
-- Najwyższe wynagrodzenie w każdym dziale:

-- Znajdź najwyższe wynagrodzenie w każdym dziale, używając podzapytania w sekcji SELECT.
-- Pracownicy z najwyższym wynagrodzeniem w każdym dziale:

-- Wylistuj pracowników, którzy mają najwyższe wynagrodzenie w swoim dziale (użyj podzapytania w sekcji WHERE).
-- Średnie wynagrodzenie w każdym dziale:

-- Znajdź nazwy działów, gdzie średnie wynagrodzenie jest wyższe niż 5000 (użyj podzapytania w sekcji FROM).
-- Pracownicy o wynagrodzeniu powyżej średniej w swoim dziale:

-- Wylistuj pracowników, których wynagrodzenie jest wyższe niż średnie wynagrodzenie w ich dziale (użyj podzapytania w sekcji WHERE).


-- Znajdź nazwy działów, gdzie średnie wynagrodzenie jest wyższe niż 5000
SELECT AVG(e.salary) as avg_salary, d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
GROUP BY e.department_id
HAVING AVG(e.salary) > 5000;



-- Wylistuj pracowników, których wynagrodzenie jest wyższe niż średnie wynagrodzenie w ich dziale

SELECT employee_id, department_id, salary
FROM employees e1
WHERE salary > (SELECT AVG(salary) from employees where e2.department_id = e1.department_id);


-- Znajdź nazwy działów, gdzie średnie wynagrodzenie jest wyższe niż 5000
SELECT d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
GROUP BY d.department_name
HAVING AVG(e.salary) > 5000

-- Najwyższe wynagrodzenie w każdym dziale
SELECT 
    department_id,
    (SELECT MAX(salary) 
     FROM employees e2 
     WHERE e2.department_id = e1.department_id) AS max_salary
FROM 
    employees e1
GROUP BY 
    department_id;

-- Pracownicy z najwyższym wynagrodzeniem w każdym dziale
SELECT 
    employee_id, 
    department_id, 
    salary
FROM 
    employees e1
WHERE 
    salary = (SELECT MAX(e2.salary)
              FROM employees e2
              WHERE e2.department_id = e1.department_id);


-- Średnie wynagrodzenie w każdym dziale
SELECT 
    department_id, 
    AVG(salary) AS average_salary
FROM 
    employees
GROUP BY 
    department_id;
