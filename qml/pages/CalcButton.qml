import QtQuick 2.2
import Sailfish.Silica 1.0
import QtFeedback 5.0

Button
{
	property bool highlight
	property string value: text
	property string second: value
	property string image: ""

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
		if ( textfield.text == "" || pos === 0 )
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

	function checkmacro(macro)
	{
		if ( macro === "<left>" )
			textfield.cursorPosition--
		else if ( macro === "<start>" )
			textfield.cursorPosition = 0
		else if ( macro === "<right>" )
			textfield.cursorPosition++
		else if ( macro === "<end>" )
			textfield.cursorPosition = textfield.text.length
		else if ( macro === "<back>" )
			backspace()
		else if ( macro === "<clear>" )
		{
			textfield.text = "";
			textfield.forceActiveFocus()
		}
		else if ( macro === "<evaluate>" )
			evaluate()
		else
			return false
		return true
	}

	ThemeEffect
	{
		id: pressEffect
		effect: "Press"
	}

	onPressed: { screen.interactive = false; keyboard.interactive = false }
	onReleased: { screen.interactive = true; keyboard.interactive = true }
	onExited: { screen.interactive = true; keyboard.interactive = true }
	onCanceled: { screen.interactive = true; keyboard.interactive = true }
	onClicked:
	{
		if ( hapticfeedback && pressEffect.supported )
			pressEffect.play()
		if ( !checkmacro(value) )
			insertValue(value)
	}
	onPressAndHold:
	{
		if ( hapticfeedback && pressEffect.supported )
			pressEffect.play()
		if ( !checkmacro(second) )
			insertValue(second)
	}
}
