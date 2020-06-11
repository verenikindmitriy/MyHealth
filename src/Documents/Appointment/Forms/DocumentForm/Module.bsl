
#Region FormEventHandlers

&AtServer
Procedure OnCreateAtServer(Cancel, StandardProcessing)
	ChangeTitle();
EndProcedure

#EndRegion

#Region FormHeaderItemsEventHandlers

&AtClient
Procedure SpecializationOnChange(Item)
	ChangeTitle();
EndProcedure

#EndRegion

#Region Private

&AtServer
Procedure ChangeTitle()
	
	If Not Object.Specialization.IsEmpty() Then
		Template = Nstr("en = '%1''s appointment'; ru = 'Прием врача ""%1""'");
		If Not IsBlankString(Template) Then
			Title =  StrTemplate(Template, Object.Specialization);
		EndIf;
	EndIf;
	
EndProcedure

#EndRegion
