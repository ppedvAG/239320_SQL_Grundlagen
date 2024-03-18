/*
	char(10) = 'Hallo     ' = 10 Byte verwendet werden
	nchar(10) = 'Hallo     ' = 20 Byte => kann UTF-16

	varchar(10) = 'Hallo' = 5 Byte verwendet werden
	nvarchar(10) = 'Hallo' = 10 Byte => kann UTF-16

	Legacy: text --> VARCHAR(Max) = bis zu 2GB groﬂ
	varchar(8000) & nvarchar(4000) sind maximum
*/