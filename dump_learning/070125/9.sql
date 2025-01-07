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


