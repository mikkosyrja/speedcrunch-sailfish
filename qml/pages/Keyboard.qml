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
				id: grid1
				rows: buttonrows; columns: buttoncolumns
				width: parent.width - buttonspacing; height: parent.height; spacing: buttonspacing
			}
		}
		Rectangle	// Page 2
		{
			width: parent.parent.width; height: parent.parent.height; color: "transparent"
			Grid
			{
				id: grid2
				rows: buttonrows; columns: buttoncolumns
				width: parent.width - buttonspacing; height: parent.height; spacing: buttonspacing
			}
		}
	}

	Component.onCompleted:
	{
		var script = manager.getKeyScript("leftpad", 0, 0);
		Qt.createQmlObject(script, grid1);

//		Qt.createQmlObject('CalcButton { text: "7" }', grid1);
		Qt.createQmlObject('CalcButton { text: "8" }', grid1);
		Qt.createQmlObject('CalcButton { text: "9"; second: "j" }', grid1);
		Qt.createQmlObject('CalcButton { text: "÷"; value: "/" }', grid1);
		Qt.createQmlObject('CalcButton { text: "x²"; value: "^2"; second: "^" }', grid1);

		Qt.createQmlObject('CalcButton { text: "4"; second: "D" }', grid1);
		Qt.createQmlObject('CalcButton { text: "5"; second: "E" }', grid1);
		Qt.createQmlObject('CalcButton { text: "6"; second: "F" }', grid1);
		Qt.createQmlObject('CalcButton { text: "×" }', grid1);
		Qt.createQmlObject('CalcButton { text: "√"; value: "sqrt()"; second: "cbrt()" }', grid1);

		Qt.createQmlObject('CalcButton { text: "1"; second: "A" }', grid1);
		Qt.createQmlObject('CalcButton { text: "2"; second: "B" }', grid1);
		Qt.createQmlObject('CalcButton { text: "3"; second: "C" }', grid1);
		Qt.createQmlObject('CalcButton { text: "-" }', grid1);
		Qt.createQmlObject('CalcButton { text: "1/x"; value: "1/" }', grid1);

		Qt.createQmlObject('CalcButton { text: "0" }', grid1);	// second: ° (degree)
		Qt.createQmlObject('CalcButton { text: "." }', grid1);	// second: ' (minute)
		Qt.createQmlObject('CalcButton { text: ";" }', grid1);	// second: : (time)
		Qt.createQmlObject('CalcButton { text: "+" }', grid1);
		Qt.createQmlObject('CalcButton { text: "0x"; second: "0b" }', grid1);

		Qt.createQmlObject('CalcButton { text: "("; highlight: true }', grid1);
		Qt.createQmlObject('CalcButton { text: ")"; highlight: true }', grid1);
		Qt.createQmlObject('CalcButton { text: "←"; highlight: true; value: "<left>" }', grid1);
		Qt.createQmlObject('CalcButton { text: "→"; highlight: true; value: "<right>" }', grid1);
		Qt.createQmlObject('CalcButton { highlight: true; value: "<back>" }', grid1);

		Qt.createQmlObject('CalcButton { text: "sin"; value: "sin()" }', grid2);
		Qt.createQmlObject('CalcButton { text: "cos"; value: "cos()" }', grid2);
		Qt.createQmlObject('CalcButton { text: "tan"; value: "tan()" }', grid2);
		Qt.createQmlObject('CalcButton { text: "ln"; value: "ln()"; second: "lg()" }', grid2);
		Qt.createQmlObject('CalcButton { text: "xⁿ"; value:"^"; second: "^2" }', grid2);

		Qt.createQmlObject('CalcButton { text: "asin"; value: "arcsin()" }', grid2);
		Qt.createQmlObject('CalcButton { text: "acos"; value: "arccos()" }', grid2);
		Qt.createQmlObject('CalcButton { text: "atan"; value: "arctan()" }', grid2);
		Qt.createQmlObject('CalcButton { text: "exp"; value: "exp()"; second: "10^" }', grid2);
		Qt.createQmlObject('CalcButton { text: "∛"; value:"cbrt()"; second: "sqrt()" }', grid2);

		Qt.createQmlObject('CalcButton { text: "π"; value: "pi" }', grid2);
		Qt.createQmlObject('CalcButton { text: "e" }', grid2);
		Qt.createQmlObject('CalcButton { text: "x"; second: "y" }', grid2);
		Qt.createQmlObject('CalcButton { text: "x="; value: "="; second: "(x)=" }', grid2);
		Qt.createQmlObject('CalcButton { text: "!" }', grid2);

		Qt.createQmlObject('CalcButton { text: "&" }', grid2);
		Qt.createQmlObject('CalcButton { text: "|" }', grid2);
		Qt.createQmlObject('CalcButton { text: "<<" }', grid2);
		Qt.createQmlObject('CalcButton { text: ">>" }', grid2);
		Qt.createQmlObject('CalcButton { text: "➔"; value: "->" }', grid2);

		Qt.createQmlObject('CalcButton { text: "("; highlight: true }', grid2);
		Qt.createQmlObject('CalcButton { text: ")"; highlight: true }', grid2);
		Qt.createQmlObject('CalcButton { text: "←"; highlight: true; value: "<left>" }', grid2);
		Qt.createQmlObject('CalcButton { text: "→"; highlight: true; value: "<right>" }', grid2);
		Qt.createQmlObject('CalcButton { highlight: true; value: "<back>" }', grid2);

		goToPage(0);
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
