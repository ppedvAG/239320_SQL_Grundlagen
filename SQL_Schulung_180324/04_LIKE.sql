USE Northwind

-- Wildcards
-- "%"-Zeichen: Beliebige Symbole, beliebig viele davon
SELECT ContactName, ContactTitle FROM Customers
WHERE ContactTitle LIKE '%Manager%'

-- "_"-Zeichen: Ein beliebiges Symbol
SELECT CompanyName FROM Customers
WHERE CompanyName LIKE '_l%'

-- "[]"-Zeichen: Alles in den Klammern ist gültig
SELECT PostalCode FROM Customers
WHERE PostalCode LIKE '[012345]%'

-- "[a-z]" oder Gegenteil mit ^ [^a-z]
SELECT PostalCode FROM Customers
WHERE PostalCode LIKE '[0-5]%'

SELECT PostalCode FROM Customers
WHERE PostalCode LIKE '[^123]%'

-- Sonderfälle: % '
SELECT * FROM Customers
WHERE CompanyName LIKE '%''%'

SELECT * FROM Customers
WHERE CompanyName LIKE '%[%]%'