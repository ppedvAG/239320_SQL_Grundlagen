USE Northwind

-- WHERE: filtert Ergebniszeilen
SELECT * FROM Customers
WHERE Country = 'Germany'

-- = wird nach exakten Treffern gefiltert
SELECT * FROM Customers
WHERE Country = 'Germany'

-- Vergleichsoperatoren
-- (>, <, >=, <=, != bzw. <>)
SELECT * FROM Orders
WHERE Freight > 100

SELECT * FROM Customers
WHERE Country != 'Germany'

SELECT * FROM Customers
WHERE Country <> 'Germany'

-- Kombinieren mit AND oder OR
SELECT * FROM Customers
WHERE Country = 'Germany' AND City = 'Berlin'

SELECT * FROM Customers
WHERE Country = 'Germany' OR City = 'Berlin'

SELECT * FROM Customers
WHERE Country = 'Germany' OR Country = 'France'

-- AND = "Beide" Bedingungen müssen eintreffen
-- OR = Ein Ausdruck muss wahr sein

-- "Vorsicht" bei Kombination aus AND und OR
SELECT * FROM Customers
WHERE (City = 'Paris' OR City = 'Berlin') AND Country = 'Germany'

SELECT * FROM Orders
WHERE Freight >= 100 AND Freight <= 500

-- Alternativ mit BETWEEN, Randwerte mit inbegriffen
SELECT * FROM Orders
WHERE Freight BETWEEN 100 AND 500

SELECT * FROM Customers
WHERE Country = 'Brazil' OR Country = 'Germany' OR Country = 'France'

-- Alternativ IN
SELECT * FROM Customers
WHERE Country IN ('Brazil', 'Germany', 'France')

-------------------------------------------------------
-- Übungen

-- 1. Alle ContactName die als Title "Owner" haben
-- Tabelle: Customers
SELECT ContactName, ContactTitle FROM Customers
WHERE ContactTitle = 'Owner'

-- 2. Alle Order Details die die ProductID43 bestellt haben
-- Tabelle: [Order Details]
SELECT * FROM [Order Details]
WHERE ProductID = 43

-- 3. Alle Kunden aus Paris, Berlin, Madrid und Brazilien
-- Tabelle: Customers
SELECT * FROM Customers
WHERE City IN('Paris', 'Berlin', 'Madrid') OR Country = 'Brazil'

-- 4. Alle Kunden die eine Fax Nummer haben
-- Tabelle: Customers
SELECT * FROM Customers
WHERE Fax IS NOT NULL

-- Die keine Fax Nummer haben
SELECT * FROM Customers
WHERE Fax IS NULL


