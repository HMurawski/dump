-- #SQL: Podstawowe SELECT
-- Proste zapytania:

-- Napisz zapytanie wybierające wszystkie kolumny z tabeli Employees.
-- Wybierz tylko kolumny Name i Salary z tabeli Employees.
-- Wyświetl pracowników z wynagrodzeniem większym niż 5000.
-- Filtrowanie i sortowanie:

-- Znajdź pracowników z tabeli Employees, którzy pracują w dziale IT.
-- Posortuj wyniki według nazwiska w kolejności alfabetycznej.

SELECT * from Employees;

Select Name, Salary from Employees;

Select name, employeeID from Employees where salary > 5000;

Select name, employeeID from Employees where Departament = "IT"
order by name ASC;




SELECT SUM(Amount) from Sales;
Select AVG(Amount) from Sales;
Select min(Amount), max(Amount) from Sales;

Select sum(Amount), Region from Sales
group by Region;


Select sum(Amount), Region, Count(SaleID) from Sales
group by Region;