-- Zadanie: Analiza sprzedaży w bazie danych
-- Masz tabelę o nazwie sales zawierającą dane dotyczące sprzedaży z następującymi kolumnami:

-- sale_id (INTEGER): Unikalny identyfikator sprzedaży.
-- product_id (INTEGER): Identyfikator produktu.
-- customer_id (INTEGER): Identyfikator klienta.
-- sale_date (DATE): Data sprzedaży.
-- quantity (INTEGER): Liczba sprzedanych produktów.
-- price (DECIMAL): Cena jednostkowa produktu w momencie sprzedaży.
-- Twoje zadania:
-- Całkowity przychód: Oblicz całkowity przychód (quantity * price) dla wszystkich produktów.
-- Top 5 produktów: Znajdź 5 produktów, które wygenerowały największy przychód.
-- Najlepsi klienci: Znajdź klientów, którzy wydali najwięcej, oraz ich łączną kwotę wydaną.
-- Sprzedaż miesięczna: Oblicz przychód dla każdego miesiąca.
-- Produkty bez sprzedaży: Znajdź produkty, które nie zostały sprzedane (przyjmując, że jest tabela products z kolumną product_id).

-- Całkowity przychód
SELECT product_id, SUM(quantity*price) as total_rev
FROM sales
GROUP by product_id;

-- Top 5 produktów
SELECT product_id, SUM(quantity*price) as total_rev
FROM sales
GROUP by product_id
order by total_rev DESC
--LIMIT 5;

-- Najlepsi klienci
SELECT customer_id, SUM(quantity*price) as total_rev
FROM sales
GROUP BY customer_id;


-- Sprzedaż miesięczna:
SELECT SUM(quantity*price) as total_rev, MONTH(sale_date) as Mon
FROM sales
GROUP BY MONTH(sale_date)
ORDER BY Mon;

-- Produkty bez sprzedaży:

-- Produkty, które nie zostały sprzedane
SELECT 
    p.product_id
FROM 
    products p
LEFT JOIN 
    sales s
ON 
    p.product_id = s.product_id
WHERE 
    s.product_id IS NULL;
