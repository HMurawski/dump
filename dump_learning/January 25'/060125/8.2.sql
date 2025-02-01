-- Załóżmy, że masz tabelę Sales z kolumnami:

-- SaleID (unikalne ID transakcji),
-- Region (region sprzedaży),
-- Amount (kwota transakcji),
-- Date (data transakcji).
-- Zadania:

-- 2. Analiza sprzedaży kumulacyjnej
-- Korzystając z tabeli Sales, wykonaj następujące zadania:

-- Dodaj kolumnę CumulativeAmount, która oblicza skumulowaną wartość sprzedaży w każdym regionie, posortowaną według daty.
-- Oblicz procentowy udział każdej transakcji w całkowitej sprzedaży w swoim regionie (Amount / SUM(Amount)).

SELECT Date,
    Region,
    SUM(Amount) OVER (PARTITION BY Region ORDER BY Date) as CumulativeAmount,
    (Amount * 1.0 / SUM(Amount) OVER (Partition by Region)) * 100 as Pct_tr
FROM Sales;



-- 4. Analiza kwartalna
-- Korzystając z tabeli Sales, wykonaj następujące zadania:

-- Dodaj kolumnę Quarter, która przypisuje kwartał (Q1, Q2, itp.) na podstawie daty transakcji.
-- Oblicz sumę sprzedaży w każdym kwartale i dodaj kolumnę QuarterTotalSales dla każdej transakcji.
-- Dodaj kolumnę QuarterRank, która przypisuje rangę regionom na podstawie całkowitej sprzedaży w kwartale.

WITH QuarterSales AS (
    SELECT 
        Region,
        QUARTER(Date) AS Quarter,
        SUM(Amount) AS QuarterTotalSales
    FROM Sales
    GROUP BY Region, QUARTER(Date)
)
SELECT 
    s.Region,
    s.Amount,
    s.Date,
    QUARTER(s.Date) AS Quarter,
    q.QuarterTotalSales,
    RANK() OVER (PARTITION BY q.Quarter ORDER BY q.QuarterTotalSales DESC) AS QuarterRank
FROM Sales s
JOIN QuarterSales q
ON s.Region = q.Region AND QUARTER(s.Date) = q.Quarter;
