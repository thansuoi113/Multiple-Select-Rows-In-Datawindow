$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type st_1 from statictext within w_main
end type
type cb_3 from commandbutton within w_main
end type
type cb_2 from commandbutton within w_main
end type
type cb_1 from commandbutton within w_main
end type
type dw_2 from datawindow within w_main
end type
type dw_1 from datawindow within w_main
end type
end forward

global type w_main from window
integer width = 2391
integer height = 2068
boolean titlebar = true
string title = "Multiple Select Rows in Datawindow"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_1 st_1
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_2 dw_2
dw_1 dw_1
end type
global w_main w_main

type variables
Long il_DWSelectedRow

end variables

on w_main.create
this.st_1=create st_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_2,&
this.dw_1}
end on

on w_main.destroy
destroy(this.st_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event open;dw_2.reset()
end event

type st_1 from statictext within w_main
integer x = 37
integer y = 1856
integer width = 809
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Note: Ctrl + left Or Shift + Left"
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_main
integer x = 1024
integer y = 1024
integer width = 485
integer height = 92
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Count Selected"
end type

event clicked;long ll_Selected

ll_Selected =  long(dw_1.describe("evaluate('sum( if(isselected(), 1, 0) for all)',1)"))

MessageBox('Count',String(ll_Selected))
end event

type cb_2 from commandbutton within w_main
integer x = 512
integer y = 1024
integer width = 485
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Group Selected"
end type

event clicked;
String ls_group[], ls_string
Integer i

ls_group = dw_1.Object.group_id.Data.Selected
ls_string = ""
For i = 1 To UpperBound(ls_group)
	If Len(ls_string) > 0 Then ls_string += "~r~n"
	ls_string += ls_group[i]
Next

MessageBox('Selected Group',ls_string)

end event

type cb_1 from commandbutton within w_main
integer x = 37
integer y = 1024
integer width = 443
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Rows Selected"
end type

event clicked;dw_2.reset()
dw_2.object.data  = dw_1.object.data.selected
end event

type dw_2 from datawindow within w_main
integer x = 37
integer y = 1120
integer width = 2304
integer height = 704
integer taborder = 20
string title = "none"
string dataobject = "d_examples"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_main
event type long ue_shiftclicked ( long paramrow )
integer x = 37
integer y = 32
integer width = 2304
integer height = 960
integer taborder = 10
string title = "none"
string dataobject = "d_examples"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event type long ue_shiftclicked(long paramrow);Long ll_OldRow, ll_StartRow, ll_EndRow, ll_RowCounter
ll_OldRow = il_DWSelectedRow
If ll_OldRow > ParamRow Then
	ll_StartRow = ParamRow
	ll_EndRow = ll_OldRow
Else
	ll_StartRow = ll_OldRow
	ll_EndRow = ParamRow
End If
For ll_RowCounter = ll_StartRow To ll_EndRow Step 1
	This.SelectRow( ll_RowCounter, True )
Next
This.SetRow( ParamRow )
This.SetColumn( 1 )
Return 0

end event

event clicked;If Row > 0 Then
	If KeyDown(KeyControl!) Then
		This.SelectRow(Row,True)
	Else
		This.SelectRow(0,False)
		This.SelectRow(Row,True)
	End If
	If KeyDown(KeyShift!) Then
		This.Event Trigger ue_ShiftClicked( Row )
		Return
	End If
End If
il_DWSelectedRow = Row
This.SetRow(Row)


end event

