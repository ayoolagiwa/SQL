Alter table amazondata
add column "Amount" Numeric(10,2);

update amazondata
set "Amount" = ("Unit Price" * "Quantity") - "Discount";

select distinct "Product Name", "Amount" from amazondata;

SELECT 
    "Country",
    SUM("Amount") AS "Total Revenue",
    SUM("Profit") AS "Total Profit"
FROM amazondata
GROUP BY "Country"
ORDER BY "Country";

SELECT
    "Product Name",
    SUM("Quantity") AS "Total Units Sold"
FROM amazondata
GROUP BY "Product Name";

SELECT 
    "Customer Name",
	SUM("Quantity") AS "Total Purchase",
    SUM("Amount") AS "Total Sales"
FROM amazondata
GROUP BY "Customer Name"
ORDER BY "Total Sales";

SELECT 
    "City", 
    SUM("Amount") AS "Total Sales",
    SUM("Profit") AS "Total Profit"
FROM amazondata
GROUP BY "City"
ORDER BY "Total Profit" asc;

What are the key sales and profit insights for the selected period?
SELECT 
    MIN("Amount") AS "Min Sales Value",
    MAX("Amount") AS "Max Sales Value",
    AVG("Amount") AS "Avg Sales Value",
    SUM("Amount") AS "Total Sales Value",
    MIN("Profit") AS "Min Profit",
    MAX("Profit") AS "Max Profit",
    AVG("Profit") AS "Avg Profit",
    SUM("Profit") AS "Total Profit"
FROM amazondata;













