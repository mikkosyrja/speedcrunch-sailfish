import QtQuick 2.2
import Sailfish.Silica 1.0

Rectangle
{
	property int buttonheight: button1.height
	property int buttoncolumns: 10
	property int buttonrows: 3
	property int buttonspacing

	color: "transparent"
	anchors { fill: parent; leftMargin: buttonspacing; rightMargin: buttonspacing; bottomMargin: buttonspacing }

	Grid	// Page 1
	{
		rows: buttonrows; columns: buttoncolumns
		anchors.fill: parent; spacing: buttonspacing

		CalcButton { id: button1; text: "1"; secondary: "A" }
		CalcButton { id: button2; text: "2"; secondary: "B" }
		CalcButton { id: button3; text: "3"; secondary: "C" }
		CalcButton { id: button4; text: "4"; secondary: "D" }
		CalcButton { id: button5; text: "5"; secondary: "E" }
		CalcButton { id: button6; text: "6"; secondary: "F" }
		CalcButton { id: button7; text: "7" }
		CalcButton { id: button8; text: "8" }
		CalcButton { id: button9; text: "9"; secondary: "j" }
		CalcButton { text: "0" }	// secondary: ° (degree)

		CalcButton { text: "+" }
		CalcButton { text: "-" }
		CalcButton { text: "×" }
		CalcButton { text: "÷"; value: "/" }
		CalcButton { text: "x²"; value: "^2"; secondary: "^" }
		CalcButton { text: "√"; value: "sqrt()"; secondary: "cbrt()" }
		CalcButton { text: "!" }
		CalcButton { text: "1/x"; value: "1/" }
		CalcButton { text: "." }	// secondary: ' (minute)
		CalcButton { text: ";" }	// secondary: : (time)

		CalcButton { text: "(" }
		CalcButton { text: ")" }
		CalcButton { text: "π"; value: "pi" }
		CalcButton { text: "e" }
		CalcButton { text: "x"; secondary: "y" }
		CalcButton { text: "x="; value: "="; secondary: "(x)=" }
		CalcButton { id: buttonbase; text: "0x"; secondary: "0b"  }
		CalcButton { text: "←"; special: true; onRunFunction: { textfield.cursorPosition-- } }
		CalcButton { text: "→"; special: true; onRunFunction: { textfield.cursorPosition++ } }
		Backspace { }
	}

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
