/* 

In this project we are looking at wine sales data to find insights for a company

*/

Select *
From Wine_Sales

-- Clean Data in SQL

ALTER TABLE Wine_Sales
DROP COLUMN Subgroup

-- Net Sales Vs Month

Select SUM(Net_Amount) AS Monthly_Sales, Month
From Wine_Sales
Group by Month
Order by Monthly_Sales DESC

-- Menu Group vs Month, total bottles sold 

Select Menu_Group, SUM(Item_Qty) as Total_Bottles, Month
From Wine_Sales
Group by Menu_Group, Month
Order by Total_Bottles DESC

-- Total bottles sold vs total sales per month

Select Menu_Group,SUM(Item_Qty) as Total_Bottles, SUM(Net_Amount) as Total_Sales, Month
From Wine_Sales
Group by Menu_Group, Month
Order by Total_Sales DESC

-- Find net profit of wines using a Temp Table

DROP Table if exists #TotalNetProfit
Create Table #TotalNetProfit
(
Menu_Group nvarchar(255),
Menu_Item nvarchar(255),
Item_Qty numeric,
Gross_Amount numeric,
Discount_Amount numeric,
Net_Amount numeric,
Month nvarchar(255),
Total_Cost numeric
)

Insert into #TotalNetProfit
Select Menu_Group, Menu_Item, Item_Qty, Gross_Amount, Discount_Amount, 
Net_Amount, Month, (Gross_Amount/4) as Total_Cost
From Wine_Sales

-- Looking at which bottles yielded the highest profit 

Select *, (Net_Amount-Total_Cost) as Net_Profit
From #TotalNetProfit
order by Net_Profit DESC

-- Menu Group vs Monthly Profit

Select Menu_Group, Month, Sum(Net_Amount-Total_Cost) as Monthly_Profit
From #TotalNetProfit
Group by Menu_Group, Month
order by Monthly_Profit DESC

-- Wine Bottle vs Annual profit

Select Menu_Item, Sum(Net_Amount-Total_Cost) as Highest_Net_Bottle
From #TotalNetProfit
group by Menu_Item
order by Highest_Net_Bottle  DESC



