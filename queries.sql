-- superstore sales analysis queries

-- first checking the overall numbers to get a feel of the data
select round(sum(Sales),2) as total_revenue,
       round(sum(Profit),2) as total_profit,
       round(sum(Profit)/sum(Sales)*100,2) as margin
from superstore;

-- which region is making the most money
select Region,
       round(sum(Sales),2) as revenue,
       round(sum(Profit),2) as profit,
       round(sum(Profit)/sum(Sales)*100,2) as margin
from superstore
group by Region
order by revenue desc;

-- tech vs furniture vs office supplies
select Category,
       round(sum(Sales),2) as revenue,
       round(sum(Profit),2) as profit,
       round(sum(Profit)/sum(Sales)*100,2) as margin
from superstore
group by Category
order by revenue desc;

-- wanted to see which products are selling the most
select [Sub-Category],
       round(sum(Sales),2) as revenue
from superstore
group by [Sub-Category]
order by revenue desc
limit 10;

-- checking if any subcategory is actually losing money
select [Sub-Category],
       round(sum(Profit),2) as profit
from superstore
group by [Sub-Category]
having profit < 0
order by profit asc;

-- does giving more discount actually hurt profit
-- turns out yes it does above 40%
select case
           when Discount < 0.2 then '0 to 20 percent'
           when Discount < 0.4 then '20 to 40 percent'
           when Discount < 0.6 then '40 to 60 percent'
           else 'above 60 percent'
       end as discount_bracket,
       count(*) as orders,
       round(avg(Profit),2) as avg_profit
from superstore
group by discount_bracket
order by discount_bracket;

-- top 10 states by revenue
select State,
       round(sum(Sales),2) as revenue,
       round(sum(Profit),2) as profit
from superstore
group by State
order by revenue desc
limit 10;

-- states that are not doing well profit wise
select State,
       round(sum(Sales),2) as revenue,
       round(sum(Profit),2) as profit
from superstore
group by State
order by profit asc
limit 10;

-- consumer vs corporate vs home office
select Segment,
       round(sum(Sales),2) as revenue,
       round(sum(Profit),2) as profit,
       count(*) as orders
from superstore
group by Segment
order by revenue desc;

-- how orders are being shipped
select [Ship Mode],
       count(*) as orders,
       round(sum(Sales),2) as revenue,
       round(avg(Sales),2) as avg_order
from superstore
group by [Ship Mode]
order by orders desc;
