-- Retorna el revenue por mes y año usando funciones compatibles con SQLite
SELECT
  strftime('%m', order_purchase_timestamp) AS month_no,
  strftime('%b', order_purchase_timestamp) AS month,
  SUM(CASE WHEN strftime('%Y', order_purchase_timestamp) = '2016' THEN price ELSE 0 END) AS Year2016,
  SUM(CASE WHEN strftime('%Y', order_purchase_timestamp) = '2017' THEN price ELSE 0 END) AS Year2017,
  SUM(CASE WHEN strftime('%Y', order_purchase_timestamp) = '2018' THEN price ELSE 0 END) AS Year2018
FROM
  olist_orders o
  JOIN olist_order_items oi ON o.order_id = oi.order_id
WHERE
  o.order_status = 'delivered'
GROUP BY
  month_no, month
ORDER BY
  month_no;

