import QtQuick 2.2
import Sailfish.Silica 1.0

Button
{
	signal runFunction

	property bool special;
	property string value: text
	property string secondary: value
	property string image: ""

	implicitWidth: parent.width / parent.columns - parent.spacing * (parent.columns - 1) / parent.columns;

	Image
	{
		anchors { horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter }
		visible: image.length
		source: image
	}
	function insertValue(value)
	{
		var pos = textfield.cursorPosition
		if ( textfield.selectionStart - textfield.selectionEnd != 0 )
		{
			var firstpart = textfield.text.slice(0, textfield.selectionStart);
			var lastpart = textfield.text.slice(textfield.selectionEnd);
			textfield.text = firstpart + value + lastpart
		}
		else
			textfield.text = textfield.text.slice(0, pos) + value + textfield.text.slice(pos)
		textfield.cursorPosition = pos + value.length
		if ( value.slice(-2) === "()" )
			textfield.cursorPosition--
	}
	onClicked:
	{
		if ( special )
			runFunction();
		else
			insertValue(value)
	}
	onPressAndHold:
	{
		if ( text == "←" )
			textfield.cursorPosition = 0
		else if ( text == "→" )
			textfield.cursorPosition = textfield.text.length
		else
			insertValue(secondary)
	}
}
