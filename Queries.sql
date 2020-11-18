--3rd File (See ReadMe)
--Write a SELECT query that uses a WHERE clause

SELECT * 
FROM People
WHERE FirstName = 'Mandy';

--Write a  SELECT query that uses an OR and an AND operator


SELECT *
FROM People
INNER JOIN TeamMembers
ON TeamMembers.PersonId = People.Id
INNER JOIN Inventories
ON Inventories.PersonId = People.Id
WHERE (TeamId = 3 OR TeamId = 4)
AND ProductId = 8

--Write a  SELECT query that filters NULL rows using IS NOT NULL

SELECT *
FROM Inventories
WHERE Quantity IS NOT NULL;

--Write a DML statement that UPDATEs a set of rows with a WHERE clause. The values used in the WHERE clause should be a variable

DECLARE @price as int;
SET @price = 999;

UPDATE Products
SET Wholesale = 1199
WHERE Wholesale = @price;

--Write a DML statement that DELETEs a set of rows with a WHERE clause. The values used in the WHERE clause should be a variable

DECLARE @personid as int;
SET @personid = 11;

DELETE FROM People
WHERE Id = @personid;

--Write a DML statement that DELETEs rows from a table that another table references. This script will have to also DELETE any records that reference these rows. Both of the DELETE statements need to be wrapped in a single TRANSACTION.

BEGIN TRANSACTION;

DELETE FROM Inventories
WHERE ProductId = 1;

DELETE FROM Products
WHERE Id = 1;

COMMIT;

--Write a  SELECT query that utilizes a JOIN

SELECT People.*, Teams.Name as TeamName FROM Teams
INNER JOIN People
ON Teams.TeamLeaderPersonId = People.Id

--Write a  SELECT query that utilizes a JOIN with 3 or more tables

SELECT FirstName, LastName, Products.Name, Quantity
FROM People
INNER JOIN Inventories
ON Inventories.PersonId = People.Id
INNER JOIN Products
ON Products.Id = Inventories.ProductId

--Write a  SELECT query that utilizes a LEFT JOIN

SELECT FirstName, LastName, TeamMembers.Id AS TeamMemberId
FROM People
LEFT JOIN TeamMembers
ON People.Id = TeamMembers.PersonId
WHERE TeamMembers.Id IS NULL

--Write a  SELECT query that utilizes a variable in the WHERE clause

DECLARE @productname as varchar(50);
SET @productname = 'pirate';

SELECT *
FROM Products
WHERE LOWER([Name]) LIKE '%'+ LOWER(@productname) + '%'

--Write a  SELECT query that utilizes aN ORDER BY clause

SELECT [Name], Size, Wholesale, MSRP
FROM Products
ORDER BY MSRP desc, Name asc; 

--Write a  SELECT query that utilizes a GROUP BY clause along with an aggregate function

SELECT Size, Wholesale, MSRP, COUNT([Size]) AS ProductCount
FROM Products
GROUP BY Size, Wholesale, MSRP
ORDER BY MSRP desc; 

--Write a SELECT query that utilizes a CALCULATED FIELD

SELECT FirstName, LastName, Products.Name, Quantity, '$' + FORMAT(MSRP/100.0, 'N') AS MSRP, '$' +  FORMAT((Quantity * MSRP)/100.0, 'N') AS ProductInventoryTotal
FROM People
INNER JOIN Inventories
ON Inventories.PersonId = People.Id
INNER JOIN Products
ON Products.Id = Inventories.ProductId

--Write a SELECT query that utilizes a SUBQUERY

SELECT *
FROM Products
WHERE Id NOT IN (SELECT ProductId FROM Inventories)

--Write a SELECT query that utilizes a JOIN, at least 2 OPERATORS (AND, OR, =, IN, BETWEEN, ETC) AND A GROUP BY clause with an aggregate function

SELECT Teams.[Name] AS TeamName, TeamLeader.FirstName + ' ' + TeamLeader.LastName as TeamLeaderName, COUNT (*) AS TeamSize
FROM People AS TeamLeader
INNER JOIN Teams
ON Teams.TeamLeaderPersonId = TeamLeader.Id
INNER JOIN TeamMembers
ON Teams.Id = TeamMembers.TeamId
WHERE TeamLeader.SignUpDate BETWEEN '2016-01-01' AND '2019-05-12'
GROUP BY Teams.[Name], TeamLeader.FirstName + ' ' + TeamLeader.LastName 
HAVING COUNT (*) > 2

--Write a SELECT query that utilizes a JOIN with 3 or more tables, at 2 OPERATORS (AND, OR, =, IN, BETWEEN, ETC), a GROUP BY clause with an aggregate function, and a HAVING clause

WITH TeamQuantities AS (SELECT Teams.Id AS TeamId, Teams.[Name] AS TeamName, Products.Id AS ProductId, Products.[Name] AS ProductName, SUM(Quantity) AS Quantity
FROM People AS TeamMember
INNER JOIN TeamMembers
ON TeamMember.Id = TeamMembers.PersonId
INNER JOIN Teams
ON Teams.Id = TeamMembers.TeamId
LEFT JOIN Inventories
ON TeamMember.Id = Inventories.PersonId
LEFT JOIN Products
ON Products.Id = Inventories.ProductId
GROUP BY Teams.Id, Teams.[Name], Products.Id, Products.[Name]
HAVING SUM(Quantity) BETWEEN 3 AND 5)

SELECT TeamQuantities.ProductName, TeamQuantities.TeamName, TeamQuantities.Quantity AS TeamQuantity, TeamMember.FirstName, TeamMember.LastName, Inventories.Quantity
FROM TeamQuantities
INNER JOIN TeamMembers 
ON TeamMembers.TeamId = TeamQuantities.TeamId
INNER JOIN People AS TeamMember
ON TeamMember.Id = TeamMembers.PersonId
LEFT JOIN Inventories
ON Inventories.PersonId = TeamMember.Id AND Inventories.ProductId = TeamQuantities.ProductId
WHERE Inventories.Quantity IS NOT NULL
ORDER BY ProductName, TeamName, TeamQuantity desc, Quantity desc

--Design a NONCLUSTERED INDEX with ONE KEY COLUMN that improves the performance of one of the above queries
--
--Design a NONCLUSTERED INDEX with TWO KEY COLUMNS that improves the performance of one of the above queries
--
--Design a NONCLUSTERED INDEX with AT LEAST ONE KEY COLUMN and AT LEAST ONE INCLUDED COLUMN that improves the performance of one of the above queries
