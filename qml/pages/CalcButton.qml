import QtQuick 2.2
import Sailfish.Silica 1.0

Button
{
	signal runFunction

	property bool special
	property bool highlight
	property string value: text
	property string second: value
	property string image: (value == "<back>" ? (Theme.colorScheme ? "back-light.png" : "back-dark.png") : "")

	implicitWidth: parent.width / parent.columns - parent.spacing * (parent.columns - 1) / parent.columns;

	color: (highlight ? Theme.highlightColor : Theme.primaryColor)

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

	function backspace()
	{
		var pos = textfield.cursorPosition;
		if ( textfield.text == "" || pos == 0 )
			return;
		if ( textfield.selectionStart - textfield.selectionEnd != 0 )
		{
			var firstpart = textfield.text.slice(0, textfield.selectionStart);
			var lastpart = textfield.text.slice(textfield.selectionEnd);
			textfield.text = firstpart + lastpart
		}
		else
		{
			textfield.text = textfield.text.slice(0, pos - 1) + textfield.text.slice(pos)
			textfield.cursorPosition = pos - 1
		}
	}

	onPressed: { screen.interactive = false; keyboard.interactive = false }
	onReleased: { screen.interactive = true; keyboard.interactive = true }
	onExited: { screen.interactive = true; keyboard.interactive = true }
	onCanceled: { screen.interactive = true; keyboard.interactive = true }
	onClicked:
	{
		if ( value == "<left>" )
			textfield.cursorPosition--
		else if ( value == "<right>" )
			textfield.cursorPosition++
		else if ( value == "<back>" )
			backspace()
		else if ( value == "<evaluate>" )
			evaluate()
		else
			insertValue(value)
	}
	onPressAndHold:
	{
		if ( value == "<left>" )
			textfield.cursorPosition = 0
		else if ( value == "<right>" )
			textfield.cursorPosition = textfield.text.length
		else
			insertValue(second)
	}
}
