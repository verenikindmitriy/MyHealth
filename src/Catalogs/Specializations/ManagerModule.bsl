
Procedure GetUpdateFromServer(Connection) Export
	
	URL = "verenikindmitriy/MyHealth/master/resources/specializations.json";
	
	ETag = Constants.ETagSpecializations.Get();
	If Not ValueIsFilled(ETag) Then  
		ETag = "*";
	EndIf;
	
	Response = FileProvider.GetUpdatedFileFromServer(Connection, URL, ETag);
	
	If Response <> Undefined Then
		ETag = Response.Headers.Get("ETag");
		
		BeginTransaction();
		Constants.ETagSpecializations.Set(ETag);	
				
		Reader = New JSONReader();
		Reader.SetString(Response.GetBodyAsString());
		Data = readJSON(reader);
		
		For Each Element In Data Do
			UpdateElementInDB(Element);
		EndDo;
		
		CommitTransaction();
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