--2nd File
--Delete Table Data

DELETE FROM [dbo].[TeamMembers];
DELETE FROM [dbo].[Inventories];
DELETE FROM [dbo].[Teams];
DELETE FROM [dbo].[Products];
DELETE FROM [dbo].[People];

--Insert Data into People Table

SET IDENTITY_INSERT dbo.People ON;

INSERT INTO People (Id, FirstName, LastName, SignUpDate)
VALUES (1, 'Jessica', 'Rabbit', '2017-06-21'),
	   (2, 'Mandy', 'Patinkin', '2016-04-07'),
	   (3, 'Brenda', 'Bee', '2015-03-11'),
	   (4, 'David', 'Tennant', '2017-10-31'),
	   (5, 'Christopher', 'Walken', '2018-09-18'),
	   (6, 'Coral', 'Reef', '2017-06-21'),
	   (7, 'Buffy', 'Summers', '2015-08-13'),
	   (8, 'Princess', 'Leia', '2016-11-20'),
	   (9, 'Hermione', 'Granger', '2020-07-22'),
	   (10, 'Dorothy', 'Gale', '2014-02-28'),
	   (11, 'Cry', 'Baby', '2019-01-20'),
	   (12, 'Dummy', 'Person', '2020-09-20'),
	   (13, 'Johnny', 'Five', '2017-08-03');

SET IDENTITY_INSERT dbo.People OFF;

--Insert Data into Teams Table

SET IDENTITY_INSERT dbo.Teams ON;

INSERT INTO Teams (Id, Name, TeamLeaderPersonId)
VALUES (1, 'Princess', 8),
	   (2, 'Pirate', 2),
	   (3, 'Doctor', 4),
	   (4, 'Muggle', 9),
	   (5, 'CowBell', 5);

SET IDENTITY_INSERT dbo.Teams OFF;

--Insert Data into TeamMembers Table

SET IDENTITY_INSERT dbo.TeamMembers ON;

INSERT INTO TeamMembers (Id, PersonId, TeamId)
VALUES (1, 1, 1),
	   (2, 2, 2),
	   (3, 3, 4),
	   (4, 4, 3),
	   (5, 5, 5),
	   (6, 6, 2),
	   (7, 7, 5),
	   (8, 8, 1),
	   (9, 9, 4),
	   (10, 10, 3),
	   (11, 13, 2);

SET IDENTITY_INSERT dbo.TeamMembers OFF;

--Insert Data into Products Table

SET IDENTITY_INSERT dbo.Products ON;

INSERT INTO Products (Id, [Name], Size, Wholesale, MSRP)
VALUES (1, 'Buzzz Transfer', 'A', 999, 1599),
	   (2, 'Dread Pirate Transfer', 'C', 1799, 2199),
	   (3, 'No Place Like Home Transfer', 'D', 2199, 2799),
	   (4, 'Inconceivable Transfer', 'B', 1399, 1799),
	   (5, 'More Cow Bell Transfer', 'A', 999, 1599),
	   (6, 'Expelliarmous Transfer', 'B', 1399, 1799),
	   (7, 'Finding Nemo Transfer', 'C', 1799, 2199),
	   (8, 'Allonsy Transfer', 'A', 999, 1599),
	   (9, 'I''m Not Bad Transfer', 'A', 999, 1599),
	   (10, 'Love You Transfer', 'D', 2199, 2799 ),
	   (11, 'No Mans Land Transfer', 'C', 1799, 2199);

SET IDENTITY_INSERT dbo.Products OFF;

--Insert Data into Inventories Table

SET IDENTITY_INSERT dbo.Inventories ON;

INSERT INTO Inventories (Id, PersonId, ProductId, Quantity)
VALUES (1, 1, 9, 2),
	   (2, 1, 10, 1),
	   (3, 2, 2, 2),
	   (4, 2, 4, 1),
	   (5, 3, 1, 2),
	   (6, 3, 10, 1),
	   (7, 4, 8, 3),
	   (8, 4, 3, 1),
	   (9, 5, 5, 5),
	   (10, 5, 9, 1),
	   (11, 6, 7, 2),
	   (12, 6, 3, 1),
	   (13, 6, 2, 1),
	   (14, 7, 9, 3),
	   (15, 7, 4, 1),
	   (16, 8, 10, 3),
	   (17, 8, 1, 1),
	   (18, 9, 6, 3),
	   (19, 9, 8, 1),
	   (20, 10, 3, 4),
	   (21, 10, 4, 1);

SET IDENTITY_INSERT dbo.Inventories OFF;
	   