--Examples

--Count all rows
SELECT COUNT(*) AS [Total Products]
FROM Production.Product;

-- COUNT non-nulls in a specific column
SELECT
	COUNT(*) AS [Total Products],
	COUNT(Color) AS [Total Products w Color],
	COUNT(*)-COUNT(Color) AS [Products missing color]
FROM Production.Product;

SELECT
	COUNT(GETANSINULL(Color)) as [Test]
FROM Production.Product;

-- SUM and AVG
SELECT
	SUM(listprice) AS [Total List Price],
	AVG(listprice) AS [Avg list price]
FROM Production.Product
WHERE listprice >0;

-- MIN and MAX
SELECT
	MIN(listprice) AS [Minimum],
	MAX(listprice) AS [Maximum]
FROM Production.Product
WHERE listprice>0;

-- Aggregates with WHERE
SELECT
	COUNT(*) AS [Black product count]
FROM Production.Product
WHERE Color IS NULL;

-- Multiple aggregates in one query — common pattern
SELECT
	COUNT(*) AS 'Count',
	SUM(totaldue) AS 'Total',
	AVG(totaldue) AS 'Avg',
	MIN(orderdate) AS 'FirstOrder Date',
	MAX(orderdate) AS 'Latest Order'
FROM Sales.SalesOrderHeader;

--Practice

--1. How many distinct colors are there in `Production.Product`? (Hint: combine `COUNT` with `DISTINCT`.)
SELECT DISTINCT
	COUNT(COLOR) AS [Distinct Color]
FROM Production.Product;

SELECT 
	COUNT(COLOR) AS [Distinct Color]
FROM Production.Product;

SELECT
	COUNT(DISTINCT COLOR) AS [Distinct Color]
FROM Production.Product;

SELECT 
	COUNT(DISTINCT ISNULL(COLOR,'NULL')) AS [Distinct Color]
FROM Production.Product;

SELECT DISTINCT 
	Color
FROM Production.Product;

	
--2. What's the average `ListPrice` of products that have a color (i.e., exclude nulls)?
SELECT
	AVG(listprice) AS [Avg listprice]
FROM Production.Product
WHERE color IS NOT NULL;

--3. From `Sales.SalesOrderHeader`, what's the total revenue (`SUM(TotalDue)`) and average order value (`AVG(TotalDue)`) for orders in 2013? 
--(You'll need a WHERE on `OrderDate`.)

SELECT
	SUM(totaldue) AS [Revenue],
	AVG(totaldue) AS [Avg]
FROM sales.SalesOrderHeader
WHERE orderdate >='2013-01-01' 
AND orderdate <'2014-01-01';

--4. How many rows in `Production.Product` have a `ListPrice` of exactly $0? What does that tell you about the data?

SELECT COUNT(*)
FROM production.Product;

SELECT COUNT(*)
FROM production.Product
WHERE listprice = 0;

SELECT COUNT(Color)
FROM production.Product
WHERE listprice = 0;


--5. From `Sales.SalesOrderHeader`, find the date of the earliest order and the date of the latest order. How many days does that span?

SELECT
	MIN(orderdate) AS [MIN],
	MAX(orderdate) AS [MAX],
	CAST(MAX(orderdate)-MIN(orderdate) AS int),
	DATEDIFF(day,MIN(orderdate),MAX(orderdate))
FROM sales.SalesOrderHeader;


