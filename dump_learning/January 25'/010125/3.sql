-- SQL: Zaawansowane użycie CASE
-- Kategoryzacja danych w tabeli Sales:

-- Utwórz zapytanie, które dodaje nową kolumnę Category:
-- Jeśli Amount < 500, to Low.
-- Jeśli Amount BETWEEN 500 AND 1000, to Medium.
-- Jeśli Amount > 1000, to High.
-- Złożony CASE:

-- Wyświetl nazwę pracownika (Name), jego pensję (Salary) oraz dodatkową kolumnę Bonus:
-- Jeśli pensja jest większa niż 5000, Bonus = Salary * 0.10.
-- W przeciwnym razie Bonus = 0.
SELECT *,
CASE 
    WHEN Amount < 500 then 'Low'
    WHEN Amount BETWEEN 500 and 1000 then 'Medium'
    WHEN Amount > 1000 then 'High'
END as Category
FROM Sales;

SELECT Name, Salary,
CASE
    WHEN Salary > 5000 then Salary * 0.10
    ELSE 0
END as Bonus
from Sales;