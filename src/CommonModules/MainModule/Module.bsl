
Procedure GetUpdateCatalogsFromServer() Export
	
	Location = "raw.githubusercontent.com";
	Connection = New HTTPConnection(Location,,,,,,New OpenSSLSecureConnection());
	
	Catalogs.Specializations.getUpdateFromServer(Connection);
	
EndProcedure