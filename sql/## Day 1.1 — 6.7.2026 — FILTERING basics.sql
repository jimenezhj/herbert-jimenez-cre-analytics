USE AdventureWorks2022;
GO

--1. Basic comparison
--SELECT
--	name,
--	listprice
--FROM Production.Product
--WHERE listprice > 1000;

--2. BETWEEN (inclusive both ends)
--SELECT
--	name,
--	listprice
--FROM Production.Product
--WHERE listprice between 100 AND 500;

--3. IN — match any value in a list
--SELECT
--	name,
--	listprice,
--	color
--FROM Production.Product 
--WHERE color IN ('red','blue','black');

--4. LIKE — pattern match (% = any string, _ = any single character)
--SELECT
--	name
--FROM Production.Product
--WHERE name LIKE '%mou%'

--5. NULL test
--SELECT
--	name,
--	color
--FROM Production.Product
--WHERE Color is null

--6. Combining with AND
--SELECT
--	name,
--	listprice,
--	color
--FROM production.Product
--WHERE listprice > 1000 
--AND color ='black';

--7. Combining with OR — watch the parentheses
--SELECT
--	name,
--	listprice,
--	color
--FROM Production.Product
--WHERE (Color = 'red' OR color='blue') AND listprice > 500;

--SELECT
--	name,
--	listprice,
--	color
--FROM Production.Product
--WHERE Color = 'red' OR (color='blue' AND listprice > 500);

--Practice:
--1. Products whose name starts with "Road"
--SELECT
--	name,
--	listprice
--FROM Production.Product
--WHERE name LIKE 'road%';

--2. Products with `ListPrice = 0` (internal/free items — these exist in AdventureWorks)
--SELECT
--	name,
--	listprice

--FROM production.Product

--3. Products where Color is NOT 'Red', 'Blue', OR 'Black' (and include nulls in the result)
--SELECT
--	name,
--	listprice,
--	color
--FROM Production.Product
--WHERE color NOT IN ('red','blue', 'black') OR color IS NULL

--4. Products with ListPrice between $500 and $1500 AND Color = 'Silver'
--SELECT
--	name,
--	listprice
--FROM Production.Product
--WHERE listprice >= 500 
--AND ListPrice <= 1000 
--AND color = 'silver'


--5. Products where ProductNumber contains the letter "Z"