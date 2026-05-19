Total Revenue
select sum(total_price) as Total_Revenue from pizzasales

Average Order Value
select sum(total_price)/count(distinct order_id) as Average_order_id from pizzasales

Total Pizza Sold
select sum(quantity) as Total_pizza_sold from pizzasales

Total Orders placed
select count(distinct order_id) as Total_orders from pizzasales

Average Pizzas Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_Pizzas_per_order
FROM pizzasales

Daily Trend for Total Orders
SELECT ('{Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday}'::text[])[EXTRACT(DOW FROM order_date) + 1] AS order_day,
COUNT(DISTINCT order_id) AS total_orders 
FROM pizzasales
GROUP BY EXTRACT(DOW FROM order_date)
ORDER BY total_orders


Monthly Trend for Orders
SELECT
('{January, February, March, April, May, June, July, August, September, October, November, December}'::text[])[EXTRACT(MONTH FROM order_date)] AS order_month, COUNT(DISTINCT order_id) AS total_orders 
FROM pizzasales
GROUP BY EXTRACT(MONTH FROM order_date)
ORDER BY total_orders

CREATE OR REPLACE FUNCTION dow_name(p_index integer)
RETURNS text LANGUAGE sql STRICT IMMUTABLE PARALLEL SAFE AS
$$
SELECT (array['Sun', 'Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat'])[p_index + 1];
$$;


% of Sales by Pizza Category
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizzasales) AS DECIMAL(10,2)) AS PERCENTAGESALES
FROM pizzasales
GROUP BY pizza_category

% of Sales by Pizza Size
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizzasales) AS DECIMAL(10,2)) AS PCT
FROM pizzasales
GROUP BY pizza_size
ORDER BY pizza_size

Total Pizzas Sold by Pizza Category
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizzasales
WHERE EXTRACT(MONTH FROM order_date)=2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC

Top 5 Pizzas by Revenue
SELECT pizza_name, SUM(total_price) AS Total_Revenue
FROM pizzasales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
LIMIT 5

Bottom 5 Pizzas by Revenue
SELECT pizza_name, SUM(total_price) AS Total_Revenue
FROM pizzasales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC
LIMIT 5

Top 5 Pizzas by Quantity
SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizzasales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC
FETCH FIRST 5 ROWS ONLY

Bottom 5 Pizzas by Quantity
SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizzasales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC
FETCH FIRST 5 ROWS ONLY

Top 5 Pizzas by Total Orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizzasales
GROUP BY pizza_name
ORDER BY Total_Orders DESC
LIMIT 5

Bottom 5 Pizzas by Total Orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizzasales
GROUP BY pizza_name
ORDER BY Total_Orders ASC
LIMIT 5


select * from pizzasales







