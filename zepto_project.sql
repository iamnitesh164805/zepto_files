create database zepto;
use zepto;
drop table if exists zepto;

create table zepto (sku_id serial primary key, category varchar(120),
Name varchar(150) not null, Mrp numeric(8,2), discountPercentage numeric(5,2),
availableQuantity integer , DSP numeric (8,2), weightInGMS integer, Quantity integer );


use zepto;


select * from zepto limit 10;



-- different category products 
select distinct(category) from zepto order by category desc;

-- product name presented multiple times 

select name , count(sku_id) as count_sku from zepto group by name having count_sku >1
 order by count_sku desc;
 
-- data cleaning 
-- product with price = 0 

select * from zepto where mrp = 0 ;

delete  from zepto where mrp = 0;

SELECT * from zepto;

-- Q1. Total products kitne hain?

SELECT COUNT(*) AS total_products FROM zepto;

-- Q2. Total kitni categories hain?

SELECT COUNT(DISTINCT Category) AS total_categories FROM zepto;

-- Q3. Saari categories ki list dikhao.

SELECT DISTINCT Category FROM zepto ORDER BY Category;

-- Q4. Sabse expensive product kaun sa hai?

SELECT name, mrp FROM zepto ORDER BY mrp DESC LIMIT 1;

-- Q5. Sabse sasta product kaun sa hai?

SELECT name, mrp FROM zepto ORDER BY mrp LIMIT 1;

-- Q6. Average MRP kya hai?

SELECT ROUND(AVG(mrp),2) AS average_mrp FROM zepto;

-- Q7. Average Discount kitna hai?

SELECT ROUND(AVG(discountPercent),2) AS avg_discount FROM zepto;

-- Q8. Maximum aur Minimum Discount kitna hai?

SELECT MAX(discountPercent),MIN(discountPercent) FROM zepto;

-- Q9. Kitne products available hain?

SELECT COUNT(*) FROM zepto WHERE availableQuantity > 0;

-- Q10. Zero stock products ka count batao.

SELECT COUNT(*) FROM zepto WHERE availableQuantity = 0;

-- Q11. Har category me kitne products hain?

SELECT Category, COUNT(*) AS total_products FROM zepto
GROUP BY Category ORDER BY total_products DESC;

-- Q12. Har category ka average MRP.

SELECT Category, ROUND(AVG(mrp),2) avg_mrp FROM zepto GROUP BY Category;

-- Q13. Top 10 expensive products.

SELECT name, mrp
FROM zepto ORDER BY mrp DESC
LIMIT 10;

-- Q14. Top 10 highest discounted products.
SELECT name, discountPercent FROM zepto ORDER BY discountPercent DESC LIMIT 10;

-- Q15. Category-wise average discount.

SELECT Category, ROUND(AVG(discountPercent),2) FROM zepto GROUP BY Category;

-- Q16. Discounted price 100 se kam wale products.

SELECT * FROM zepto WHERE discountedSellingPrice <100;

-- Q17. MRP > 500 aur discount >30%.

SELECT * FROM zepto WHERE mrp>500 AND discountPercent>30;

-- Q18. Highest available quantity.

SELECT name, availableQuantity FROM zepto ORDER BY availableQuantity DESC LIMIT 1;

-- Q19. Har category ki maximum MRP.

SELECT Category, MAX(mrp) FROM zepto GROUP BY Category;

-- Q20. Products jinka MRP average se jyada hai.

SELECT * FROM zepto WHERE mrp>( SELECT AVG(mrp) FROM zepto);

-- Q21. Top 5 categories by average MRP.

SELECT Category, ROUND(AVG(mrp),2) avg_price FROM zepto GROUP BY Category
ORDER BY avg_price DESC LIMIT 5;

-- Q22. Discount Amount calculate karo.

SELECT name, mrp, discountedSellingPrice, (mrp-discountedSellingPrice) AS discount_amount
FROM zepto;

-- Q23. Kis category me sabse jyada products hain?

SELECT Category, COUNT(*) total_products FROM zepto GROUP BY Category
ORDER BY total_products DESC LIMIT 1;

-- Q24. Window Function se category ranking.

SELECT Category, COUNT(*) total_products, RANK() OVER( ORDER BY COUNT(*) DESC) ranking
FROM zepto GROUP BY Category;

-- Q25. Har category ka most expensive product.

SELECT * FROM( SELECT *, ROW_NUMBER() OVER(
PARTITION BY Category ORDER BY mrp DESC ) rn FROM zepto )x WHERE rn=1;

-- Q26. Top 3 expensive products per category.

SELECT * FROM( SELECT *, ROW_NUMBER() OVER( PARTITION BY Category ORDER BY mrp DESC) rn FROM zepto )t WHERE rn<=3;

-- Q27. Products jinka discount category average se jyada hai.

SELECT * FROM zepto z WHERE discountPercent>( SELECT AVG(discountPercent)
FROM zepto WHERE Category=z.Category );

-- Q28. Running Average MRP.

SELECT name, mrp, AVG(mrp) OVER( ORDER BY mrp ) running_avg FROM zepto;

-- Q29. Dense Rank by MRP.

SELECT name, mrp, DENSE_RANK() OVER( ORDER BY mrp DESC ) ranking FROM zepto;

-- Q30. NTILE se products ko 4 groups me divide karo.

SELECT name, mrp, NTILE(4) OVER(ORDER BY mrp DESC ) quartile FROM zepto;

-- Q31. Find the top 10 best-value products based on the discounted percentage.

select name, mrp, discountpercent from zepto order by discountpercent desc limit 10;

-- Q32. calculate estimated revenue for each category  

select category, sum(dsp*availableQuantity) as total_revenue from zepto group by category order by total_revenue;

-- Q33. find all products where mrp is greater than 500 and discount is less than 10%

select * from zepto where mrp > 500 and discountpercent < 10 order by discountpercent desc;

-- Q34. identify the top 5 categories offering the highest average discount percentage 

select category, round(avg(discountpercent),2) as avg_discount from zepto group by category limit 5;

-- Q35. find the price per gram for products above 100g and sort by best value.

select distinct name, weightInGMS, dsp, round(dsp/weightInGMS,2) as price_per_grams from zepto where weightInGMS > 100 
order by price_per_grams;

-- Q36. group the products into categories like low, medium, bulk.

select distinct name , weightInGMS , 
case when weightInGMS < 1000 then 'low' when weightINGMS < 5000 then 'medium' else 'bulk' end as weight_category from zepto














