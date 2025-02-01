-- SQL: Funkcje agregujące i filtrowanie
-- Załóżmy, że masz tabelę Sales:

-- SaleID (unikalne ID transakcji),
-- Region (region sprzedaży),
-- Amount (kwota transakcji),
-- Date (data transakcji).
-- Zadania:

-- Policz całkowitą sprzedaż (SUM) dla każdego regionu i posortuj wyniki malejąco.
-- Oblicz średnią wartość transakcji (AVG) dla każdego regionu, ale uwzględnij tylko transakcje, w których Amount > 500.
-- Znajdź najwcześniejszą i najpóźniejszą datę transakcji w regionie "North".
-- Wyświetl wszystkie transakcje z regionów, które miały łączną sprzedaż powyżej 1000 (użyj HAVING).

SELECT SUM(Amount) as suma_sprzedazy, Region
FROM Sales
GROUP BY Region
ORDER BY suma_sprzedazy DESC;

SELECT AVG(Amount) as srednia_sprzedazy, Region
FROM Sales
WHERE Amount > 500
GROUP BY Region;

SELECT SaleID, Region, SUM(Amount) as laczna_sprzedaz
from sales
group by Region, SaleID
HAVING SUM(Amount) > 1000;



SELECT 
    MIN(Date) as min_date,
    MAX(Date) as max_date
FROM Sales
WHERE Region = "North";


SELECT 
    SaleID, 
    Region, 
    Amount, 
    SUM(Amount) OVER (PARTITION BY Region) AS TotalRegionSales
FROM Sales
WHERE SUM(Amount) OVER (PARTITION BY Region) > 1000;
