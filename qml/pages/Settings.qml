import QtQuick 2.2
import Sailfish.Silica 1.0

Rectangle
{
	property alias resultformat: resultformatlist.value
	property alias angleunit: angleunitlist.value
	property bool initialized: false

	SilicaFlickable		// for pull-up
	{
		anchors.fill: parent
		Rectangle
		{
			id: resultformatsetting
			width: parent.width; height: settingheight; color: "transparent"
			anchors.top: parent.top
			z: 70
			ComboBox
			{
				id: resultformatlist
				//: Setting title
				label: qsTrId("id-result-format")
				anchors.fill: parent
				menu: ContextMenu
				{
					MenuItem { text: qsTrId("id-general-decimal"); height: settingheight }
					MenuItem { text: qsTrId("id-fixed-decimal"); height: settingheight }
					MenuItem { text: qsTrId("id-engineering-decimal"); height: settingheight }
					MenuItem { text: qsTrId("id-scientific-decimal"); height: settingheight }
					MenuItem { text: qsTrId("id-binary"); height: settingheight }
					MenuItem { text: qsTrId("id-octal"); height: settingheight }
					MenuItem { text: qsTrId("id-hexadecimal"); height: settingheight }
//					MenuItem { text: qsTrId("id-sexagesimal"); height: settingheight }
				}
				onCurrentIndexChanged:
				{
					if ( initialized )
					{
						if ( currentIndex == 0 ) { manager.setResultFormat("g") }
						else if ( currentIndex == 1 ) { manager.setResultFormat("f") }
						else if ( currentIndex == 2 ) { manager.setResultFormat("n") }
						else if ( currentIndex == 3 ) { manager.setResultFormat("e") }
						else if ( currentIndex == 4 ) { manager.setResultFormat("b") }
						else if ( currentIndex == 5 ) { manager.setResultFormat("o") }
						else if ( currentIndex == 6 ) { manager.setResultFormat("h") }
//						else if ( currentIndex == 7 ) { manager.setResultFormat("s") }
					}
					keyboard.setButtonLabels()
					historyview.updateHistory()
				}
				function setResultFormat(format)
				{
					if ( format === "g" ) currentIndex = 0
					else if ( format === "f" ) currentIndex = 1
					else if ( format === "n" ) currentIndex = 2
					else if ( format === "e" ) currentIndex = 3
					else if ( format === "b" ) currentIndex = 4
					else if ( format === "o" ) currentIndex = 5
					else if ( format === "h" ) currentIndex = 6
//					else if ( format === "s" ) currentIndex = 7
				}
			}
		}
		Rectangle
		{
			id: precisionsetting
			width: parent.width; height: settingheight; color: "transparent"
			anchors.top: resultformatsetting.bottom
			z: 60
			ComboBox
			{
				id: precisionlist
				//: Setting title
				label: qsTrId("id-precision")
				menu: ContextMenu
				{
					MenuItem { text: qsTrId("id-automatic"); height: settingheight }
					MenuItem { text: "0"; height: settingheight } MenuItem { text: "1"; height: settingheight }
					MenuItem { text: "2"; height: settingheight } MenuItem { text: "3"; height: settingheight }
					MenuItem { text: "4"; height: settingheight } MenuItem { text: "6"; height: settingheight }
					MenuItem { text: "8"; height: settingheight } MenuItem { text: "12"; height: settingheight }
					MenuItem { text: "16"; height: settingheight } MenuItem { text: "20"; height: settingheight }
				}
				onCurrentIndexChanged:
				{
					if ( initialized )
						manager.setPrecision(currentIndex == 0 ? "" : currentItem.text)
					historyview.updateHistory()
				}
				function setPrecision(precision)
				{
					if ( precision === "0" ) currentIndex = 1
					else if ( precision === "1" ) currentIndex = 2
					else if ( precision === "2" ) currentIndex = 3
					else if ( precision === "3" ) currentIndex = 4
					else if ( precision === "4" ) currentIndex = 5
					else if ( precision === "6" ) currentIndex = 6
					else if ( precision === "8" ) currentIndex = 7
					else if ( precision === "12" ) currentIndex = 8
					else if ( precision === "16" ) currentIndex = 9
					else if ( precision === "20" ) currentIndex = 10
					else currentIndex = 0;
				}
			}
		}
		Rectangle
		{
			id: angleunitsetting
			width: parent.width; height: settingheight; color: "transparent"
			anchors.top: precisionsetting.bottom
			z: 50
			ComboBox
			{
				id: angleunitlist
				//: Setting title
				label: qsTrId("id-angle-unit")
				menu: ContextMenu
				{
					MenuItem { text: qsTrId("id-degree"); height: settingheight }
					MenuItem { text: qsTrId("id-radian"); height: settingheight }
//					MenuItem { text: qsTrId("id-gradian"); height: settingheight }
				}
				onCurrentIndexChanged:
				{
					if ( initialized )
					{
						if ( currentIndex == 0 ) manager.setAngleUnit("d")
						else if ( currentIndex == 1 ) manager.setAngleUnit("r")
//						else if ( currentIndex == 2 ) manager.setAngleUnit("g")
					}
				}
				function setAngleUnit(unit)
				{
					if ( unit === "d" ) currentIndex = 0
					else if ( unit === "r" ) currentIndex = 1
//					else if ( unit === "g" ) currentIndex = 2
				}
			}
		}
		Rectangle
		{
			id: complexnumbersetting
			width: parent.width; height: settingheight; color: "transparent"
			anchors.top: angleunitsetting.bottom
			z: 40
			ComboBox
			{
				id: complexnumberlist
				//: Setting title
				label: qsTrId("id-complex-numbers")
				menu: ContextMenu
				{
					MenuItem { text: qsTrId("id-disabled"); height: settingheight }
					MenuItem { text: qsTrId("id-cartesian"); height: settingheight }
					MenuItem { text: qsTrId("id-polar"); height: settingheight }
				}
				onCurrentIndexChanged:
				{
					if ( initialized )
					{
						if ( currentIndex == 0 ) manager.setComplexNumber("d")
						else if ( currentIndex == 1 ) manager.setComplexNumber("c")
						else if ( currentIndex == 2 ) manager.setComplexNumber("p")
					}
					keyboard.setButtonLabels()
					historyview.updateHistory()
				}
				function setComplexNumber(complex)
				{
					if ( complex === "d" ) currentIndex = 0
					else if ( complex === "c" ) currentIndex = 1
					else if ( complex === "p" ) currentIndex = 2
				}
			}
		}
		Rectangle
		{
			property int settingsheight: settingheight * ((listfontsizemenu.active || keyboardmenu.active) ? 9 : 8)

			id: settingseparator
			width: parent.width; height: parent.height - settingsheight - statusheight; color: "transparent"
			anchors.top: complexnumbersetting.bottom
		}
		Rectangle
		{
			id: keyboardsetting
			width: parent.width; height: settingheight; color: "transparent"
			anchors.top: settingseparator.bottom
			z: 30
			ComboBox
			{
				id: keyboardlist
				visible: !isLandscape
				//: Setting title
				label: qsTrId("id-keyboard")
				menu: ContextMenu
				{
					id: keyboardmenu
					Repeater
					{
						model: { eval(manager.getKeyboards()) }
						MenuItem { text: modelData; height: settingheight }
					}
				}
				onCurrentIndexChanged:
				{
					if ( initialized )
						manager.setKeyboard(value);
					keyboard.loadButtons()
				}
				function setKeyboard(index)
				{
					currentIndex = index
					keyboard.loadButtons()
				}
			}
		}
		Rectangle
		{
			id: listfontsizesetting
			width: parent.width; height: settingheight; color: "transparent"
			anchors.top: keyboardsetting.bottom
			z: 20
			ComboBox
			{
				id: listfontsizelist
				visible: !isLandscape
				//: Setting title
				label: qsTrId("id-list-font-size")
				menu: ContextMenu
				{
					id: listfontsizemenu
					MenuItem { text: qsTrId("id-small"); height: settingheight }
					MenuItem { text: qsTrId("id-medium"); height: settingheight }
					MenuItem { text: qsTrId("id-large"); height: settingheight }
				}
				onCurrentIndexChanged:
				{
					if ( initialized )
					{
						if ( currentIndex == 0 ) { main.fontscale = 0.8; manager.setFontSize("s") }
						else if ( currentIndex == 1 ) { main.fontscale = 1.0; manager.setFontSize("m") }
						else if ( currentIndex == 2 ) { main.fontscale = 1.2; manager.setFontSize("l") }
					}
				}
				function setFontSize(size)
				{
					if ( size === "s" ) { main.fontscale = 0.8; currentIndex = 0 }
					else if ( size === "m" ) { main.fontscale = 1.0; currentIndex = 1 }
					else if ( size === "l" ) { main.fontscale = 1.2; currentIndex = 2 }
				}
			}
		}
		Rectangle
		{
			id: historysavesetting
			width: parent.width; height: settingheight; color: "transparent"
			anchors.top: listfontsizesetting.bottom
			z: 10
			TextSwitch
			{
				id: historysaveswitch
				visible: !isLandscape
				checked: true
				//: Setting title
				text: qsTrId("id-save-history-on-exit")
				onCheckedChanged: { manager.setSessionSave(checked) }
				function setHistorySave(save) { checked = save }
			}
		}
		Rectangle
		{
			id: clickinsertsetting
			width: parent.width; height: settingheight; color: "transparent"
			anchors.top: historysavesetting.bottom
			z: 10
			TextSwitch
			{
				id: clickinsertswitch
				visible: !isLandscape
				checked: true
				//: Setting title
				text: qsTrId("id-direct-insert-from-lists")
				onCheckedChanged: { oneclickinsert = checked; manager.setClickInsert(checked) }
				function setClickInsert(click) { oneclickinsert = click; checked = click }
			}
		}
		PushUpMenu
		{
			width: parent.width
			MenuItem
			{
				text: "SpeedCrunch Sailfish 0.5.1"
				onClicked: { Qt.openUrlExternally("https://openrepos.net/content/syrja/speedcrunch") }
			}
			MenuItem
			{
				text: "SpeedCrunch 0.12"
				onClicked: { Qt.openUrlExternally("http://speedcrunch.org/") }
			}
		}
		Component.onCompleted:
		{
			angleunitlist.setAngleUnit(manager.getAngleUnit())
			resultformatlist.setResultFormat(manager.getResultFormat())
			precisionlist.setPrecision(manager.getPrecision())
			complexnumberlist.setComplexNumber(manager.getComplexNumber())
			keyboardlist.setKeyboard(manager.getKeyboardIndex())
			listfontsizelist.setFontSize(manager.getFontSize())
			historysaveswitch.setHistorySave(manager.getSessionSave())
			clickinsertswitch.setClickInsert(manager.getClickInsert())
			initialized = true;
		}
	}
}
