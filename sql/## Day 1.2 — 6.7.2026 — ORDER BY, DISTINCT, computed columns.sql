-- ORDER BY descending — most expensive first

SELECT TOP 10
	name,
	listprice
FROM Production.Product
ORDER BY listprice DESC;

-- ORDER BY multiple columns — first by color, then by price within color
SELECT
	name,
	color,
	listprice
FROM Production.Product
ORDER BY color ASC, ListPrice DESC;

-- DISTINCT — list of unique colors
SELECT DISTINCT
	color
FROM Production.Product;

-- Computed column with arithmetic
SELECT
	name,
	listprice,
	listprice*.13 AS [tax],
	listprice*1.13 AS [listprice+tax]
FROM production.product
WHERE listprice > 0
ORDER BY [listprice+tax];

-- Computed column with string concatenation
SELECT
	firstname+' '+lastname AS [full name]
FROM person.Person;

-- Computed column with date arithmetic
SELECT
	salesorderid,
	orderdate,
	duedate,
	DATEDIFF(day,orderdate,duedate) AS [Days to ship]
FROM sales.salesorderheader
ORDER BY [Days to ship];

--PRACTICE
--1. Show the 10 most expensive products. Columns: `Name`, `ListPrice`. Sorted highest first.
SELECT TOP 10
	name,
	listprice
FROM production.product
ORDER BY listprice DESC;


--2. Show all distinct combinations of `Color` and `Size` from `Production.Product`. Sorted by Color, then Size.
SELECT DISTINCT
	color,
	size
FROM production.product
ORDER BY color, size;

--3. Show every product where ListPrice > 0, with a computed column called `Margin` calculated as `ListPrice - StandardCost`. 
--Sort by Margin descending. (You may need to check the column names by running `SELECT TOP 5 * FROM Production.Product;` first.)

SELECT
	name,
	productnumber,
	listprice,
	standardcost,
	(listprice-standardcost) AS [Margin]
FROM production.Product
WHERE listprice > 0
AND standardcost > 0
ORDER BY Margin DESC;

--4. From `Person.Person`, show the top 20 people with the longest full names (FirstName + LastName combined). Hint: use `LEN()`.
SELECT TOP 20
	firstname+' '+lastname AS [Fullname],
	LEN(firstname+lastname) AS [Length]
FROM person.person
ORDER BY Length DESC;

--5. From `Sales.SalesOrderHeader`, find orders where the gap between `OrderDate` and `ShipDate` was more than 10 days.
-- Show `SalesOrderID`, both dates, and the gap.

SELECT 
	salesorderid,
	orderdate,
	shipdate,
	DATEDIFF(day,orderdate,shipdate) AS [gap]
FROM sales.salesorderheader
WHERE DATEDIFF(day,orderdate,shipdate) > 10
ORDER BY gap DESC;

