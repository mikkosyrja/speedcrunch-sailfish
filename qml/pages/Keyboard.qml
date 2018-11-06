import QtQuick 2.2
import Sailfish.Silica 1.0

Pager
{
	property int buttonheight: button1.height
	property int buttoncolumns: 5
	property int buttonrows: 5
	property int buttonspacing

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
				rows: buttonrows; columns: buttoncolumns
				width: parent.width - buttonspacing; height: parent.height; spacing: buttonspacing

	CalcButton { id: button7; text: "7" }
	CalcButton { id: button8; text: "8" }
	CalcButton { id: button9; text: "9"; value: "9"; secondary: "j" }
	CalcButton { text: "/" }
	CalcButton { text: "x²"; value: "^2"; secondary: "^" }
	CalcButton { id: button4; text: "4"; value: "4"; secondary: "D" }
	CalcButton { id: button5; text: "5"; value: "5"; secondary: "E" }
	CalcButton { id: button6; text: "6"; value: "6"; secondary: "F" }
	CalcButton { text: "×" }
	CalcButton { text: "√"; value: "sqrt()"; secondary: "cbrt()" }
	CalcButton { id: button1; text: "1"; value: "1"; secondary: "A" }
	CalcButton { id: button2; text: "2"; value: "2"; secondary: "B" }
	CalcButton { id: button3; text: "3"; value: "3"; secondary: "C" }
	CalcButton { text: "-" }
	CalcButton { text: "1/x"; value: "1/" }
	CalcButton { text: "0" }	// secondary: ° (degree)
	CalcButton { text: "." }	// secondary: ' (minute)
	CalcButton { text: ";" }	// secondary: : (time)
	CalcButton { text: "+" }
	CalcButton { id: buttonbase; text: "0x"; value: "0x"; secondary: "0b"  }

	CalcButton { text: "("; color: Theme.highlightColor }
	CalcButton { text: ")"; color: Theme.highlightColor }
	CalcButton { text: "←"; special: true; color: Theme.highlightColor; onRunFunction: { textfield.cursorPosition-- } }
	CalcButton { text: "→"; special: true; color: Theme.highlightColor; onRunFunction: { textfield.cursorPosition++ } }
	Backspace { color: Theme.highlightColor }

			}
		}
		Rectangle	// Page 2
		{
			width: parent.parent.width; height: parent.parent.height; color: "transparent"
			Grid
			{
				rows: buttonrows; columns: buttoncolumns
				width: parent.width - buttonspacing; height: parent.height; spacing: buttonspacing

	CalcButton { text: "sin"; value: "sin()" }
	CalcButton { text: "cos"; value: "cos()" }
	CalcButton { text: "tan"; value: "tan()" }
	CalcButton { text: "ln"; value: "ln()" }
	CalcButton { text: "Xⁿ"; value:"^" }

	CalcButton { text: "asin"; value: "arcsin()" }
	CalcButton { text: "acos"; value: "arccos()" }
	CalcButton { text: "atan"; value: "arctan()" }
	CalcButton { text: "exp"; value: "exp()" }
	CalcButton { text: "∛"; value:"cbrt()" }

	CalcButton { text: "π"; value: "pi" }
	CalcButton { text: "e" }
	CalcButton { text: "x"; secondary: "y" }
	CalcButton { text: "X="; value: "="; secondary: "(x)=" }
	CalcButton { text: "!" }

	CalcButton { text: "&" }
	CalcButton { text: "|" }
	CalcButton { text: "<<" }
	CalcButton { text: ">>" }
	CalcButton { text: "➔"; value: "->" }

	CalcButton { text: "("; color: Theme.highlightColor }
	CalcButton { text: ")"; color: Theme.highlightColor }
	CalcButton { text: "←"; special: true; color: Theme.highlightColor; onRunFunction: { textfield.cursorPosition-- } }
	CalcButton { text: "→"; special: true; color: Theme.highlightColor; onRunFunction: { textfield.cursorPosition++ } }
	Backspace { color: Theme.highlightColor }

			}
		}
	}

	Component.onCompleted: goToPage(0);

	function setButtonLabels()
	{
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
	}
}
