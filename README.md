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

![Alt Text](https://github.com/Mario-Gozie/Sales-Data-and-Tableau-Dashboard/blob/main/Images/Screenshot%20(100).png)

## DATA CLEANING

* I queried the database and noticed there are null values and had to delete them to ease Analysis.
  
`select * from Sales_Data_Cleaned
where Date is null;`

![Alt Text](https://github.com/Mario-Gozie/Sales-Data-and-Tableau-Dashboard/blob/main/Images/viewing%20for%20null%20columns%20Data%20cleaning.png)

`delete from Sales_Data_Cleaned
where Date is null;`

![Alt Text](https://github.com/Mario-Gozie/Sales-Data-and-Tableau-Dashboard/blob/main/Images/Deleting%20the%20null%20rows.png)

### TOTAL SALES IRRESPECTIVE OF THE YEAR

`select sum([sale Amount]) as Total_sales from Sales_Data_Cleaned`

![Alt Text](https://github.com/Mario-Gozie/Sales-Data-and-Tableau-Dashboard/blob/main/Images/Total_Amount%20of%20all%20years.png)

### TOTAL SALAES PER YEAR

`select year(Date) as Years,sum([Sale Amount]) as 
Year_Total_sales from Sales_Data_Cleaned
group by year(Date);`

![Alt Text](https://github.com/Mario-Gozie/Sales-Data-and-Tableau-Dashboard/blob/main/Images/Total%20sales%20per%20year.png)

### TOTAL SALES PER YEAR AND MONTH

`select year(date) as Years, DATENAME(Month, date) as months,
sum([Sale Amount]) as Total_sales from Sales_Data_Cleaned
group by YEAR(date), DATENAME(Month, date);`


![Alt Text](https://github.com/Mario-Gozie/Sales-Data-and-Tableau-Dashboard/blob/main/Images/Total%20sales%20year%20and%20month.png)

* Alternatively, it can be put in a pivot table.
  
`with yet_to_pivot as (select year(date) as Years, DATENAME(Month, date) as months,
[Sale Amount] from Sales_Data_Cleaned)`

`select * from yet_to_pivot
pivot(sum([Sale Amount]) for Years in ([2018], [2019])) as my_pivot`

![Alt Text](https://github.com/Mario-Gozie/Sales-Data-and-Tableau-Dashboard/blob/main/Images/Total%20sales%20year%20month%20in%20pivot%20table.png)

### TOTAL ITEM SOLD
`select sum(units) as total_items_sold from Sales_Data_Cleaned;`

![Alt Text](https://github.com/Mario-Gozie/Sales-Data-and-Tableau-Dashboard/blob/main/Images/quantity%20of%20item%20sold%20irrespective%20of%20year.png)

### TOTAL ITEM SOLD PER YEAR

`select year(date) as Years, sum(units) as total_item_sold from Sales_Data_Cleaned
group by year(date);`

![Alt Text](https://github.com/Mario-Gozie/Sales-Data-and-Tableau-Dashboard/blob/main/Images/Total%20items%20sold%20irrespective%20of%20year%20years.png)

### TOTAL ITEM SOLD PER YEAR AND MONTH

`select Year(date) as Years, DATENAME(MONTH, DATE) AS MONTH, 
SUM(UNITS) as total_items from Sales_Data_Cleaned
group by year(date), DATENAME(month, date);`

![Alt Text](https://github.com/Mario-Gozie/Sales-Data-and-Tableau-Dashboard/blob/main/Images/item%20sold%20per%20year%20and%20month.png)

* Alternatively, I put it into a pivot table.
  
  `with yet_to_pivot as (select Year(date) as years, 
datename(month, date) as Months, units from sales_data_cleaned)`

`select * from yet_to_pivot
pivot(sum(units) for years in ([2018],[2019])) as my_pivot;`

![Alt Text](https://github.com/Mario-Gozie/Sales-Data-and-Tableau-Dashboard/blob/main/Images/item%20sold%20per%20year%20and%20month%20in%20pivot.png)

### TOTAL MANAGERS

`select count(distinct(manager)) as Managers from Sales_Data_Cleaned`

![Alt Text](https://github.com/Mario-Gozie/Sales-Data-and-Tableau-Dashboard/blob/main/Images/Total%20Numbe%20of%20mangers%20irrespective%20of%20year.png)


### TOTAL MANAGERS PER YEAR

`select year(date) as years, count(distinct(manager))
as mangers from Sales_Data_Cleaned
group by year(date);`

![Alt Text](https://github.com/Mario-Gozie/Sales-Data-and-Tableau-Dashboard/blob/main/Images/Total%20managers%20per%20year.png)


### TOTAL MANAGERS PER YEAR AND MONTH

`select year(date) as years, datename(month, date) as months,
count(distinct(Manager)) as managers from Sales_Data_Cleaned
group by Year(date), datename(MONTH, DATE);`


![Alt Text]()

### TOTAL SALESPERSON

`select count(distinct([sales Man])) total_sales_man from Sales_Data_Cleaned`


![Alt Text](https://github.com/Mario-Gozie/Sales-Data-and-Tableau-Dashboard/blob/main/Images/sales%20man%20irrespective%20of%20year.png)

### TOTAL SALESPERSON PER YEAR


`select Year(date) as years, count(distinct([sales man]))
AS Total_sales_man from Sales_Data_Cleaned
group by year(date);`

![Alt Text](https://github.com/Mario-Gozie/Sales-Data-and-Tableau-Dashboard/blob/main/Images/Sales%20man%20per%20year.png)

### TOTAL SALESPERSON PER YEAR AND MONTH

`select Year(date) as years, DATENAME(MONTH, DATE) AS Months, count(distinct([sales man]))
AS Total_sales_man from Sales_Data_Cleaned
group by year(date), datename(month, date);`

![Alt Text](https://github.com/Mario-Gozie/Sales-Data-and-Tableau-Dashboard/blob/main/Images/Sales%20man%20per%20year%20and%20month.png)


### PERFORMANCE OF MANAGERS FOR SALES IN PROPORTION FOR ALL YEARS. 

`select Manager, concat(round((sum([Sale Amount])/
(select sum([sale amount]) from Sales_Data_Cleaned)*100),2),' %')
as sales_propotion
from Sales_Data_Cleaned
group by Manager;`

![Alt Text](https://github.com/Mario-Gozie/Sales-Data-and-Tableau-Dashboard/blob/main/Images/Propotion%20contribution%20of%20managers%20irrespective%20of%20year.png)

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

![Alt Text](https://github.com/Mario-Gozie/Sales-Data-and-Tableau-Dashboard/blob/main/Images/Propotion%20of%20managers%20contribution%20per%20year.png)

### QUANTITY SOLD PER ITEM IRRESPECTIVE OF THE YEAR.  

`select item, sum([sale Amount]) as
Total_Revenue from Sales_Data_Cleaned
group by item;`

![Alt Text](https://github.com/Mario-Gozie/Sales-Data-and-Tableau-Dashboard/blob/main/Images/quantity%20of%20item%20sold%20irrespective%20of%20year.png)

### SALES PER ITEM SOLD PER YEAR

`select distinct year(date) as years, item, sum([sale Amount]) 
over(partition by year(date), item order by year(date)) as
Total_Revenue from Sales_Data_Cleaned`


![Alt Text](https://github.com/Mario-Gozie/Sales-Data-and-Tableau-Dashboard/blob/main/Images/Quantity%20of%20item%20sold%20per%20year.png)

### SALES PER REGION IN PROPORTION FOR ALL YEARS. 

`select Region, concat(round((sum([Sale Amount])/
(select sum([Sale Amount]) from Sales_Data_Cleaned)*100),2),' %') as sales_propotion_region
from Sales_Data_Cleaned
group by Region;`

![Alt Text](https://github.com/Mario-Gozie/Sales-Data-and-Tableau-Dashboard/blob/main/Images/Propotion%20of%20item%20per%20region%20irrespective%20of%20year.png)

### PROPORTION OF SALES FOR EACH REGION PER YEAR 

`with just_totals as (select year(date) as years, region, sum([Sale Amount]) 
as total_amount from Sales_Data_Cleaned
group by year(date), Region),`

`total_years as (select years, region, total_amount, sum(total_amount)
over(partition by years order by years) as year_total from just_totals)`

`select years, region, concat(round(((total_amount/
year_total)*100),2),' %') as propotion from total_years;`


![Alt Text](https://github.com/Mario-Gozie/Sales-Data-and-Tableau-Dashboard/blob/main/Images/Propotion%20of%20item%20sold%20per%20region%20per%20year.png)

### TOTAL SALES PER SALESPERSON IRRESPECTIVE OF YEAR. 

`select distinct([sales Man]), sum([sale Amount]) 
as total_sales from Sales_Data_Cleaned
group by [Sales Man]
order by total_sales desc;`

![Alt Text](https://github.com/Mario-Gozie/Sales-Data-and-Tableau-Dashboard/blob/main/Images/total%20sales%20per%20salesman%20irrespective%20of%20year.png)

### TOTAL SALES PER SALESPERSON PER YEAR.

`select distinct year(date) as years, [Sales Man], sum([sale Amount])
over(partition by year(date), [Sales Man] order by [Sales Man])
as Total_per_sale_Person
from Sales_Data_Cleaned;`

![Alt Text](https://github.com/Mario-Gozie/Sales-Data-and-Tableau-Dashboard/blob/main/Images/sales%20per%20sales%20man%20per%20year.png)




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
