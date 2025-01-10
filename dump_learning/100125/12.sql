-- Masz tabelę sales z następującymi kolumnami:

-- sale_id (INTEGER): Identyfikator sprzedaży.
-- product_id (INTEGER): Identyfikator produktu.
-- sale_date (DATE): Data sprzedaży.
-- quantity (INTEGER): Liczba sprzedanych jednostek.
-- price (DECIMAL): Cena jednostkowa.

-- Procentowy udział sprzedaży każdego wiersza:
-- Użyj funkcji SUM z OVER do obliczenia procentowego udziału sprzedaży (quantity * price) każdego wiersza w całkowitej sprzedaży.

SELECT sale_id, quantity, price, (quantity*price) as total_price,
SUM(quantity*price) OVER () as overall_total_price,
(quantity * price) * 100.0 / SUM(quantity * price) OVER () as pct_share
from sales;



-- Podział sprzedaży na kwartyle:
-- Użyj funkcji NTILE(4) do przypisania każdej sprzedaży do jednego z 4 kwartyli według wartości sprzedaży.
SELECT sale_id, quantity, price,
NTILE(4) OVER (ORDER BY (quantity * price)) as Tile
from sales;




SELECT product_id, sale_date,
    ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY sale_date) as Numerowanie
FROM sales;


-- Użyj funkcji RANK() do znalezienia najlepszej sprzedaży (quantity * price) w każdym miesiącu.
-- Najlepsza sprzedaż (quantity * price) w każdym miesiącu
SELECT 
    sale_date,
    product_id,
    quantity * price AS total_sale,
    RANK() OVER (
        PARTITION BY MONTH(sale_date) 
        ORDER BY quantity * price DESC
    ) AS najlepsza_sprzedaz
FROM 
    sales;


-- Oblicz skumulowaną sprzedaż (SUM(quantity * price)) dla każdego product_id według daty.
SELECT sale_date, product_id,
    SUM(quantity*price) OVER (PARTITION BY product_id ORDER BY sale_date) as skumulowana
FROM sales;