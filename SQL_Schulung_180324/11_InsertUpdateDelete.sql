USE Northwind

/**************************************************/

-- CREATE / ALTER / DROP - DDL (Data Definition Language)

/**************************************************/

-- Immer wenn wir Datenbankobjekte "bearbeiten"

-- Tabelle erstellen
CREATE TABLE PurchasingOrders
(
	ID INT IDENTITY(1, 1) PRIMARY KEY,
	OrderDate DATE NOT NULL,
	ProductID INT NOT NULL
)

SELECT * FROM PurchasingOrders

-- Beziehung aufbauen zwischen der PurchasingOrder und Products anlegen über ProductID:
ALTER TABLE PurchasingOrders
ADD FOREIGN KEY (ProductID) REFERENCES Products (ProductID)

-- Neue Spalte hinzufügen
ALTER TABLE PurchasingOrders
ADD TestDaten INT

-- INSERT - Datensätze hinzufügen
-- Alle Spalten befüllen
INSERT INTO PurchasingOrders
VALUES(GETDATE(), 5, 10)

-- Explizit einzelne Spalten befüllen
INSERT INTO PurchasingOrders
(OrderDate, ProductID) VALUES (GETDATE(), 20)

SELECT * FROM PurchasingOrders

-- Ergebnis einer SELECT-Abfrage direkt Inserten
-- Voraussetzung: Gleiche Spaltenanzahl sein + gleiche Datentypen
INSERT INTO PurchasingOrders
SELECT GETDATE(), 3, NULL

-- DELETE - Löschen wir Datensätze in einer bestimmten Tabelle

SELECT * FROM PurchasingOrders

-- Aufpassen! Ohne WHERE Filter werden alle datensätze gelöscht
DELETE FROM PurchasingOrders
WHERE ID = 2

DELETE FROM Customers
WHERE CustomerID = 'ALFKI'

-- UPDATE - Ändern von Spaltenwerten in einem vorhandenen Datensatz
SELECT * FROM PurchasingOrders

UPDATE PurchasingOrders
SET TestDaten = 25
WHERE ID = 3

-- "Löschen" von Werten: SET = NULL
UPDATE PurchasingOrders
SET TestDaten = NULL
WHERE ID = 1


--1. Trage dich selber in die Tabelle ein (Employees). Bei den folgenden Spalten: 
--LastName, FirstName, Title, TitleOfCourtesy, BirthDate, 
--HireDate, City, Region, PostalCode, Country, HomePhone, ReportsTo
SELECT * FROM Employees

INSERT INTO Employees
(LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, City, Region, PostalCode, Country, HomePhone, ReportsTo)
VALUES ('Libowicz', 'Philipp', 'IT-Trainer', 'Mr.', '20050213', '20230901', 'Burghausen', 'DE', 84489, 'Deutschland', '0491234566', 2)

-- 2. Setzt die Region in eurem Datensatz auf NULL
UPDATE Employees
SET Region = NULL
WHERE EmployeeID = 10

-- 3. Erstelle eine Tabelle "TestTabelle" und diese soll folgende Spalten beinhalten:
	-- ID, Primärschlüssel, Automatische Inkrementierung ab 1 in 1er Schritte
	-- Vorname als Spalte, mit passendem Datentyp, nicht null
	-- Nachname als Spalte, mit passendem Datentyp, nicht null

CREATE TABLE TestTabelle
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	Vorname VARCHAR(30) NOT NULL,
	Nachname VARCHAR(30) NOT NULL
)

-- 4. Füge im nachhinein die Spalte "Geburtsdatum" hinzu mit dem passenden Datentyp
ALTER TABLE TestTabelle
ADD Geburtsdatum DATE

SELECT * FROM TestTabelle