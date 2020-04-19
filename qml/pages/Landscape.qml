import QtQuick 2.2
import Sailfish.Silica 1.0

Rectangle
{
	property int buttoncols: 10
	property int buttonrows: 3
	property int buttonspacing
	property var buttonobjects: []

	property bool virtualkeys: true

	color: "transparent"
	anchors { fill: parent; leftMargin: buttonspacing; rightMargin: buttonspacing; bottomMargin: buttonspacing }

	Grid	// Page 1
	{
		id: panel
		rows: buttonrows; columns: buttoncols
		anchors.fill: parent; spacing: buttonspacing
	}

	function loadButtons()
	{
		var row, col, index, script
		var size = manager.getKeyboardSize("landscape")
		buttoncols = size.width
		buttonrows = size.height

		for ( index = 0; index < buttonobjects.length; ++index )
			buttonobjects[index].destroy()
		buttonobjects.length = 0

		for ( row = 0; row < buttonrows; ++row )
		{
			for ( col = 0; col < buttoncols; ++col )
			{
				script = manager.getKeyScript("landscape", row, col)
				buttonobjects.push(Qt.createQmlObject(script, panel));
			}
		}

		virtualkeys = manager.getVirtualKeyboard("landscape")
	}
}
