SELECT
  country_name,
  order_year,
  vendor_name,
  total_gmv
FROM(
  SELECT
    country_name,
    order_year,
    vendor_name,
    total_gmv,
    ROW_NUMBER() OVER (PARTITION BY order_year, country_name, vendor_name ORDER BY total_gmv DESC) AS vendor_year_rank
  FROM (SELECT
  o.country_name,
  EXTRACT(YEAR
  FROM
    o.date_local) AS order_year,
  v.vendor_name,
  SUM(o.gmv_local) AS total_gmv
FROM
  `vendors1.vendors` AS v
JOIN
  `orders1.orders` AS o
ON
  o.vendor_id = v.id
WHERE
  v.is_active = TRUE
GROUP BY
  o.country_name,
  order_year,
  v.vendor_name
  )
)
WHERE
  vendor_year_rank <= 3
ORDER BY
    order_year,country_name;
