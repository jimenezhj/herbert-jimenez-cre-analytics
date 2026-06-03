--## Day 3 — Tuesday — ORDER BY, DISTINCT, computed columns

--**Theory:** `ORDER BY` sorts the result; `ASC` is ascending (default), `DESC` is descending. `DISTINCT` removes duplicate rows from the result set. 
--You can compute new columns in the SELECT list using arithmetic, concatenation, or function calls — and give them aliases using `AS`.

--**In plain English:**
--- **ORDER BY** = clicking the Sort button in Excel
--- **DISTINCT** = clicking Remove Duplicates
--- **Computed columns** = writing a formula in a new column (e.g., `=A2*1.13`)

--You can use any expression in the SELECT list, not just plain column names. This is where you start adding analytical value.

--**Practice (90 min):**

--```sql
---- ORDER BY descending — most expensive first
--SELECT TOP 10 Name, ListPrice
--FROM Production.Product
--ORDER BY ListPrice DESC;

--SELECT TOP 10
--	p.Name as [Name],
--	p.ListPrice as [List Price]
--FROM Production.Product p
--ORDER BY p.ListPrice DESC;

---- ORDER BY multiple columns — first by color, then by price within color
--SELECT Name, Color, ListPrice
--FROM Production.Product
--WHERE Color IS NOT NULL AND ListPrice > 0
--ORDER BY Color ASC, ListPrice DESC;
--SELECT
--	p.Name as [Product Name],
--	p.color as [Product Color],
--	p.listprice as [Product List Price]
--FROM Production.Product p
--WHERE p.color IS NOT NULL AND p.listprice > 0
--ORDER BY p.color ASC, p.listprice DESC;

---- DISTINCT — unique colors in the catalog
--SELECT DISTINCT Color
--FROM Production.Product;

--SELECT DISTINCT Color
--FROM Production.Product

---- Computed columns — derive new values
--SELECT
--    Name,
--    ListPrice,
--    ListPrice * 1.13 AS PriceWithTax,
--    ListPrice - StandardCost AS Margin
--FROM Production.Product
--WHERE StandardCost > 0;

--SELECT
--	p.name AS [Product Name],
--	p.listprice AS [Product List Price],
--	p.listprice*1.13 AS [Gross (ONT HST)],
--	p.listprice - p.standardcost AS [Gross Margin],
--	CAST((p.listprice - p.standardcost)/p.listprice AS decimal(38,2)) AS [GM %]

--FROM Production.Product p
--WHERE p.standardcost > 0 AND p.ListPrice > 0;

---- Aliases work in ORDER BY too
--SELECT Name, ListPrice - StandardCost AS Margin
--FROM Production.Product
--WHERE StandardCost > 0
--ORDER BY Margin DESC;

--SELECT
--	p.name AS [Product Name],
--	p.listprice-p.standardcost AS [Margin]
--FROM Production.Product p
--WHERE p.standardcost > 0
--ORDER BY Margin DESC;

--```

--**One subtle rule:** Column aliases defined in `SELECT` can be used in `ORDER BY` but NOT in `WHERE`. 
-- SQL evaluates WHERE before SELECT, so the alias doesn't exist yet at WHERE time. If you need to filter on a computed value, repeat the expression in WHERE or use a CTE (Day 17).

--**Self-test (45 min):**

--1. Show the 10 most expensive products (Name + ListPrice), highest first.

--SELECT TOP 10
--	p.name AS [Product Name],
--	p.listprice AS [Product List Price]
--FROM production.product p
--ORDER BY [Product List Price] DESC;

--2. Show the 10 cheapest products that have `ListPrice > 0` (skip the free ones).

--SELECT TOP 10
--	p.name AS [Product Name],
--	p.listprice AS [Product List Price]
--FROM Production.Product p
--WHERE p.listprice > 0
--ORDER BY [Product List Price] ASC;

--3. Distinct list of all `Size` values in `Production.Product`, sorted alphabetically (exclude nulls).
--SELECT DISTINCT
--	p.Size AS [Product Size]
--FROM production.product p
--WHERE p.Size IS NOT NULL
--ORDER BY p.Size ASC;


--4. For each product where `StandardCost > 0`, show Name, ListPrice, StandardCost, and a computed column `MarkupPct = (ListPrice - StandardCost) / StandardCost * 100`. Sort highest markup first.

--SELECT
--	p.name AS [Product Name],
--	p.ListPrice AS [List Price],
--	p.StandardCost AS [Standard Cost],
--	(p.listprice-p.standardcost)/p.standardcost * 100 AS [Mark up pcrt]

--FROM production.product p
--WHERE p.standardcost > 0
--ORDER BY [Mark up Price] DESC;

--5. Show top 10 products by markup percent where MarkupPct exceeds 100% (think: how do you filter on a computed column?).

--SELECT
--	p.name AS [Product Name],
--	p.ListPrice AS [Product List Price],
--	p.StandardCost AS [Product Standard Cost],
--	(p.ListPrice-p.StandardCost)/p.StandardCost * 100 AS [Mark up pcrt]
	
--FROM Production.Product p
--WHERE p.standardcost > 0
--AND (p.ListPrice-p.StandardCost)/p.StandardCost * 100 > 100
--ORDER BY [Mark up pcrt] DESC;

