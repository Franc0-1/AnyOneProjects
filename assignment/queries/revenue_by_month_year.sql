-- TODO: This query will return a table with the revenue by month and year. It
-- will have different columns: month_no, with the month numbers going from 01
-- to 12; month, with the 3 first letters of each month (e.g. Jan, Feb);
-- Year2016, with the revenue per month of 2016 (0.00 if it doesn't exist);
-- Year2017, with the revenue per month of 2017 (0.00 if it doesn't exist) and
-- Year2018, with the revenue per month of 2018 (0.00 if it doesn't exist).
-- use payment and order list 

SELECT
    month_no,
    month,
    ROUND(SUM(CASE WHEN year = '2016' THEN min_payment ELSE 0 END), 10) AS Year2016,
    ROUND(SUM(CASE WHEN year = '2017' THEN min_payment ELSE 0 END), 10) AS Year2017,
    ROUND(SUM(CASE WHEN year = '2018' THEN min_payment ELSE 0 END), 10) AS Year2018
FROM (
    SELECT 
        STRFTIME('%Y', o.order_delivered_customer_date) AS year,
        STRFTIME('%m', o.order_delivered_customer_date) AS month_no,
        CASE STRFTIME('%m', o.order_delivered_customer_date)
            WHEN '01' THEN 'Jan'
            WHEN '02' THEN 'Feb'
            WHEN '03' THEN 'Mar'
            WHEN '04' THEN 'Apr'
            WHEN '05' THEN 'May'
            WHEN '06' THEN 'Jun'
            WHEN '07' THEN 'Jul'
            WHEN '08' THEN 'Aug'
            WHEN '09' THEN 'Sep'
            WHEN '10' THEN 'Oct'
            WHEN '11' THEN 'Nov'
            WHEN '12' THEN 'Dec'
        END AS month,
        MIN(op.payment_value) AS min_payment
    FROM olist_orders o
    JOIN olist_order_payments op ON o.order_id = op.order_id
    WHERE o.order_status = 'delivered'
      AND o.order_delivered_customer_date IS NOT NULL
    GROUP BY o.order_id
) AS subquery
GROUP BY month_no
ORDER BY month_no;