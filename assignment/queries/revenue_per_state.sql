-- TODO: This query will return a table with two columns; customer_state, and 
-- Revenue. The first one will have the letters that identify the top 10 states 
-- with most revenue and the second one the total revenue of each.
-- HINT: All orders should have a delivered status and the actual delivery date 
-- should be not null. 
SELECT TOP 10
	c.customer_state,
	SUM(oi.price * oi.quantity) AS Revenue
FROM
	olist_orders o
	JOIN olist_order_items oi ON o.order_id = oi.order_id
	JOIN customers c ON o.customer_id = c.customer_id
WHERE
	o.order_status = 'delivered'
	AND o.delivered_at IS NOT NULL
GROUP BY
	c.customer_state
ORDER BY
	Revenue DESC;