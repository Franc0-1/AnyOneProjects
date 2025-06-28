-- TODO: This query will return a table with two columns; customer_state, and 
-- Revenue. The first one will have the letters that identify the top 10 states 
-- with most revenue and the second one the total revenue of each.
-- HINT: All orders should have a delivered status and the actual delivery date 
-- should be not null. 

WITH payments_per_order AS (
    SELECT 
        order_id,
        SUM(payment_value) AS total_payment
    FROM olist_order_payments
    GROUP BY order_id
)

SELECT 
    c.customer_state,
    SUM(p.total_payment) AS Revenue
FROM olist_orders o
JOIN payments_per_order p ON o.order_id = p.order_id
JOIN olist_customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY revenue DESC
LIMIT 10;