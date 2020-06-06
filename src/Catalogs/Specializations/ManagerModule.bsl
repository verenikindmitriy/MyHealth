
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
		
		For Each Element In Data Do
			UpdateElementInDB(Element);
		EndDo;
	EndIf;
	
EndProcedure

Procedure UpdateElementInDB(Element)
	
	Code = Element.id;
	
	UpdateableElement = Catalogs.Specializations.FindByCode(Code);
	
	If UpdateableElement.IsEmpty() Then
		UpdateableElement = Catalogs.Specializations.CreateItem();
		UpdateableElement.Code = Code;
		UpdateableElement.Description = Element.name;
		UpdateableElement.Write();
	ElsIf UpdateableElement.Description <> Element.name Then
		UpdateableElement = UpdateableElement.GetObject();
		UpdateableElement.Description = Element.name;
		UpdateableElement.Write();
	EndIf;	

EndProcedure