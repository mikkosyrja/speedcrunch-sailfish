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
		id: grid
		rows: buttonrows; columns: buttoncolumns
		anchors.fill: parent; spacing: buttonspacing
	}

	Component.onCompleted:
	{
		var row, col, script
		for ( row = 0; row < buttonrows; ++row )
		{
			for ( col = 0; col < buttoncolumns; ++col )
			{
				script = manager.getKeyScript("landscape", row, col)
				Qt.createQmlObject(script, grid);
			}
		}
/*
		Qt.createQmlObject('CalcButton { text: "1"; second: "A" }', grid);
		Qt.createQmlObject('CalcButton { text: "2"; second: "B" }', grid);
		Qt.createQmlObject('CalcButton { text: "3"; second: "C" }', grid);
		Qt.createQmlObject('CalcButton { text: "4"; second: "D" }', grid);
		Qt.createQmlObject('CalcButton { text: "5"; second: "E" }', grid);
		Qt.createQmlObject('CalcButton { text: "6"; second: "F" }', grid);
		Qt.createQmlObject('CalcButton { text: "7" }', grid);
		Qt.createQmlObject('CalcButton { text: "8" }', grid);
		Qt.createQmlObject('CalcButton { text: "9"; second: "j" }', grid);
		Qt.createQmlObject('CalcButton { text: "0" }', grid);	// second: ° (degree)

		Qt.createQmlObject('CalcButton { text: "+" }', grid);
		Qt.createQmlObject('CalcButton { text: "-" }', grid);
		Qt.createQmlObject('CalcButton { text: "×" }', grid);
		Qt.createQmlObject('CalcButton { text: "÷"; value: "/" }', grid);
		Qt.createQmlObject('CalcButton { text: "x²"; value: "^2"; second: "^" }', grid);
		Qt.createQmlObject('CalcButton { text: "√"; value: "sqrt()"; second: "cbrt()" }', grid);
		Qt.createQmlObject('CalcButton { text: "!" }', grid);
		Qt.createQmlObject('CalcButton { text: "1/x"; value: "1/" }', grid);
		Qt.createQmlObject('CalcButton { text: "." }', grid);	// second: ' (minute)
		Qt.createQmlObject('CalcButton { text: ";" }', grid);	// second: : (time)

		Qt.createQmlObject('CalcButton { text: "(" }', grid);
		Qt.createQmlObject('CalcButton { text: ")" }', grid);
		Qt.createQmlObject('CalcButton { text: "π"; value: "pi" }', grid);
		Qt.createQmlObject('CalcButton { text: "e" }', grid);
		Qt.createQmlObject('CalcButton { text: "x"; second: "y" }', grid);
		Qt.createQmlObject('CalcButton { text: "x="; value: "="; second: "(x)=" }', grid);
		Qt.createQmlObject('CalcButton { text: "0x"; second: "0b" }', grid);
		Qt.createQmlObject('CalcButton { text: "←"; highlight: true; value: "<left>" }', grid);
		Qt.createQmlObject('CalcButton { text: "→"; highlight: true; value: "<right>" }', grid);
		Qt.createQmlObject('CalcButton { highlight: true; value: "<back>" }', grid);
*/
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
