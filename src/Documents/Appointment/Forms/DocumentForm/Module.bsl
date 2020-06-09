
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
		Title =  StrTemplate("%1's appointment", Object.Specialization);
	EndIf;
	
EndProcedure

#EndRegion
