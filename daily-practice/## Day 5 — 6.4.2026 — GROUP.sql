--## Day 5 — Thursday — GROUP BY: the big idea

--**Theory:** `GROUP BY` partitions rows into groups based on one or more columns, then evaluates aggregate functions per group. Every column in the SELECT list must either appear in the GROUP BY or be inside an aggregate function. 
--The result has one row per unique combination of grouping values.

--**In plain English:** GROUP BY in SQL is what a **PivotTable** is in Excel — you drag a column to the "Rows" area and another to the "Values" area with a SUM function. 
--SQL does the same in one line: "For each category, sum the prices." Once GROUP BY clicks, half of analytical SQL is unlocked.

--**Practice (90 min):**

--```sql
---- Count products per color
--SELECT Color, COUNT(*) AS ProductCount
--FROM Production.Product
--GROUP BY Color
--ORDER BY ProductCount DESC;

--SELECT
--	Color,
--	Count(*) AS [Product Count]
--FROM production.product
--GROUP BY Color
--ORDER BY [Product Count] DESC;


---- Average price per color (skip free items)
--SELECT Color, AVG(ListPrice) AS AvgPrice, COUNT(*) AS N
--FROM Production.Product
--WHERE ListPrice > 0
--GROUP BY Color
--ORDER BY AvgPrice DESC;

--SELECT
--	Color,
--	Avg(listprice) AS [Avg listprice]
--FROM Production.Product
--WHERE listprice > 0
--GROUP BY Color
--ORDER BY [Avg listprice] DESC;

---- Group by date components — orders per year
--SELECT YEAR(OrderDate) AS Yr, COUNT(*) AS OrderCount, SUM(TotalDue) AS Revenue
--FROM Sales.SalesOrderHeader
--GROUP BY YEAR(OrderDate)
--ORDER BY Yr;

--SELECT 
--	YEAR(orderdate) AS [Year],
--	COUNT(*) AS [# of Orders],
--	SUM(totaldue) AS [Total Revenue],
--	AVG(totaldue) AS [Avg Revenue],
--	MIN(totaldue) AS [Min Rev],
--	MAX(totaldue) AS [Max Rev]
--FROM sales.salesorderheader
--GROUP BY YEAR(orderdate)
--ORDER BY [Year];

---- Group by multiple columns — orders per year per status
--SELECT YEAR(OrderDate) AS Yr, Status, COUNT(*) AS OrderCount
--FROM Sales.SalesOrderHeader
--GROUP BY YEAR(OrderDate), Status
--ORDER BY Yr, Status;
--```

--**Common beginner error:** Forgetting that every non-aggregated column in SELECT must be in GROUP BY. This fails:
--```sql
---- ERROR: Name is not in GROUP BY and not aggregated
--SELECT Name, Color, AVG(ListPrice)
--FROM Production.Product
--GROUP BY Color;
--SELECT Name, Color, AVG(ListPrice)
--FROM Production.Product
--GROUP BY Color, name;


--```

--To include `Name`, you'd either group by it too (one row per name) or use an aggregate like `MIN(Name)` (which is rarely meaningful). Usually the question itself is what's wrong — you don't actually want product names AND a per-color average in the same row.

--**Self-test (45 min):**

--1. Count of products per `ProductSubcategoryID`. Exclude nulls in the subcategory.

--SELECT 
--	productsubcategoryid,
--	COUNT(productsubcategoryid) as [Count]

--FROM production.Product
--WHERE ProductSubcategoryID IS NOT NULL
--GROUP BY ProductSubcategoryID


--2. For each `Color`, show count of products, average ListPrice, and average StandardCost. Skip products with `ListPrice = 0`.

--SELECT
--	Color,
--	COUNT(*) AS [Count],
--	AVG(listprice) AS [Avg Listprice],
--	AVG(standardcost) AS [Avg Standard Cost]

--FROM production.Product
--WHERE listprice <> 0
--GROUP BY Color


--3. Orders grouped by year and month (use `YEAR(OrderDate)` and `MONTH(OrderDate)` — both must appear in GROUP BY). Show order count per month, sorted chronologically.

--SELECT
--	DATENAME(MONTH,Orderdate) AS [Month],
--	YEAR(OrderDate) AS [Year],
--	COUNT(*) AS [Total Orders]

--FROM Sales.SalesOrderHeader
--GROUP BY MONTH(OrderDate),DATENAME(MONTH,Orderdate) ,YEAR(OrderDate)
--ORDER BY [Year],MONTH(OrderDate) ASC;

--4. For each `CustomerID` in `SalesOrderHeader`, count their orders. Sort highest first. Show top 10 only.

--SELECT TOP 10
--	CustomerID,
--	COUNT(*) AS [Total Orders]
--FROM Sales.SalesOrderHeader
--GROUP BY CustomerID
--ORDER BY [Total Orders] DESC


--5. For each `Color`, show the min and max ListPrice. Skip nulls.

--SELECT
--	Color,
--	MIN(listprice) AS [Min],
--	MAX(listprice) AS [Max]

--FROM production.Product
--WHERE Listprice > 0 AND Color IS NOT NULL
--GROUP BY Color;