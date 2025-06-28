-- TODO: This query will return a table with the differences between the real 
-- and estimated delivery times by month and year. It will have different 
-- columns: month_no, with the month numbers going from 01 to 12; month, with 
-- the 3 first letters of each month (e.g. Jan, Feb); Year2016_real_time, with 
-- the average delivery time per month of 2016 (NaN if it doesn't exist); 
-- Year2017_real_time, with the average delivery time per month of 2017 (NaN if 
-- it doesn't exist); Year2018_real_time, with the average delivery time per 
-- month of 2018 (NaN if it doesn't exist); Year2016_estimated_time, with the 
-- average estimated delivery time per month of 2016 (NaN if it doesn't exist); 
-- Year2017_estimated_time, with the average estimated delivery time per month 
-- of 2017 (NaN if it doesn't exist) and Year2018_estimated_time, with the 
-- average estimated delivery time per month of 2018 (NaN if it doesn't exist).
-- HINTS
-- 1. You can use the julianday function to convert a date to a number.
-- 2. order_status == 'delivered' AND order_delivered_customer_date IS NOT NULL
-- 3. Take distinct order_id.

WITH delivery_data AS (
    SELECT DISTINCT
        order_id,
        STRFTIME('%m', order_purchase_timestamp) AS month_no,
        STRFTIME('%Y', order_purchase_timestamp) AS year,
        julianday(order_delivered_customer_date) - julianday(order_purchase_timestamp) AS real_time,
        julianday(order_estimated_delivery_date) - julianday(order_purchase_timestamp) AS estimated_time
    FROM olist_orders
    WHERE 
        order_status = 'delivered'
        AND order_delivered_customer_date IS NOT NULL
)

SELECT
    month_no,
    CASE month_no
        WHEN '01' THEN 'Jan' WHEN '02' THEN 'Feb' WHEN '03' THEN 'Mar'
        WHEN '04' THEN 'Apr' WHEN '05' THEN 'May' WHEN '06' THEN 'Jun'
        WHEN '07' THEN 'Jul' WHEN '08' THEN 'Aug' WHEN '09' THEN 'Sep'
        WHEN '10' THEN 'Oct' WHEN '11' THEN 'Nov' WHEN '12' THEN 'Dec'
    END AS month,

    ROUND(AVG(CASE WHEN year = '2016' THEN real_time END), 10) AS Year2016_real_time,
    ROUND(AVG(CASE WHEN year = '2017' THEN real_time END), 10) AS Year2017_real_time,
    ROUND(AVG(CASE WHEN year = '2018' THEN real_time END), 10) AS Year2018_real_time,

    ROUND(AVG(CASE WHEN year = '2016' THEN estimated_time END), 10) AS Year2016_estimated_time,
    ROUND(AVG(CASE WHEN year = '2017' THEN estimated_time END), 10) AS Year2017_estimated_time,
    ROUND(AVG(CASE WHEN year = '2018' THEN estimated_time END), 10) AS Year2018_estimated_time

FROM delivery_data
GROUP BY month_no
ORDER BY month_no;
