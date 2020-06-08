
Procedure GetUpdateFromServer(Connection) Export
	
	URL = "verenikindmitriy/MyHealth/master/resources/diseases.json";
	
	ETag = Constants.ETagDiseases.Get();
	If Not ValueIsFilled(ETag) Then  
		ETag = "*";
	EndIf;
	
	Response = FileProvider.GetUpdatedFileFromServer(Connection, URL, ETag);
	
	If Response <> Undefined Then
		ETag = Response.Headers.Get("ETag");
		
		BeginTransaction();
		Constants.ETagDiseases.Set(ETag);	
				
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
	
	UpdateableElement = Catalogs.Diseases.FindByCode(Code);
	
	If UpdateableElement.IsEmpty() Then
		UpdateableElement = Catalogs.Diseases.CreateItem();
		UpdateableElement.Code = Code;
		UpdateableElement.Description = Element.name;
		UpdateableElement.Write();
	ElsIf UpdateableElement.Description <> Element.name Then
		UpdateableElement = UpdateableElement.GetObject();
		UpdateableElement.Description = Element.name;
		UpdateableElement.Write();
	EndIf;	

EndProcedure