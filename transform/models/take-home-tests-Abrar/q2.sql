SELECT vendor_name, COUNT(customer_id) AS customer_count, SUM(gmv_local) AS total_gmv
FROM `vendors1.vendors`
LEFT JOIN `orders1.orders`
ON `vendors1.vendors`.id = `orders1.orders`.vendor_id
WHERE `vendors1.vendors`.country_name = 'Taiwan'
GROUP BY vendor_name
ORDER BY customer_count DESC
