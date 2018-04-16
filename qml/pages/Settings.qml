import QtQuick 2.2
import Sailfish.Silica 1.0

Rectangle
{
	Rectangle
	{
		id: resultformatsetting
		width: parent.width; height: settingheight; color: "transparent"
		anchors.top: settings.top
		z: 40
		ComboBox
		{
			id: resultformatlist
			label: "Result format"
			menu: ContextMenu
			{
				MenuItem { text: "General decimal" }
				MenuItem { text: "Fixed decimal" }
				MenuItem { text: "Engineering decimal" }
				MenuItem { text: "Scientific decimal" }
				MenuItem { text: "Binary" }
				MenuItem { text: "Octal" }
				MenuItem { text: "Hexadecimal" }
			}
			onCurrentIndexChanged:
			{
				if ( currentIndex == 0 ) { manager.setResultFormat("g"); }
				else if ( currentIndex == 1 ) { manager.setResultFormat("f"); }
				else if ( currentIndex == 2 ) { manager.setResultFormat("n"); }
				else if ( currentIndex == 3 ) { manager.setResultFormat("e"); }
				else if ( currentIndex == 4 ) { manager.setResultFormat("b"); }
				else if ( currentIndex == 5 ) { manager.setResultFormat("o"); }
				else if ( currentIndex == 6 ) { manager.setResultFormat("h"); }
				keyboard.setButtonLabels()
			}
			function setResultFormat(format)
			{
				if ( format == "g" ) currentIndex = 0
				else if ( format == "f" ) currentIndex = 1
				else if ( format == "n" ) currentIndex = 2
				else if ( format == "e" ) currentIndex = 3
				else if ( format == "b" ) currentIndex = 4
				else if ( format == "o" ) currentIndex = 5
				else if ( format == "h" ) currentIndex = 6
			}
		}
	}
	Rectangle
	{
		id: precisionsetting
		width: parent.width; height: settingheight; color: "transparent"
		anchors.top: resultformatsetting.bottom
		z: 30
		ComboBox
		{
			id: precisionlist
			label: "Precision"
			menu: ContextMenu
			{
				MenuItem { text: "Automatic" }
				MenuItem { text: "0" } MenuItem { text: "1" }
				MenuItem { text: "2" } MenuItem { text: "3" }
				MenuItem { text: "4" } MenuItem { text: "6" }
				MenuItem { text: "8" } MenuItem { text: "12" }
				MenuItem { text: "16" } MenuItem { text: "20" }
			}
			onCurrentIndexChanged:
			{
				if ( currentIndex == 0 )
					manager.setPrecision("")
				else
					manager.setPrecision(currentItem.text)
			}
			function setPrecision(precision)
			{
				if ( precision == "0" ) currentIndex = 1
				else if ( precision == "1" ) currentIndex = 2
				else if ( precision == "2" ) currentIndex = 3
				else if ( precision == "3" ) currentIndex = 4
				else if ( precision == "4" ) currentIndex = 5
				else if ( precision == "6" ) currentIndex = 6
				else if ( precision == "8" ) currentIndex = 7
				else if ( precision == "12" ) currentIndex = 8
				else if ( precision == "16" ) currentIndex = 9
				else if ( precision == "20" ) currentIndex = 10
				else currentIndex = 0;
			}
		}
	}
	Rectangle
	{
		id: angleunitsetting
		width: parent.width; height: settingheight; color: "transparent"
		anchors.top: precisionsetting.bottom
		z: 20
		ComboBox
		{
			id: angleunitlist
			label: "Angle Unit"
			menu: ContextMenu
			{
				MenuItem { text: "Degree" }
				MenuItem { text: "Radian" }
//				MenuItem { text: "Gradian" }
			}
			onCurrentIndexChanged:
			{
				if ( currentIndex == 0 ) manager.setAngleUnit("d")
				else if ( currentIndex == 1 ) manager.setAngleUnit("r")
//				else if ( currentIndex == 2 ) manager.setAngleUnit("g")
			}
			function setAngleUnit(unit)
			{
				if ( unit == "d" ) currentIndex = 0
				else if ( unit == "r" ) currentIndex = 1
//				else if ( unit == "g" ) currentIndex = 2
			}
		}
	}
	Rectangle
	{
		id: complexnumbersetting
		width: parent.width; height: settingheight; color: "transparent"
		anchors.top: angleunitsetting.bottom
		z: 10
		ComboBox
		{
			id: complexnumberlist
			label: "Complex numbers"
			menu: ContextMenu
			{
				MenuItem { text: "Disabled" }
				MenuItem { text: "Cartesian" }
				MenuItem { text: "Polar" }
			}
			onCurrentIndexChanged:
			{
				if ( currentIndex == 0 ) manager.setComplexNumber("d")
				else if ( currentIndex == 1 ) manager.setComplexNumber("c")
				else if ( currentIndex == 2 ) manager.setComplexNumber("p")
				keyboard.setButtonLabels()
			}
			function setComplexNumber(complex)
			{
				if ( complex == "d" ) currentIndex = 0
				else if ( complex == "c" ) currentIndex = 1
				else if ( complex == "p" ) currentIndex = 2
			}
		}
	}
/*
	Rectangle
	{
		id: expressionsetting
		width: parent.width; height: settingheight; color: "transparent"
		anchors.top: complexnumbersetting.bottom
		TextSwitch
		{
			id: expressionswitch
			checked: true
			text: "Leave Last Expression"
//			description: "Leave Last Expression"
		}
	}
	Rectangle
	{
		id: historysetting
		width: parent.width; height: settingheight; color: "transparent"
		anchors.top: expressionsetting.bottom
		TextSwitch
		{
			id: historyswitch
			checked: true
			text: "Save History on Exit"
//			description: "Save History on Exit"
		}
	}
*/

	Component.onCompleted:
	{
		angleunitlist.setAngleUnit(manager.getAngleUnit())
		resultformatlist.setResultFormat(manager.getResultFormat())
		precisionlist.setPrecision(manager.getPrecision())
		complexnumberlist.setComplexNumber(manager.getComplexNumber())
	}
}
