SELECT o.country_name, v.vendor_name, SUM(o.gmv_local) AS total_gmv
FROM orders1.orders AS o
JOIN vendors1.vendors AS v ON o.vendor_id = v.id
WHERE v.is_active = TRUE
GROUP BY o.country_name, v.vendor_name
HAVING SUM(o.gmv_local) = (
    SELECT MAX(total_gmv)
    FROM (
        SELECT o2.country_name, v2.vendor_name, SUM(o2.gmv_local) AS total_gmv
        FROM orders1.orders AS o2
        JOIN vendors1.vendors AS v2 ON o2.vendor_id = v2.id
        WHERE v2.is_active = TRUE
        GROUP BY o2.country_name, v2.vendor_name
    ) AS sq
    WHERE sq.country_name = o.country_name
)
ORDER BY o.country_name;
