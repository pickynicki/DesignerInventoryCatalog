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


--
--Write a  SELECT query that utilizes a LEFT JOIN
--
--Write a  SELECT query that utilizes a variable in the WHERE clause
--
--Write a  SELECT query that utilizes a ORDER BY clause
--
--Write a  SELECT query that utilizes a GROUP BY clause along with an aggregate function
--
--Write a SELECT query that utilizes a CALCULATED FIELD
--
--Write a SELECT query that utilizes a SUBQUERY
--
--Write a SELECT query that utilizes a JOIN, at least 2 OPERATORS (AND, OR, =, IN, BETWEEN, ETC) AND A GROUP BY clause with an aggregate function
--
--Write a SELECT query that utilizes a JOIN with 3 or more tables, at 2 OPERATORS (AND, OR, =, IN, BETWEEN, ETC), a GROUP BY clause with an aggregate function, and a HAVING clause
--
--Design a NONCLUSTERED INDEX with ONE KEY COLUMN that improves the performance of one of the above queries
--
--Design a NONCLUSTERED INDEX with TWO KEY COLUMNS that improves the performance of one of the above queries
--
--Design a NONCLUSTERED INDEX with AT LEAST ONE KEY COLUMN and AT LEAST ONE INCLUDED COLUMN that improves the performance of one of the above queries
