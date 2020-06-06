
Procedure GetUpdateFromServer(Connection) export
	
	URL = "verenikindmitriy/MyHealth/master/resources/specializations.json";
	
	ETag = Constants.ETag.Get();
	if not ValueIsFilled(ETag) then  
		ETag = "*";
	endif;
	
	File = FileProvider.GetUpdatedFileFromServer(Connection, URL, ETag);
	
	If File <> Undefined Then	
		Reader = New JSONReader();
		Reader.SetString(File);
		Data = readJSON(reader);
	EndIf;
	
EndProcedure
