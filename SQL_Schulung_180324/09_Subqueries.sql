USE Northwind

-- Subqueries

/*
	- Subqueries müssen eigenständig und fehlerfrei ausführbar sein
	- Können auch überall in jede andere Abfrage eingebaut werden (wenn es Sinn macht)
	- Abfragen werden "von innen nach außen" der Reihe nach ausgeführt
*/

SELECT * FROM Orders
WHERE Freight > (SELECT AVG(FREIGHT) FROM Orders) -- 78,2442

-- nach unterabfrage steht dann das ergebnis der Unterabfrage dann so da (bildlich)
SELECT * FROM Orders
WHERE Freight > 78.2442