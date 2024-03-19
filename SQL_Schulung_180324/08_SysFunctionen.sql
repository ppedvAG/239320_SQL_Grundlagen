USE Northwind

-- String Funktionen bzw. Tex-Datentypen manipulieren

-- LEN gibt die Länge des Strings zurück als INT
SELECT CompanyName, LEN(CompanyName) FROM Customers

-- LEFT/RIGHT geben die "linken" bzw "rechten" x Zeichen in einem String zurück
SELECT CompanyName, LEFT(CompanyName, 5) FROM Customers
SELECT CompanyName, RIGHT(CompanyName, 5) FROM Customers

-- SUBSTRING(Spalte, x, y) springt zur Position x in einem String und gebe y Zeichen zurück
SELECT CompanyName, SUBSTRING(CompanyName, 5, 5) FROM Customers

-- STUFF(Spalte, x, y, replace) ersetzt y Zeichen eines Strings ab Position x
-- mit einem ggf. 'replace' Wert (optional)
SELECT STUFF(Phone, LEN(Phone) - 4, 5, 'XXXXX'), Phone FROM Customers

-- PATINDEX sucht nach 'Schema' (wie LIKE) in einem String und gibt Position aus,
-- an der das Schema das erste mal gefunden wurde
SELECT PATINDEX('%m%', CompanyName), CompanyName FROM Customers

-- CONCAT fügt mehrere Strings in die Selbe Spalte zusammen
SELECT * FROM Employees
SELECT CONCAT(FirstName, ' ', LastName) as GanzerName FROM Employees
SELECT FirstName + ' ' + LastName as GanzerName FROM Employees

-----------------------------
-- Datumsfunktionen
SELECT GETDATE() -- aktuelle Systemzeit mit Zeitstempel

SELECT * FROM Orders

SELECT YEAR(OrderDate) as Jahr, MONTH(OrderDate) as Monat, DAY(OrderDate) as Tag,
OrderDate FROM Orders

-- "Zieht" ein gewünschtes Intervall aus einem Datum
SELECT
DATEPART(YEAR, OrderDate) as Jahr,
DATEPART(QUARTER, OrderDate) as Quartal,
DATEPART(WEEK, OrderDate) AS KalenderWoche,
DATEPART(WEEKDAY, OrderDate) AS Wochentag,
DATEPART(HOUR, OrderDate) AS Stunde
FROM Orders

-- Zieht den IntervallNamen aus einem Datum
SELECT DATENAME(MONTH, OrderDate), DATENAME(WEEKDAY, OrderDate),
DATEPART(WEEKDAY, OrderDate), OrderDate FROM Orders

-- Differenz zwischen 2 Datum
SELECT DATEDIFF(YEAR, '20050213', GETDATE())
SELECT DATEDIFF(YEAR, OrderDate, GETDATE()), OrderDate FROM Orders

-- Beispiel
-- 1. Alle Bestellungen (Orders) aus Q2 in 1997
SELECT * FROM Orders
WHERE DATEPART(YEAR, OrderDate) = 1997 AND DATEPART(QUARTER, OrderDate) = 2

-- oder
SELECT * FROM Orders  --'YYYYMMDD'
WHERE OrderDate BETWEEN '19970401' AND '19970630'

SELECT CONCAT(YEAR(OrderDate), MONTH(OrderDate), DAY(OrderDate)) FROM Orders

-- Übungen
-- 1. Gab es Bestellungen (OrderID) an Wochenendtagen (OrderDate)?
SELECT * FROM Orders
WHERE DATENAME(WEEKDAY, OrderDate) = 'Samstag' OR DATENAME(WEEKDAY, OrderDate) = 'Sonntag'

SELECT * FROM Orders 
WHERE DATEPART(WEEKDAY, OrderDate) IN (6,7)

-- 2. Wieviele Bestellungen kamen aus Spain (Customers) in Quartal 2 1997?
--    Sind es mehr oder weniger als aus Frankreich? (2 Abfragen)
-- Tables: Customers - Orders

-- Option 1
-- Espaniola
SELECT COUNT(OrderID) FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Customers.Country = 'Spain' AND YEAR(OrderDate) = 1997 
AND DATEPART(QUARTER, OrderDate) = 2

-- France
SELECT COUNT(OrderID) FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Customers.Country = 'France' AND YEAR(OrderDate) = 1997 
AND DATEPART(QUARTER, OrderDate) = 2

-- Option 2
SELECT COUNT(SpanischeKunde.CustomerID), COUNT(FranzKunde.CustomerID) FROM Orders
LEFT JOIN Customers as SpanischeKunde ON SpanischeKunde.CustomerID = Orders.CustomerID 
AND SpanischeKunde.Country = 'Spain'
LEFT JOIN Customers as FranzKunde ON FranzKunde.CustomerID = Orders.CustomerID 
AND FranzKunde.Country = 'France'
WHERE YEAR(OrderDate) = 1997 
AND DATEPART(QUARTER, OrderDate) = 2

