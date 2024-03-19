USE Northwind

-- Customers Tabelle mit Orders Tabelle zu joinen
SELECT * FROM Customers
SELECT * FROM Orders

-- Lösung Joins
SELECT * FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID

/*
	JOIN Syntax:
	SELECT * FROM Tabelle A JOIN Tabelle B
	ON A.Verknüpfung = B.Verknüpfung
*/

-- Mit WHERE kombinieren
SELECT OrderID, Orders.CustomerID, Customers.* FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Country = 'Germany'

-- Aliase
SELECT * FROM Orders as O
JOIN Customers as cus 
ON cus.CustomerID = O.CustomerID

------------------
-- Übungen
-- 1. Alle Produkte (ProductName) aus den Kategorien "Beverages" und "Produce"
-- (CategoryName in Categories)
-- Tables: Products - Categories
SELECT ProductName FROM Products
JOIN Categories ON Categories.CategoryID = Products.CategoryID
WHERE CategoryName IN ('Beverages', 'Produce')

-- 2. Alle Bestellungen (Orders) bei denen ein Produkt verkauft wurde, das nicht mehr
-- produziert wird (Discontinued = 1)
-- Tables: Orders - Order Details - Products
SELECT * FROM Orders
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
JOIN Products ON Products.ProductID = [Order Details].ProductID
WHERE Discontinued = 1

-- 3. Alle Produkte der Category "Beverages"
-- Tables: Categories - Products
SELECT ProductName FROM Categories
JOIN Products ON  Products.CategoryID = Categories.CategoryID
WHERE CategoryName = 'Beverages'

-- Bonus: Alle Bestellungen (Orders) aus den USA (Customers Country) die im Jahr
-- 1997 aufgegeben wurden (OrderDate in Orders)

-- 4. Welche Produkte (ProductName) hat "Leverling" bisher verkauft?
-- Tabelle: Employees - Orders - [Order Details] - Products
SELECT DISTINCT ProductName, LastName FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID
JOIN Products ON Products.ProductID = [Order Details].ProductID
WHERE LastName = 'Leverling'

-- 5. Wieviele Bestellung haben Kunden aus Argentinien aufgegeben (Anzahl OrderIDs bzw.
-- Anzahl Ergebniszeilen) 
-- Tabellen: Customers - Orders
SELECT COUNT(*) as Bestellungen FROM Orders
JOIN Customers ON Customers.CustomerID = Orders.CustomerID
WHERE Country = 'Argentina'

-- 6. Was war die größte Bestellmenge (Quantity) von Chai Tee (ProductName = 'Chai')?
-- Tabellen: [Order Details] - Products
SELECT TOP 1 ProductName, Quantity FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
WHERE ProductName = 'Chai'
ORDER BY Quantity DESC

---------------------------------------------------
-- OUTER JOINS: Left/Right

-- Right: Z.189 & Z.502
SELECT * FROM Orders
RIGHT JOIN Customers ON Orders.CustomerID = Customers.CustomerID

-- LEFT
SELECT * FROM Customers
LEFT JOIN Orders ON Orders.CustomerID = Customers.CustomerID

-- "invertieren", d.h keine Schnittmenge anzeigen, durch filtern nach NULL
SELECT * FROM Customers
LEFT JOIN Orders ON Orders.CustomerID = Customers.CustomerID
WHERE OrderID IS NULL

SELECT * FROM Orders
RIGHT JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE OrderID IS NULL

-- CROSS JOIN: (A x B) = 830 Zeilen x 91 Zeilen
SELECT * FROM Orders CROSS JOIN Customers

-- SELF JOIN
SELECT E1.EmployeeID, E1.LastName as Vorgesetzter, 
E2.EmployeeID, E2.LastName as Angestellter FROM Employees as E1
RIGHT JOIN Employees as E2 ON E1.EmployeeID = E2.ReportsTo