import QtQuick 2.2
import Sailfish.Silica 1.0

Pager
{
	property int buttoncols: 5
	property int buttonrows: 5
	property int buttonspacing
	property var buttonobjects: [[], []]

	color: "transparent"
	anchors { fill: parent; leftMargin: buttonspacing }
	clip: true

	model: VisualItemModel
	{
		Rectangle	// Page 1
		{
			width: parent.parent.width; height: parent.parent.height; color: "transparent"
			Grid
			{
				id: leftpanel
				rows: buttonrows; columns: buttoncols
				width: parent.width - buttonspacing; height: parent.height; spacing: buttonspacing
			}
		}
		Rectangle	// Page 2
		{
			width: parent.parent.width; height: parent.parent.height; color: "transparent"
			Grid
			{
				id: rightpanel
				rows: buttonrows; columns: buttoncols
				width: parent.width - buttonspacing; height: parent.height; spacing: buttonspacing
			}
		}
	}

	Component.onCompleted:
	{
		goToPage(0);
	}

	function loadButtons()
	{
		var row, col, index, script

		for ( index = 0; index < buttonobjects[0].length; ++index )
			buttonobjects[0][index].destroy()
		buttonobjects[0].length = 0
		for ( index = 0; index < buttonobjects[1].length; ++index )
			buttonobjects[1][index].destroy()
		buttonobjects[1].length = 0

		for ( row = 0; row < buttonrows; ++row )
		{
			for ( col = 0; col < buttoncols; ++col )
			{
				script = manager.getKeyScript("leftpad", row, col)
				buttonobjects[0].push(Qt.createQmlObject(script, leftpanel));
				script = manager.getKeyScript("rightpad", row, col)
				buttonobjects[1].push(Qt.createQmlObject(script, rightpanel));
			}
		}

		script = manager.getKeyScript("editkey", 0, 0)
		var editbutton = Qt.createQmlObject(script, leftpanel);
		evaluatebutton.text = editbutton.text
		evaluatebutton.value = editbutton.value
		evaluatebutton.second = editbutton.second
		editbutton.destroy()
	}

	function setButtonLabels()
	{
/*
		var format = manager.getResultFormat()
		if ( format === "h" )
		{
			button1.text = "1 A"; button2.text = "2 B"; button3.text = "3 C"
			button4.text = "4 D"; button5.text = "5 E"; button6.text = "6 F"
		}
		else
		{
			button1.text = "1"; button2.text = "2"; button3.text = "3"
			button4.text = "4"; button5.text = "5"; button6.text = "6"
		}
		if ( format === "h" || format === "b" || format === "o" )
			buttonbase.text = "0x 0b"
		else
			buttonbase.text = "0x"
		var complex = manager.getComplexNumber()
		if ( complex === "c" || complex === "p" )
			button9.text = "9 j"
		else
			button9.text = "9"
*/
	}
}
