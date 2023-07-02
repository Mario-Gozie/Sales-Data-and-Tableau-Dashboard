--viewing the table 
Select * from Sales_Data_Cleaned;

-- A little Data Cleaning
-- deleting null rows

select * from Sales_Data_Cleaned
where Date is null;

delete from Sales_Data_Cleaned
where Date is null;

--Total sales

select sum([sale Amount]) as Total_sales from Sales_Data_Cleaned

--Total sales per year
select year(Date) as Years,sum([Sale Amount]) as 
Year_Total_sales from Sales_Data_Cleaned
group by year(Date);

-- Total sales per year per month
select year(date) as Years, DATENAME(Month, date) as months,
sum([Sale Amount]) as Total_sales from Sales_Data_Cleaned
group by YEAR(date), DATENAME(Month, date);

-- I coule put this in a pivot table to make it better
go
--Alternatively

with yet_to_pivot as (select year(date) as Years, DATENAME(Month, date) as months,
[Sale Amount] from Sales_Data_Cleaned)

select * from yet_to_pivot
pivot(sum([Sale Amount]) for Years in ([2018], [2019])) as my_pivot

go

-- Total item sold
select sum(units) as total_items_sold from Sales_Data_Cleaned;

--Total per year
select year(date) as Years, sum(units) as total_item_sold from Sales_Data_Cleaned
group by year(date);

-- Total items per year AND MONTH
select Year(date) as Years, DATENAME(MONTH, DATE) AS MONTH, 
SUM(UNITS) as total_items from Sales_Data_Cleaned
group by year(date), DATENAME(month, date);

--Alternatively

with yet_to_pivot as (select Year(date) as years, 
datename(month, date) as Months, units from sales_data_cleaned)

select * from yet_to_pivot
pivot(sum(units) for years in ([2018],[2019])) as my_pivot;

-- Total Managers

select count(distinct(manager)) as Managers from Sales_Data_Cleaned

-- Total Managers per year
select year(date) as years, count(distinct(manager))
as mangers from Sales_Data_Cleaned
group by year(date);

-- Total Managers per month and year
select year(date) as years, datename(month, date) as months,
count(distinct(Manager)) as managers from Sales_Data_Cleaned
group by Year(date), datename(MONTH, DATE);

-- Total Sales Man
select count(distinct([sales Man])) total_sales_man from Sales_Data_Cleaned

-- Total sales person per year

select Year(date) as years, count(distinct([sales man]))
AS Total_sales_man from Sales_Data_Cleaned
group by year(date);

-- Sales Man Per Month and year

select Year(date) as years, DATENAME(MONTH, DATE) AS Months, count(distinct([sales man]))
AS Total_sales_man from Sales_Data_Cleaned
group by year(date), datename(month, date);

-- Performance of Mangers for sales in propotion for all years

select Manager, concat(round((sum([Sale Amount])/
(select sum([sale amount]) from Sales_Data_Cleaned)*100),2),' %')
as sales_propotion
from Sales_Data_Cleaned
group by Manager;

-- Performance of Mangers per year
with partial_sum as (select year(date) as Years, Manager,
sum([sale amount]) as Amount_per_Manager
from Sales_Data_Cleaned
group by year(date), Manager),

 include_sum_per_year as (select years, Manager, Amount_per_Manager,
sum(Amount_per_Manager) over(partition by years 
order by years) as amount_per_year from partial_sum)

select Years, Manager, concat(round(((Amount_per_manager/amount_per_year)* 100),2),' %') as propotion
from include_sum_per_year;

-- Quantity sold per item irrespective of year
select item, sum([sale Amount]) as
Total_Revenue from Sales_Data_Cleaned
group by item;

-- Quantity sold per item per year
select distinct year(date) as years, item, sum([sale Amount]) 
over(partition by year(date), item order by year(date)) as
Total_Revenue from Sales_Data_Cleaned



go

-- sales per region in propotion for all years
select Region, concat(round((sum([Sale Amount])/
(select sum([Sale Amount]) from Sales_Data_Cleaned)*100),2),' %') as sales_propotion_region
from Sales_Data_Cleaned
group by Region;

go
-- propotion of sales for region per year
with just_totals as (select year(date) as years, region, sum([Sale Amount]) 
as total_amount from Sales_Data_Cleaned
group by year(date), Region),

total_years as (select years, region, total_amount, sum(total_amount)
over(partition by years order by years) as year_total from just_totals)

select years, region, concat(round(((total_amount/
year_total)*100),2),' %') as propotion from total_years;


go

-- Total sales per sales Man

select distinct([sales Man]), sum([sale Amount]) 
as total_sales from Sales_Data_Cleaned
group by [Sales Man]
order by total_sales desc;

-- Total for sales person per year

select distinct year(date) as years, [Sales Man], sum([sale Amount])
over(partition by year(date), [Sales Man] order by [Sales Man])
as Total_per_sale_Person
from Sales_Data_Cleaned;