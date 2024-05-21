WITH SubcategorySales AS (
    SELECT
        prod_subcategory,
        EXTRACT(year FROM order_date) AS order_year,
        SUM(total_sales) AS total_sales
    FROM
        products p
    JOIN orders o ON p.product_id = o.product_id
    WHERE
        EXTRACT(year FROM order_date) BETWEEN 1998 AND 2001
    GROUP BY
        prod_subcategory, EXTRACT(year FROM order_date)
),
PreviousYearSales AS (
    SELECT
        prod_subcategory,
        EXTRACT(year FROM order_date) AS order_year,
        SUM(total_sales) AS total_sales
    FROM
        products p
    JOIN orders o ON p.product_id = o.product_id
    WHERE
        EXTRACT(year FROM order_date) = 1997
    GROUP BY
        prod_subcategory, EXTRACT(year FROM order_date)
)
SELECT
    s.prod_subcategory
FROM
    SubcategorySales s
JOIN PreviousYearSales p ON s.prod_subcategory = p.prod_subcategory
WHERE
    s.total_sales > p.total_sales
GROUP BY
    s.prod_subcategory
HAVING
    COUNT(DISTINCT s.order_year) = 4;
