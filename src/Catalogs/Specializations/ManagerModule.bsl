
procedure getUpdateFromServer() export
	
	location = "raw.githubusercontent.com";
	URL = "verenikindmitriy/MyHealth/master/resources/specializations.json";
	
	ETag = Constants.ETag.Get();
	if not ValueIsFilled(ETag) then  
		ETag = "*";
	endif;
	
	headers = New Map();
	headers.insert("If-None-Match", ETag);
	
	connection = New HTTPConnection(location,,,,,,New OpenSSLSecureConnection());
	request = New HTTPRequest(URL, headers);
	response = connection.HEAD(request);
	
	if response.StatusCode = 200 then
		response = connection.GET(request);
		
		ETag = response.Headers.Get("ETag");
		Constants.ETag.Set(ETag);
		
		reader = New JSONReader();
		reader.SetString(response.GetBodyAsString());
		data = readJSON(reader);
	endif;
	
endProcedure