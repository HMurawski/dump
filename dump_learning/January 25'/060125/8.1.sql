-- 1. Ranking sprzedaży
-- Załóżmy, że masz tabelę Sales z kolumnami:

-- SaleID (unikalne ID transakcji),
-- Region (region sprzedaży),
-- Amount (kwota transakcji),
-- Date (data transakcji).
-- Zadania:

-- Dodaj kolumnę Rank, która przypisuje rangę transakcjom w każdym regionie na podstawie Amount (malejąco).
-- Dodaj kolumnę DenseRank, która przypisuje rangę transakcjom w każdym regionie (bez przerw w numeracji) na podstawie Amount.
-- Znajdź trzy największe transakcje w każdym regionie.


SELECT
    SaleID,
    Region,
    Amount,
    RANK() OVER (PARTITION BY Region ORDER BY Amount DESC) as Rank,
    DENSE_RANK() Over (PARTITION BY Region ORDER BY Amount DESC) as DenseRank
FROM Sales;

WITH RankedSales AS (
    SELECT
        SaleID,
        Region,
        Amount,
        RANK() OVER (PARTITION BY Region ORDER BY Amount DESC) AS Rank
    FROM Sales
)
SELECT SaleID, Region, Amount, Rank
FROM RankedSales
WHERE Rank <= 3
ORDER BY Region, Rank;



-- 3. Analiza pracowników
-- Załóżmy, że masz tabelę Employees:

-- EmployeeID,
-- Name,
-- DepartmentID,
-- Salary.
-- Zadania:

-- Dodaj kolumnę SalaryRank, która przypisuje rangę pensji w każdym dziale (od najwyższej do najniższej).
-- Oblicz średnią pensję w każdym dziale i dodaj kolumnę SalaryDifference, która pokazuje różnicę między pensją pracownika a średnią pensją w jego dziale.
-- Oblicz skumulowaną pensję w każdym dziale (CumulativeSalary), posortowaną według Salary.

SELECT Name, Salary, 
    RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) as SalaryRank,
    AVG(Salary) OVER (PARTITION BY DepartmentID) as avg_dep_salary,
    Salary - avg_dep_salary AS SalaryDifference,
    SUM(Salary) OVER (PARTITION BY DepartmentID order by Salary) as CumulativeSalary
FROM Employees