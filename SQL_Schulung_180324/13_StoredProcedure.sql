USE Northwind
GO

/***********************************************/

-- gespeicherte Prozeduren

/***********************************************/

/*
	- Sind gespeicherte SQL Anweisungen () gilt nicht nur für das SELECT
	- Arbeiten mit Variablen
	- Praktisch zum "automatisieren" von Code
*/

CREATE PROCEDURE spRechnungsByOrderID @OrderID INT
AS
SELECT * FROM vRechnungsDaten
WHERE OrderID = @OrderID -- <- 10248
GO

-- Prozedur ausführen
EXEC spRechnungsByOrderID 10248
GO


CREATE PROCEDURE spNewCustomerNeu
@CustomerID char(5), @CompanyName varchar(49),
@Country varchar(30), @City varchar(30)
AS
INSERT INTO Customers (CustomerID, CompanyName, Country, City)
VALUES (@CustomerID, @CompanyName, @Country, @City)
GO

EXEC spNewCustomerNeu ALDIS, 'ppedv AG', Germany, Burghausen
EXEC spNewCustomerNeu LIDLI, 'Lidl GmbH', Germany, Burghausen

SELECT * FROM Customers
WHERE CustomerID = 'LIDLI'
go

-- Default Werte
CREATE PROCEDURE spKundenNachLandCityNeu @Country varchar(50) = 'Germany', @City varchar(50) = 'Berlin'
AS
SELECT * FROM Customers
WHERE Country = @Country AND City = @City
GO

EXEC spKundenNachLandCityNeu France, Paris
go


CREATE PROCEDURE spKundenNachLandCityNeu2 @Country varchar(50) = 'Germany', @City varchar(50)
AS
SELECT * FROM Customers
WHERE Country = @Country AND City = @City
GO

-- Mog i nedda!!
EXEC spKundenNachLandCityNeu2  '',Berlin

-- Erstelle eine Procedure, der man als Parameter eine OrderID übergeben kann.
-- Bei Ausführung soll der Rechnungsbetrag dieser Order ausgegeben werden 
-- SUM(Quantity * UnitPrice + Freight) = RechnungsSumme.
CREATE PROCEDURE sp_RechnungsSumme @OrderID INT
AS
SELECT Orders.OrderID, SUM(Quantity * UnitPrice + Freight) as RechnungsSumme FROM Orders
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
WHERE Orders.OrderID = @OrderID
GROUP BY Orders.OrderID
GO

EXEC sp_RechnungsSumme 10250