-- 3. Alle Bestellungen (Orders) aus den USA (Customers Country) die im Jahr 1997 aufgegeben wurden
-- (OrderDate in Orders)
-- Tables: Customers - Orders
SELECT * FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Country = 'USA' AND DATEPART(YEAR, OrderDate) = '1997'

-- andere Option
SELECT * FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Country = 'USA' AND OrderDate BETWEEN '19970101' AND '19971231'

-- Systemfunktionen
-- CAST oder CONVERT, wandeln Datentypen in der Ausgabe um
SELECT CAST(OrderDate as date) FROM Orders
SELECT CONVERT(smalldatetime, OrderDate) FROM Orders

-- ISNULL prüft auf NULL Werte und ersetzt diese wenn gewünscht
SELECT ISNULL(Fax, 'Nicht vorhanden!') as KeineFax, Fax FROM Customers

-- FORMAT: Komplexere Datumskonvertierung + Unterabfrage
SELECT FORMAT((SELECT CONVERT(date, '20050213')), 'D', 'de-de')

-- Telefonnummer
SELECT FORMAT(4915174327890, CONCAT('+', '## #### #######')) AS 'Custom Number'

-- Replicate(x, y) => Setze "y" mal die "x" vor der Spalte "Phone"
SELECT REPLICATE('0', 3) + Phone FROM Customers

-- REPLACE(x, y, z) => "y" sucht in "x" den String und will ihn mit "z" ersetzen
SELECT REPLACE('Hallo Welt!', 'Welt!', 'und Willkommen!')

-- REVERSE(Spaltenname) => Tut den String umdrehen
SELECT CompanyName, REVERSE(CompanyName) FROM Customers

-- UPPER(Spaltenname) => Alles in großbuchstaben
SELECT CompanyName, UPPER(CompanyName) FROM Customers

-- LOWER(Spaltenname) => Alles in kleinbuchstaben
SELECT CompanyName, LOWER(CompanyName) FROM Customers

------------------------------------------------------------------------
-- 1. Jahrweiser Vergleich unserer 3 Spediteure: (Shippers Tabelle): 
-- Lieferkosten (Freight) gesamt, Durchschnitt (freight)
-- pro Lieferung und Anzahl an Lieferungen
-- Tables: Orders - Shippers
-- Aggregate: SUM, AVG, COUNT
-- DATEPART() benoetigt
/*
	Ergebnis in etwa so:
	SpediteurName, Geschäftsjahr, FreightSum, FreightAvg, AnzBestellungen
	Sped 1		 ,1996			, xy		   , xy		   , xy
	Sped 1		 ,1996			, xy		   , xy		   , xy
	Sped 1		 ,1996			, xy		   , xy		   , xy
	usw....
*/
SELECT CompanyName,
YEAR(OrderDate) as Geschäftsjahr,
SUM(Freight) as FreightSum,
AVG(Freight) as FreightAvg,
COUNT(OrderID) as AnzBestellungen
FROM Shippers
JOIN Orders ON Shippers.ShipperID = Orders.ShipVia
GROUP BY CompanyName, YEAR(OrderDate)
ORDER BY Geschäftsjahr, FreightAvg

-- 2. Wieviel Umsatz haben wir in Q1 1998 mit Kunden aus den USA gemacht?
SELECT SUM(UnitPrice * Quantity) as Umsatz FROM [Order Details]
JOIN Orders ON [Order Details].OrderID = Orders.OrderID
JOIN Customers ON Customers.CustomerID = Orders.CustomerID
WHERE YEAR(OrderDate) = 1998 AND DATEPART(QUARTER, OrderDate) = 1 AND
Country = 'USA'

-- 3. Welches Produkt (ProductName) hatte die groeßte Bestellmenge (Quantity in OD) im Februar 1998?
SELECT TOP 1 ProductName, SUM(Quantity) FROM Products as p
INNER JOIN [Order Details] od ON od.ProductID = p.ProductID
INNER JOIN Orders as o ON o.OrderID = od.OrderID
WHERE MONTH(OrderDate) = 2 AND YEAR(OrderDate) = 1998
GROUP BY ProductName
ORDER BY SUM(Quantity) DESC

-- 4. Ist der Spediteur „Speedy Express“ 
-- über die Jahre durchschnittlich teurer geworden? (Freight pro Jahr)
SELECT CompanyName, YEAR(OrderDate), AVG(Freight) as Durchschnitt  FROM Shippers
JOIN Orders ON Shippers.ShipperID = Orders.ShipVia
WHERE CompanyName = 'Speedy Express'
GROUP BY CompanyName, YEAR(OrderDate)
