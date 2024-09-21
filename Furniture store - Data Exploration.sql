SELECT *
FROM store;

-- Top Selling Categories

SELECT 
    category, FORMAT(SUM(sales),0) AS total_sales
FROM
    store
GROUP BY category
ORDER BY 2 DESC;

-- Ranking categories based on their profit

SELECT category,
	FORMAT(ROUND(SUM((profit_margin/100)*revenue),2),2) as total_profit,
    RANK() OVER(ORDER BY SUM((profit_margin/100)*revenue) Desc) as rnk
FROM store
GROUP BY category;


-- Average profit margin for products with more than 40 sales
SELECT 
    category,
    ROUND(AVG(profit_margin), 2) AS average_profit_margin,
    -- Dividing the profit margin into categories(High,Medium and Low)
    CASE 
        WHEN AVG(profit_margin) >= 30 THEN 'High'
        WHEN AVG(profit_margin) BETWEEN 28 AND 29.99 THEN 'Medium'
        ELSE 'Low'	
    END AS profit_margin_category
FROM store
WHERE sales > 40
GROUP BY category
ORDER BY 2;


-- Calculating overall profit margin by brand and store type
WITH ProfitMargins AS
(
    SELECT
        brand,
        store_type,
        SUM(revenue) AS total_revenue,
        SUM(cost) AS total_cost,
        ROUND((SUM(revenue) - SUM(cost)) / SUM(revenue) * 100,2) AS profit_margin
    FROM store
    GROUP BY brand, store_type
)
-- Retrieve results for analysis
SELECT
    brand,
    store_type,
    profit_margin
FROM ProfitMargins
ORDER BY brand, store_type;


-- Calculating turnover rate for each category
-- Chair has the highest turnover rate(inventory is depleting fast). This category is at risk of running out of stock.
SELECT category,
	FORMAT(SUM(sales),0) as total_sales,
		FORMAT(SUM(inventory),0) as current_inventory,
        ROUND((SUM(sales) / SUM(inventory)),3) as turnover_rate
FROM store
GROUP BY category
ORDER BY turnover_rate desc;
  


-- Finding which location and category combinations experience the shortest delivery days
WITH delivery AS
(
    SELECT location, category, ROUND(AVG(delivery_days),2) AS Avg_delivery_days
    FROM store
    GROUP BY location, category
),
delivery_2 AS
(
    SELECT Location, Category, Avg_delivery_days,
    RANK() OVER(PARTITION BY Location ORDER BY Avg_delivery_days DESC) AS ranking
    FROM delivery
)
-- Ranking each combination
SELECT *
FROM delivery_2
WHERE ranking <= 5;


-- Identifying which seasons contribute the most to revenue and how different categories and materials perform in each season.
WITH seasons_cte AS
(
	SELECT season, category, material, ROUND(SUM(revenue),2) as total_revenue
    FROM store
    GROUP BY season, category, material
),
cte_2 AS
(
	SELECT season, category, material, total_revenue,
    RANK() OVER(PARTITION BY season ORDER BY total_revenue desc) as rn
    FROM seasons_cte
)
SELECT *
FROM cte_2
WHERE rn <= 5;


-- Finding the difference in total revenue between the highest and the lowest-selling categories
WITH category_revenue AS
(
    SELECT 
        category,
        ROUND(SUM(revenue),2) AS total_revenue
    FROM store
    GROUP BY category
)
SELECT 
    h.category AS HSC,                   #Higest Selling Category
    h.total_revenue AS highest_revenue,
    l.category AS LSC,					 #Lowest Selling Category
    l.total_revenue AS lowest_revenue,
    ROUND((h.total_revenue - l.total_revenue),2) AS revenue_difference
FROM category_revenue as h
JOIN category_revenue as l
	ON h.total_revenue = (SELECT MAX(total_revenue) FROM category_revenue)
	AND l.total_revenue = (SELECT MIN(total_revenue) FROM category_revenue);
