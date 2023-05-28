SELECT country_name, sum(gmv_local) AS total_gmv
FROM `orders1.orders`
GROUP BY country_name
