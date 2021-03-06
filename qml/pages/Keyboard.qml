import QtQuick 2.2
import Sailfish.Silica 1.0

Pager
{
	property int buttoncols: 5
	property int buttonrows: 5
	property int buttonspacing
	property var buttonobjects: [[], []]

	property bool leftvirtualkeys: true
	property bool rightvirtualkeys: true
	property bool virtualkeys: (swipeindex ? rightvirtualkeys : leftvirtualkeys)

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
		var size = manager.getKeyboardSize("leftpad")
		buttoncols = size.width
		buttonrows = size.height

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

		leftvirtualkeys = manager.getVirtualKeyboard("leftpad")
		rightvirtualkeys = manager.getVirtualKeyboard("rightpad")
	}
}
