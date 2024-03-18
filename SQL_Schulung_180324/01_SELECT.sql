-- 1. USE Befehl
-- 2. Dropdown Menü

USE Northwind
-- STRG + E = ausführen

-- einzeiliger Kommentar
/*
	Mehrzeiliger 
	Kommentar
*/

SELECT * FROM Customers

-- "Custom" Werte verwenden
SELECT 100

-- Hallo ausgeben
SELECT 'Hallo'

SELECT 'Hallo', 100

-- Berechnungen durchführen
SELECT 100 + 5, 7*8

-- Ist SQL Case Sensitive?
SeLeCt			CoUnTrY as Country,

		CoMpANyNamE as CompanyName
FrOm		cUsTomErs

-- Duplikate "filtern"
SELECT Country FROM Customers

SELECT DISTINCT Country FROM Customers

SELECT DISTINCT Country, City FROM Customers

-- ORDER BY
SELECT City FROM Customers
ORDER BY City ASC

-- ORDER BY ist syntaktisch immer am ENDE
-- DESC = descending = absteigend
-- ASC = ascending = aufsteigend (default)

SELECT City, CompanyName FROM Customers
ORDER BY City DESC, CompanyName DESC

SELECT Country, City FROM Customers
ORDER BY Country, City

-- TOP = Gibt mir bestimmte X Zeilen aus
SELECT TOP 10 * FROM Customers
SELECT TOP 50 * FROM Customers

-- Die 20 größten Frachtkosten haben
SELECT TOP 20 * FROM Orders
ORDER BY Freight DESC

-- Die 20 kleinsten Frachkosten haben
SELECT TOP 20 * FROM Orders
ORDER BY Freight ASC

-- WICHTIG!: "BOTTOM" X existiert nicht!, umdrehen mit ORDER BY

-- Geht auch mit %
SELECT * FROM Orders
SELECT TOP 10 PERCENT * FROM Orders
SELECT * FROM Customers
SELECT TOP 10 PERCENT * FROM Customers

-- UNION führt mehrere Ergebnistabellen VERTIKAL in eine Tabelle zusammen
-- UNION macht ein automatisches DISTINCT MIT
-- Spaltenanzahl muss gleich sein, Datentypen müssen Kompatibel sein

SELECT * FROM Customers
UNION
SELECT * FROM Customers

-- Das DISTINCT weg lassen => UNION ALL
SELECT * FROM Customers
UNION ALL
SELECT * FROM Customers

-- Testbeispiel
SELECT 100, 'Hallo'
UNION
SELECT 5, 'Tschüss'