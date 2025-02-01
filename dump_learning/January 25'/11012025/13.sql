-- Kontekst:
-- Masz tabelę employees z następującymi kolumnami:

-- employee_id (INTEGER): Identyfikator pracownika.
-- department_id (INTEGER): Identyfikator działu.
-- salary (DECIMAL): Wynagrodzenie pracownika.
-- hire_date (DATE): Data zatrudnienia.
-- Zadania:
-- Znalezienie pracowników o najwyższym wynagrodzeniu w ich dziale:
-- Użyj podzapytania skorelowanego w WHERE.
SELECT employee_id, department_id, salary
FROM employees e
WHERE salary = (SELECT MAX(e2.salary) FROM employees e2 where e.department_id = e2.department_id)



-- Znalezienie pracowników, których wynagrodzenie jest wyższe od średniego wynagrodzenia w ich dziale:
-- Skorzystaj z podzapytania w WHERE, aby obliczyć średnie wynagrodzenie w dziale.
SELECT employee_id, department_id, salary
FROM employees e
WHERE salary > (SELECT AVG(e2.salary) from employees e2 where e.department_id = e2.department_id)


-- Znalezienie najwcześniej zatrudnionego pracownika w każdym dziale:
-- Użyj podzapytania skorelowanego do porównania dat zatrudnienia.
SELECT employee_id, hire_date
from employees e
WHERE hire_date = (SELECT MIN(e2.hire_date) from employees e2 WHERE e.department_id = e2.department_id)



-- Zliczenie liczby pracowników w każdym dziale bez użycia GROUP BY:
-- Skorzystaj z podzapytania w SELECT.
-- Zliczenie liczby pracowników w każdym dziale bez użycia GROUP BY
SELECT 
    employee_id, 
    department_id, 
    (SELECT COUNT(*) 
     FROM employees e2 
     WHERE e2.department_id = e.department_id) AS liczba_pracownikow
FROM 
    employees e;
