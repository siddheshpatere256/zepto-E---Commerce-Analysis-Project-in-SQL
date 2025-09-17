# Zepto Project

create database project_zepto;

use project_zepto;

select * from zepto;

-- disable safe mode

SET SQL_SAFE_UPDATES = 0;

-- enable safe mode

SET SQL_SAFE_UPDATES = 1;


# Data exploration
 
 -- 1. Count of rows

create view count_rows as 
select count(*) from zepto;
 
select * from count_rows;

-- 2. find null values

create view find_null_values as
select * from zepto
where category is null or
name is null or
mrp is null or
discountpercent is null or
availablequantity is null or
discountedsellingprice is null or
weightingms is null or
outofstock is null or
quantity is null;

select * from find_null_values;

-- 3. get all unique product categories

create view  unique_category as
select distinct category
from zepto;

select * from unique_category;
 
-- 4. how many product out of stock

create view outstock_product as
select name as out_of_stock
from zepto
where availablequantity = 0;

select * from outstock_product;

-- 5. how many product in stock

create view instockproduct as
select distinct name as in_stock
from zepto
where availablequantity <> 0;

select * from instockproduct;

-- 6. product name multiple times

create view product_name_multiple_times as
select name, count(name) as multiple_times_product_name
from zepto
group by name 
having count(name) > 1
order by count(name) desc;

select * from product_name_multiple_times;

--------------------------------------------------------------------------------------------------------------------

# Data Cleaning

-- product with 0 price 

create view product_with_0_price as
select * from 
zepto
where mrp=0;

select * from product_with_0_price;


delete from zepto
where mrp = 0;


-- convert paise into rupees

update  zepto
set mrp = mrp/100;

update zepto
set discountedSellingPrice=discountedSellingPrice/100;




--------------------------------------------------------------------------------------------------------------------

# Bussiness Insights

-- 1. Found top 10 best-value products based on discount percentage

create view best_value_product_based_on_Discount as
select name, discountPercent
from zepto
order by discountPercent desc
limit 10;

select * from best_value_product_based_on_Discount;

-- 2. Identified high-MRP products that are currently out of stock

select Category, name, mrp, outOfStock
from zepto
where outOfStock="True"
order by mrp desc;

-- 3. Estimated total revenue for each product category

select category, sum(discountedSellingPrice * availablequantity) as total_revenue
from zepto
group by category
order by total_revenue desc;

-- 4. Filtered expensive products (MRP > ₹500) with  discount lesss than 10 %

select distinct name, mrp, discountPercent from zepto
where mrp > 500 and discountPercent < 10
order by mrp desc, discountpercent desc;

-- 5. Ranked top 5 categories offering highest average discounts

select category, avg(discountpercent) as average_discount
from zepto
group by category
order by average_discount desc
limit 5 ;



-- 6. Calculated price per gram to identify value-for-money products

-- 7. Grouped products based on weight into Low, Medium, and Bulk categories

select distinct name, weightInGms,
case
	when weightInGms < 1000 then "low"
    when weightInGms < 5000 then "medium"
    else "bulk"
end
as category
from zepto;

-- 8. Measured total inventory weight per product category

select distinct category, sum(weightInGms * availablequantity) as inventory_weight
from zepto
group by category
order by inventory_weight desc; 

--------------------------------------------------------------------------------------------------------------------------------------------------

# Project Zepto

# Data Exploration

-- 1. Count of rows

select * from count_rows;

-- 2. Find null values

select * from find_null_values;

-- 3. All unique product categories

select * from unique_category;

-- 4. Out of stock products

select * from outstock_product;

-- 5. In stock products

select * from instockproduct;

-- 6. Product names multiple times

select * from product_name_multiple_times;



# Data Cleaning

-- 1. product with zero price

select * from product_with_0_price;

delete from zepto
where mrp = 0;

-- 2.Convert Paise into Rupees

update  zepto
set mrp = mrp/100;

update zepto
set discountedSellingPrice=discountedSellingPrice/100;


# Bussiness Insights










