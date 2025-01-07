-- Załóżmy, że masz tabelę Employees:

-- EmployeeID, Name, DepartmentID, Salary, HireDate.
-- Zadania:

-- Dodaj kolumnę SalaryRank, która przypisuje rangę pensji (od najwyższej do najniższej) w każdym dziale (DepartmentID).
-- Dodaj kolumnę CumulativeSalary, która oblicza skumulowaną sumę pensji w każdym dziale, posortowaną według pensji.
-- Znajdź pracownika z najdłuższym stażem w każdym dziale (na podstawie HireDate).


SELECT Name,
        DepartmentID,
        Salary,
        RANK() OVER(PARTITION BY DepartmentID ORDER BY Salary DESC)as SalaryRank,
        SUM(Salary) OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) as CumulativeSalary
FROM Employees;


WITH LongestTenure AS (
    SELECT 
        Name,
        DepartmentID,
        HireDate,
        RANK() OVER(PARTITION BY DepartmentID ORDER BY HireDate ASC) as TenureRank
    FROM Employees
)
SELECT 
    Name,
    DepartmentID,
    HireDate
FROM LongestTenure
WHERE TenureRank = 1;



-- Załóżmy, że masz dwie tabele:

-- Orders:
-- OrderID, CustomerID, OrderDate, TotalAmount.
-- Customers:
-- CustomerID, Name, Region.
-- Zadania:

-- Znajdź klientów, którzy złożyli zamówienia o wartości powyżej 1000.
-- Oblicz całkowitą wartość zamówień (TotalAmount) dla każdego regionu.
-- Znajdź klientów, którzy nie złożyli żadnego zamówienia (wykorzystaj LEFT JOIN).

SELECT c.Name, c.CustomerID, o.TotalAmount
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE o.TotalAmount > 1000;

SELECT c.Region, o.TotalAmount, o.CustomerID,
SUM(o.TotalAmount) OVER (PARTITION BY c.Region) as TotalAmount
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID;

SELECT c.CustomerID, c.Name, o.OrderID
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;



-- 3. Podzapytania
-- Załóżmy, że masz tabelę Sales:

-- SaleID, Region, Amount, Date.
-- Zadania:

-- Znajdź regiony, które miały sprzedaż powyżej średniej dla wszystkich regionów.
-- Wyświetl szczegóły transakcji, które miały miejsce w kwartale z najwyższą całkowitą sprzedażą.
-- Dodaj kolumnę AboveRegionAvg, która wskazuje, czy Amount jest większe od średniej dla danego regionu.

-- Znajdź regiony, które miały sprzedaż powyżej średniej dla wszystkich regionów.
SELECT Region, Amount
FROM Sales
WHERE Amount > (select AVG(Amount) from Sales);




-- Wyświetl szczegóły transakcji, które miały miejsce w kwartale z najwyższą całkowitą sprzedażą.

with quarter_data as 
(SELECT QUARTER(Date) as kwartal,
    SUM(Amount) as Total_sales
from Sales
GROUP BY kwartal)
,
TopQuarter as (
    SELECT kwartal
    from quarter_data
    where Total_sales = (select max(Total_sales) FROM quarter_data)
)
SELECT *
FROM Sales s
Join TopQuarter tq
ON Quarter(s.date) = tq.Quarter




-- Dodaj kolumnę AboveRegionAvg, która wskazuje, czy Amount jest większe od średniej dla danego regionu.

with CTE as
(SELECT Amount, Region,
    AVG(Amount) OVER (PARTITION BY Region) as avg_region
FROM Sales)
SELECT s.Amount, s.Region, c.avg_region, 
    CASE
        WHEN s.Amount > c.avg_region THEN "yes"
        ELSE "No"
        END as AboveRegionAvg
FROM Sales s
JOIN CTE c
ON s.Region = c.Region AND s.Amount = c.Amount




-- 4. Grupowanie i agregacja
-- Załóżmy, że masz tabelę Products:

-- ProductID, Category, Price, Stock, SupplierID.
-- Zadania:

-- Oblicz średnią cenę i całkowitą liczbę produktów w każdej kategorii.
-- Znajdź dostawców (SupplierID), którzy mają więcej niż 50 produktów na stanie (Stock).
-- Znajdź kategorię, która generuje najwyższą średnią cenę produktu.

SELECT Price, Category, 
    AVG(Price) OVER (PARTITION BY Category) as sr_cena_produktu_w_kategorii,
    COUNT(ProductID) OVER (PARTITION BY Category) as liczba_produktow_w_kategorii
FROM Products;

SELECT SupplierID,
SUM(Stock) OVER (PARTITION BY SupplierID) as stock_dostawcy
FROM Products
HAVING stock_dostawcy > 50;

SELECT 
    AVG(Price) as avg_price, Category
FROM Products
GROUP BY Category
order BY avg_price DESC
--LIMIT 1;