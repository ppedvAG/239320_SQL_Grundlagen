USE Northwind

-- 5 grundsätzliche verschieden Funktionen

SELECT
SUM(Freight) as Summe,
MIN(Freight) as Minimum,
MAX(Freight) as Maximum,
AVG(Freight) as Durchschnitt,
COUNT(ShippedDate) as ZähleAlles, COUNT(*) as ZähleAlles
FROM Orders

-- AVG Selber berechnen
SELECT SUM(Freight) / COUNT(*) FROM Orders

SELECT CustomerID, SUM(Freight) FROM Orders
-- GROUP BY - fasst mehrere Werte in Gruppen zusammen

-- 29,46 + 61,02 + 23,94 + 69,53 ....
SELECT CustomerID, SUM(Freight) FROM Orders
GROUP BY CustomerID

SELECT ProductID, SUM(Quantity) as SummeStueckzahl FROM [Order Details]
GROUP BY ProductID
ORDER BY ProductID

-- Quantity Summe pro ProductName
SELECT ProductName, SUM(Quantity) as Menge FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
GROUP BY ProductName
ORDER BY Menge

-- Verkauften Stueckzahlen pro Produkt, aber nur über 1000
-- Geht nicht so!
SELECT ProductName, SUM(Quantity) as SummeStueckZahl FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
WHERE SUM(Quantity) > 1000
GROUP BY ProductName
ORDER BY SummeStueckZahl

-- HAVING: funktioniert 1zu1 wie das Where, kann aber gruppierte/aggregierte Werte
-- nachträglich filtern
SELECT ProductName, SUM(Quantity) as SummeStueckZahl FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
--WHERE SUM(Quantity) > 1000
GROUP BY ProductName
HAVING SUM(Quantity) > 1000
ORDER BY SummeStueckZahl

-- Übungsaufgaben:
-- 1. Wieviele Bestellungen hat jeder Mitarbeiter bearbeitet? (9 Ergebniszeilen)
-- Tables: Employees - Orders
SELECT LastName, COUNT(OrderID) as Bestellungen FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY LastName
ORDER BY Bestellungen DESC

-- 2. Was war das meistverkaufte Produkt (ProductName)? Wieviel Stück (Quantity)? (1 Ergebniszeile)
-- Tables: Products - Order Details - Orders
SELECT TOP 1 ProductName, SUM(Quantity) as Stueckmenge FROM Products
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
GROUP BY ProductName
ORDER BY Stueckmenge DESC

-- 3. In welcher Stadt (City) waren "Wimmers gute Semmelknödel" am beliebtesten (Quantity)?
-- Tables: Products - Order Details - Orders - Customers (1 Ergebniszeile)
SELECT TOP 1 City, SUM(Quantity) as Verkaufsmenge FROM Products
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
JOIN Customers ON Customers.CustomerID = Orders.CustomerID
WHERE ProductName = 'Wimmers gute Semmelknödel'
GROUP BY City
ORDER BY Verkaufsmenge DESC

-- 4. Welcher Spediteur (Shippers) war durchschnittlich am günstigsten? (Freight)
-- Tables: Shippers - Orders (1 Ergebniszeile)
SELECT TOP 1 CompanyName, AVG(Freight) as AvgFreight FROM Shippers
JOIN Orders ON Orders.ShipVia = Shippers.ShipperID
GROUP BY CompanyName
ORDER BY AvgFreight 

-- Für die super Schnellen... zum Basteln
-- BONUS: Hatten wir Bestellungen, die wir zu spaet ausgeliefert haben? Wenn 
-- ja, welche OrderIDs waren das und wieviele Tage
-- waren wir zu spaet dran? (Verzoegerung = Unterschied zwischen Shipped 
-- & Required Date in Orders) Tipp: DATEDIFF & ISNULL
-- ISNULL prueft auf Null Werte und ersetzt diese wenn gewuenscht
-- SELECT ISNULL(Fax, 'Nicht vorhanden!') as KeineFax, Fax FROM Customers
/* 37
OrderID, "TageZuSpaet"
OrderID, "TageZuSpaet"
OrderID, "TageZuSpaet"
usw...
*/
SELECT OrderID, ISNULL(CAST(DATEDIFF(DAY, RequiredDate, ShippedDate) as nvarchar), 'Nicht ausgeliefert!') as Verzögerung 
FROM Orders
WHERE DATEDIFF(DAY, RequiredDate, ShippedDate) > 0 OR ShippedDate IS NULL