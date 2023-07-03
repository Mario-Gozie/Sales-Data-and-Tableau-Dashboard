## INTRODUCTION


![Alt Text](https://github.com/Mario-Gozie/Sales-Data-and-Tableau-Dashboard/blob/main/Images/introo.jpg)


This is a Project on a small sales dataset of two years (2018/2019), for exploring data cleaning with excel and visualization with Tableau.


_**NB: This is a dummy dataset and does not represent any organization. it is just for practice**_

## TOOLS 
* Figma
* Tableau
* SQL

## THE TASK WITH SQL

### VIEWING TABLE

`Select * from Sales_Data_Cleaned;`

## DATA CLEANING

* I queried the database and noticed there are null values and had to delete them to ease Analysis.
  
`select * from Sales_Data_Cleaned
where Date is null;`

`delete from Sales_Data_Cleaned
where Date is null;`

![Alt Text]()

### TOTAL SALES IRRESPECTIVE OF THE YEAR

`select sum([sale Amount]) as Total_sales from Sales_Data_Cleaned`

![Alt Text]()

### TOTAL SALAES PER YEAR

`select year(Date) as Years,sum([Sale Amount]) as 
Year_Total_sales from Sales_Data_Cleaned
group by year(Date);`

### TOTAL SALES PER YEAR AND MONTH

`select year(date) as Years, DATENAME(Month, date) as months,
sum([Sale Amount]) as Total_sales from Sales_Data_Cleaned
group by YEAR(date), DATENAME(Month, date);`


![Alt Text]()

* Alternatively, it can be put in a pivot table.
  
`with yet_to_pivot as (select year(date) as Years, DATENAME(Month, date) as months,
[Sale Amount] from Sales_Data_Cleaned)`

`select * from yet_to_pivot
pivot(sum([Sale Amount]) for Years in ([2018], [2019])) as my_pivot`

### TOTAL ITEM SOLD
`select sum(units) as total_items_sold from Sales_Data_Cleaned;`

![Alt Text]()

### TOTAL ITEM SOLD PER YEAR

`select year(date) as Years, sum(units) as total_item_sold from Sales_Data_Cleaned
group by year(date);`

![Alt Text]()

### TOTAL ITEM SOLD PER YEAR AND MONTH

`select Year(date) as Years, DATENAME(MONTH, DATE) AS MONTH, 
SUM(UNITS) as total_items from Sales_Data_Cleaned
group by year(date), DATENAME(month, date);`

![Alt Text]()

* Alternatively, I put it into a pivot table.
  
  `with yet_to_pivot as (select Year(date) as years, 
datename(month, date) as Months, units from sales_data_cleaned)`

`select * from yet_to_pivot
pivot(sum(units) for years in ([2018],[2019])) as my_pivot;`

![Alt Text]()

### TOTAL MANAGERS

`select count(distinct(manager)) as Managers from Sales_Data_Cleaned`

![Alt Text]()


### TOTAL MANAGERS PER YEAR

`select year(date) as years, count(distinct(manager))
as mangers from Sales_Data_Cleaned
group by year(date);`

![Alt Text]()


### TOTAL MANAGERS PER YEAR AND MONTH

`select year(date) as years, datename(month, date) as months,
count(distinct(Manager)) as managers from Sales_Data_Cleaned
group by Year(date), datename(MONTH, DATE);`


![Alt Text]()

### TOTAL SALESPERSON

`select count(distinct([sales Man])) total_sales_man from Sales_Data_Cleaned`


![Alt Text]()

### TOTAL SALESPERSON PER YEAR


`select Year(date) as years, count(distinct([sales man]))
AS Total_sales_man from Sales_Data_Cleaned
group by year(date);`

![Alt Text]()

### TOTAL SALESPERSON PER YEAR AND MONTH

`select Year(date) as years, DATENAME(MONTH, DATE) AS Months, count(distinct([sales man]))
AS Total_sales_man from Sales_Data_Cleaned
group by year(date), datename(month, date);`

![Alt Text]()


### PERFORMANCE OF MANAGERS FOR SALES IN PROPORTION FOR ALL YEARS. 

`select Manager, concat(round((sum([Sale Amount])/
(select sum([sale amount]) from Sales_Data_Cleaned)*100),2),' %')
as sales_propotion
from Sales_Data_Cleaned
group by Manager;`

### PERFORMANCE OF MANAGERS PER YEAR. 

`with partial_sum as (select year(date) as Years, Manager,
sum([sale amount]) as Amount_per_Manager
from Sales_Data_Cleaned
group by year(date), Manager),`

 `include_sum_per_year as (select years, Manager, Amount_per_Manager,
sum(Amount_per_Manager) over(partition by years 
order by years) as amount_per_year from partial_sum)`

`select Years, Manager, concat(round(((Amount_per_manager/amount_per_year)* 100),2),' %') as propotion
from include_sum_per_year;`

### QUANTITY SOLD PER ITEM IRRESPECTIVE OF THE YEAR.  

`select item, sum([sale Amount]) as
Total_Revenue from Sales_Data_Cleaned
group by item;`

![Alt Text]()

### QUANTITY OF ITEM SOLD PER YEAR

`select distinct year(date) as years, item, sum([sale Amount]) 
over(partition by year(date), item order by year(date)) as
Total_Revenue from Sales_Data_Cleaned`


![Alt Text]()

### SALES PER REGION IN PROPORTION FOR ALL YEARS. 

`select Region, concat(round((sum([Sale Amount])/
(select sum([Sale Amount]) from Sales_Data_Cleaned)*100),2),' %') as sales_propotion_region
from Sales_Data_Cleaned
group by Region;`


### PROPORTION OF SALES FOR EACH REGION PER YEAR 

`with just_totals as (select year(date) as years, region, sum([Sale Amount]) 
as total_amount from Sales_Data_Cleaned
group by year(date), Region),`

`total_years as (select years, region, total_amount, sum(total_amount)
over(partition by years order by years) as year_total from just_totals)`

`select years, region, concat(round(((total_amount/
year_total)*100),2),' %') as propotion from total_years;`


![Alt Text]()

### TOTAL SALES PER SALESPERSON IRRESPECTIVE OF YEAR. 

`select distinct([sales Man]), sum([sale Amount]) 
as total_sales from Sales_Data_Cleaned
group by [Sales Man]
order by total_sales desc;`

![Alt Text]()

### TOTAL SALES PER SALESPERSON PER YEAR.

`select distinct year(date) as years, [Sales Man], sum([sale Amount])
over(partition by year(date), [Sales Man] order by [Sales Man])
as Total_per_sale_Person
from Sales_Data_Cleaned;`
![Alt Text]()




## DASHBOARD FEATURES
* A **Year filter** hidden in a button at the top right corner of the dashboard.
* A **Logo** This can be found at the vertical pane on the top left part of the dashboard this logo is linked to google. in a work setting the link will be replaced with the company site. 
* Four **KPI's** this is found below the Dashboard title and it gives a general detail of key aspects of the dashboard.
* A **Pie Chart** for Manager's performance.
* A **Bar Chart** for quantity of differnt items sold.
* A **Pie Chart** for Sales by region.
* A **Bar Chart** for Sales Person Performance.


## THE DASHBOARD

![Alt Text](https://github.com/Mario-Gozie/Sales-Data-and-Tableau-Dashboard/blob/main/Images/Dashboard.png)



## GENERAL SUMMARY AND INSIGHT
* The shop made sales of over **1.3 million** for two years but it saw a decrease of a bit above **51%** in sales in the year 2019 compared to 2018.
* Quantity of item sold dropped by almost **20%** in 2019 
* The shop had **4 managers** in both years and 11 sales persons in total with one dropping in 2019.
* The best performing sales person's for both years is **Alexandra** with **Shelli** being the least performing sales person in sale.

## THANK YOU!


![Alt Text](https://github.com/Mario-Gozie/Sales-Data-and-Tableau-Dashboard/blob/main/Images/ThankYou%20image.jpg)
