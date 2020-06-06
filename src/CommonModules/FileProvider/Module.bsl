
Function GetUpdatedFileFromServer(Connection, URL, ETag) Export
	
	Headers = New Map();
	Headers.Insert("If-None-Match", ETag);
	
	Request = New HTTPRequest(URL, Headers);
	Response = Connection.Get(Request);
	
	// The server will return code 304 if the file wasn't changed
	If Response.StatusCode = 200 Then
		ETag = Response.Headers.Get("ETag");
		Constants.ETag.Set(ETag);
		
		Return Response.GetBodyAsString();		
	Else	
		Return Undefined;
	EndIf;
	
EndFunction
