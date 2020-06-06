
Function GetUpdatedFileFromServer(Connection, URL, ETag) Export
	
	Headers = New Map();
	Headers.insert("If-None-Match", ETag);
	
	Request = New HTTPRequest(URL, headers);
	Response = Connection.HEAD(Request);
	
	If Response.StatusCode = 200 Then
		Response = Connection.GET(Request);
		
		ETag = Response.Headers.Get("ETag");
		Constants.ETag.Set(ETag);
		
		Return Response.GetBodyAsString();		
	Else	
		Return Undefined;
	EndIf;
	
EndFunction