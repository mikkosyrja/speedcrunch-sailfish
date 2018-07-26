import QtQuick 2.2
import Sailfish.Silica 1.0
import Nemo.Notifications 1.0

Page
{
	property int statusmargin: window.height / 16
	property int buttonmargin: window.width / 50
	property int helpmargin: buttonmargin * 2

//	property int fontsizebig: statusmargin * 2 / 3
	property int fontsizesmall: statusmargin / 2
	property int fontsizetiny: statusmargin / 3
	property int lineheight: fontsizesmall * 1.5
	property int settingheight: statusmargin * 1.3

	property int resultheight: lineheight
	property int keyboardheight: (window.height == 960 ? 446 : window.height * 45 / 100)
	property int historyheight: window.height - keyboardheight - textfield.height - statusmargin - resultheight

	property int buttonwidth: (width - buttonmargin) / keyboard.buttoncolumns - buttonmargin
	property int bulletwidth: window.width / 20

	property bool needsupdate: false

	allowedOrientations: Orientation.Portrait

	Row
	{
		id: header
		height: statusmargin; spacing: bulletwidth / 2
		anchors { top: parent.top; left: parent.left; leftMargin: spacing }
		z: 10
		Switch { width: bulletwidth; anchors.verticalCenter: parent.verticalCenter; onClicked: screen.goToPage(0) }
		Switch { width: bulletwidth; anchors.verticalCenter: parent.verticalCenter; checked: true; onClicked: screen.goToPage(1) }
		Switch { width: bulletwidth; anchors.verticalCenter: parent.verticalCenter; onClicked: screen.goToPage(2) }
	}
	Pager
	{
		id: screen
		color: "transparent"
		anchors.fill: parent
		isHorizontal: true
		model: pages
		enableKeys: true
		focus: true
		indicator: header
		startIndex: 1
//		interactive: false
//		pressDelay: 200

		Timer
		{
			id: screentimer
			interval: 250; running: false; repeat: false
			onTriggered:
			{
				if ( screen.index == 0 )
				{
					if ( needsupdate )
						functionlist.updatemodel++
					needsupdate = false
				}
				else if ( screen.index == 1 )
				{
					textfield.softwareInputPanelEnabled = false
					textfield.forceActiveFocus()
				}
			}
		}

		onIndexChanged: { screentimer.running = true }
	}

	VisualItemModel
	{
		id: pages
		Rectangle
		{
			width: window.width; height: window.height; color: "transparent"
			Rectangle
			{
				id: header1
				width: parent.width; height: statusmargin; color: "transparent"
				Text
				{
					color: Theme.highlightColor
					anchors { right: parent.right; rightMargin: bulletwidth / 2 }
					anchors.verticalCenter: parent.verticalCenter
					text: "Functions"
					font.pixelSize: Theme.fontSizeLarge
				}
			}
			Rectangle
			{
				id: filterrectangle
				width: parent.width; height: settingheight; color: "transparent"
				anchors { top: header1.bottom; }
				z: 10
				ComboBox
				{
					id: filterlist
					label: "Filter"
					menu: ContextMenu
					{
						MenuItem { text: "All" }
						MenuItem { text: "Functions" }
						MenuItem { text: "Units" }
						MenuItem { text: "Constants" }
						MenuItem { text: "User defined" }
					}
					onCurrentIndexChanged:
					{
						if ( currentIndex == 0 ) { functionlist.filtertype = "a" }
						else if ( currentIndex == 1 ) { functionlist.filtertype = "f" }
						else if ( currentIndex == 2 ) { functionlist.filtertype = "u" }
						else if ( currentIndex == 3 ) { functionlist.filtertype = "c" }
						else if ( currentIndex == 4 ) { functionlist.filtertype = "v" }
					}
				}
			}
			Item
			{
				id: searchrectangle
				width: parent.width; height: searchfunctions.height;
				anchors { top: filterrectangle.bottom; }
				TextField
				{
					id: searchfunctions
					anchors { top: searchrectangle.top; left: parent.left; right: clearsearch.left }
					placeholderText: "search"
					inputMethodHints: Qt.ImhNoPredictiveText | Qt.ImhNoAutoUppercase;
				}
				Image	// clear button
				{
					id: clearsearch
					width: buttonwidth / 3; height: buttonwidth / 3
					anchors { top: searchrectangle.top; right: parent.right; rightMargin: buttonmargin * 2 }
					anchors.verticalCenter: searchfunctions.verticalCenter
					fillMode: Image.PreserveAspectFit
					smooth: true;
					visible: searchfunctions.text
					source: "clear.png"
					MouseArea
					{
						id: clearsearcharea
						anchors { fill: parent; margins: -10 }
						onClicked: { searchfunctions.text = ""; }
					}
				}
			}
			SilicaListView
			{
				property string filtertype: "a"
				property int updatemodel: 0
				id: functionlist
				width: parent.width
				anchors { top: searchrectangle.bottom; bottom: parent.bottom }
				clip: true
				model: { eval(manager.getFunctions(searchfunctions.text, filtertype, updatemodel)) }
				delegate: Component
				{
					ListItem
					{
						id: functionitem
						contentHeight: lineheight
						RemorseItem { id: remorse }
						menu: Component
						{
							ContextMenu
							{
								MenuItem { text: modelData.label; onClicked: insert() }
								MenuItem
								{
									text: "Remove from recent"
									visible: modelData.recent
									onClicked: remorse.execute(functionitem, "Removing", removeRecent)
								}
								MenuItem
								{
									text: "Delete user defined"
									visible: modelData.user
									onClicked: remorse.execute(functionitem, "Deleting", deleteUserDefined)
								}
							}
						}
						onClicked: insert()
						Text
						{
							id:textitem
							width: parent.width - 40; color: "white"
							anchors.centerIn: parent
							text: modelData.name
							font { pixelSize: fontsizesmall; weight: (modelData.recent ? Font.Bold: Font.Light) }
						}
						function removeRecent()
						{
							manager.removeRecent(modelData.name)
							functionlist.updatemodel++
						}
						function deleteUserDefined()
						{
							manager.clearFunction(modelData.value)
							manager.clearVariable(modelData.value)
							functionlist.updatemodel++
						}
						function insert()
						{
							functionlist.currentIndex = index;
							var value = modelData.value
							var text = textfield.text
							var pos = textfield.cursorPosition
							textfield.text = text.substring(0, pos) + value + text.substring(pos, text.length)
							textfield.cursorPosition = pos + value.length
							if ( modelData.usage != "" )
							{
								textfield.label = modelData.usage
								textfield.cursorPosition--
							}
							if ( manager.updateRecent(modelData.name) )
								needsupdate = true
							screen.goToPage(1)
							mouse.accepted = true;
						}
					}
				}
			}
		}
		Rectangle
		{
			width: window.width; height: window.height; color: "transparent"
			SilicaFlickable
			{
				width: window.width; height: window.height
				Column
				{
					anchors { fill: parent; margins: 10 }
					Rectangle
					{
						id: header2
						width: parent.width; height: statusmargin; color: "transparent"
						Text
						{
							color: Theme.highlightColor
							anchors { right: parent.right; rightMargin: bulletwidth / 2 }
							anchors.verticalCenter: parent.verticalCenter
							text: "SpeedCrunch"
							font.pixelSize: Theme.fontSizeLarge
						}
					}
					Item { width: parent.width; height: resultheight / 2 }
					Rectangle
					{
						width: parent.width; height: historyheight; color: "transparent"
						SilicaListView
						{
							property int updatehistory: 0
							id: resultsview
							width: parent.width; height: parent.height
							snapMode: "SnapOneItem"
							clip: true
							model: { eval(manager.getHistory(updatehistory)) }
							delegate: Component
							{
								ListItem
								{
									id: resultitem
									contentHeight: lineheight
									onClicked: insert()
									Text
									{
										id:textitem
										width: parent.width - 40; color: "white"
										anchors.centerIn: parent
										text: modelData.expression + " = " + modelData.value
										font { pixelSize: fontsizesmall; weight: (parent.isCurrentItem ? Font.Bold: Font.Light) }
									}
									function insert()
									{
										var text = textfield.text
										var pos = textfield.cursorPosition
										textfield.text = text.substring(0, pos) + modelData.value + text.substring(pos, text.length)
										textfield.cursorPosition = pos + modelData.value.length
									}
									onPressAndHold: { textfield.text = modelData.expression }
								}
							}
							function updateHistory()
							{
								resultsview.updatehistory++
								resultsview.positionViewAtEnd()
								resultsview.currentIndex = resultsview.count - 1
							}
						}
						ScrollDecorator { flickable: resultsview }
					}
					Item { width: parent.width; height: resultheight / 2 }
					Item
					{
						width: parent.width; height: textfield.height
						TextField
						{
							id: textfield
							anchors { left: parent.left; right: cleartext.left }
							inputMethodHints: Qt.ImhNoPredictiveText | Qt.ImhNoAutoUppercase;
							placeholderText: "expression"
							softwareInputPanelEnabled: false
							Keys.onReturnPressed: { evaluate(); }
							onClicked:
							{
								textfield.softwareInputPanelEnabled = true
								textfield.forceActiveFocus()
							}
							onFocusChanged:
							{
								if ( textfield.softwareInputPanelEnabled )
								{
									textfield.softwareInputPanelEnabled = false
									textfield.forceActiveFocus()
								}
							}
							onTextChanged:
							{
								var result = manager.autoCalc(text);
								if ( manager.autoCalc(text) !== "NaN" )
									label = "=" + result
								else
									label = manager.getError()
							}
						}
						Image	// clear button
						{
							id: cleartext
							width: buttonwidth / 3; height: buttonwidth / 3
							anchors { right: evaluatebutton.left; rightMargin: buttonmargin * 2 }
							anchors.verticalCenter: evaluatebutton.verticalCenter
							fillMode: Image.PreserveAspectFit
							smooth: true;
							visible: textfield.text
							source: "clear.png"
							MouseArea
							{
								id: cleararea
								anchors { fill: parent; margins: -10 }
								onClicked: { textfield.text = ""; textfield.forceActiveFocus() }
							}
						}
						Button	// evaluate button
						{
							id: evaluatebutton
							width: buttonwidth; color: Theme.highlightColor
							anchors { top: textfield.top; topMargin: buttonmargin; right: parent.right }
							text: "="
							onClicked: { evaluate(); }
						}
					}
					Keyboard
					{
						id: keyboard
						width: parent.width; height: keyboardheight - statusmargin; spacing: buttonmargin; color: "transparent"
						anchors.top: textfield.bottom
						indicator: footer
					}
				}
				Item
				{
					id: statusbar
					width: parent.width; height: statusmargin
					anchors { bottom: parent.bottom; left: parent.left }
					Row
					{
						id: footer
						width: buttonwidth * 2 + buttonmargin; height: statusmargin; spacing: bulletwidth / 2
						anchors { bottom: parent.bottom; left: parent.left; leftMargin: spacing }
						Switch { width: bulletwidth; anchors.verticalCenter: parent.verticalCenter; onClicked: keyboard.goToPage(0) }
						Switch { width: bulletwidth; anchors.verticalCenter: parent.verticalCenter; onClicked: keyboard.goToPage(1) }
					}
					Label
					{
						id: resultformat
						width: buttonwidth * 2 + buttonmargin; height: statusmargin; color: Theme.highlightColor
						anchors { bottom: parent.bottom; left: footer.right; leftMargin: buttonmargin }
						verticalAlignment: Text.AlignVCenter
						font.pixelSize: Theme.fontSizeExtraSmall
						text: settings.resultformat
					}
					Label
					{
						id: angleunit
						width: buttonwidth; height: statusmargin; color: Theme.highlightColor
						anchors { bottom: parent.bottom; right: parent.right; rightMargin: buttonmargin }
						verticalAlignment: Text.AlignVCenter
						font.pixelSize: Theme.fontSizeExtraSmall
						text: settings.angleunit
					}
				}
				PushUpMenu
				{
					MenuItem { text: "Copy result"; onClicked: manager.setClipboard(window.latestResult) }
					MenuItem { text: "Copy expression"; onClicked: manager.setClipboard(window.latestExpression + " = " + window.latestResult) }
					MenuItem
					{
						text: "Paste"
						onClicked:
						{
							var text = textfield.text; var pos = textfield.cursorPosition
							textfield.text = text.substring(0, pos) + manager.getClipboard() + text.substring(pos, text.length)
							textfield.cursorPosition = pos + value.length
						}
					}
					MenuItem
					{
						text: "Clear history"
						onClicked: { manager.clearHistory(); resultsview.updateHistory() }
					}
				}
			}
		}
		Rectangle
		{
			width: window.width; height: window.height; color: "transparent"
			Column
			{
				anchors.fill: parent
				Rectangle
				{
					id: header3
					width: parent.width; height: statusmargin; color: "transparent"
					anchors.top: parent.top
					Text
					{
						anchors { right: parent.right; rightMargin: bulletwidth / 2 }
						anchors.verticalCenter: parent.verticalCenter
						text: "Settings"
						font.pixelSize: Theme.fontSizeLarge
						color: Theme.highlightColor
					}
				}
				Settings
				{
					id: settings
					width: parent.width; height: settingheight * 5; color: "transparent"
					anchors.top: header3.bottom
				}
				Text
				{
					id: helptitle
					width: parent.width; color: "white"
					anchors { top: settings.bottom; left: parent.left; leftMargin: helpmargin }
					text: "Tips:"
					font.pixelSize: Theme.fontSizeSmall
				}
				Column
				{
					spacing: buttonmargin
					anchors { top: helptitle.bottom; topMargin: 20 }
					Text
					{
						width: parent.width - (helpmargin * 3); color: "white"
						anchors.horizontalCenter: parent.horizontalCenter
						text: "Swipe left/right on the keypad for more functions."
						font.pixelSize: Theme.fontSizeExtraSmall; wrapMode: Text.WordWrap
					}
					Text
					{
						width: parent.width - (helpmargin * 3); color: "white"
						anchors.horizontalCenter: parent.horizontalCenter
						text: "Tap on the expression twice to edit it with the full\nkeyboard, for advanced formulas."
						font.pixelSize: Theme.fontSizeExtraSmall; wrapMode: Text.WordWrap
					}
					Text
					{
						width: parent.width - (helpmargin * 3); color: "white"
						anchors.horizontalCenter: parent.horizontalCenter
						text: "Tap on any line on the history to insert result value\nto the running expression."
						font.pixelSize: Theme.fontSizeExtraSmall; wrapMode: Text.WordWrap
					}
					Text
					{
						width: parent.width - (helpmargin * 3); color: "white"
						anchors.horizontalCenter: parent.horizontalCenter
						text: "Tap and hold on any line on the history to replace\nthe running expression with it."
						font.pixelSize: Theme.fontSizeExtraSmall; wrapMode: Text.WordWrap
					}
					Text
					{
						width: parent.width - (helpmargin * 3); color: "white"
						anchors.horizontalCenter: parent.horizontalCenter
						text: "Tap and hold on buttons 1-6 to insert hexadecimal\nletters A-F. Tap and hold on 0x to insert 0b."
						font.pixelSize: Theme.fontSizeExtraSmall; wrapMode: Text.WordWrap
					}
				}
			}
		}
	}

	Notification
	{
		id: notification
		category: "x-jolla.store.error"
	}

	Component.onCompleted:
	{
		textfield.softwareInputPanelEnabled = false
		textfield.forceActiveFocus()
		resultsview.updateHistory()
	}

	Component.onDestruction: { manager.saveSession(); }

	function evaluate()
	{
		if ( textfield.text != "" )
		{
			window.latestExpression = manager.autoFix(textfield.text)
			window.latestResult = manager.calculate(textfield.text)
			if ( window.latestResult == "NaN" )
			{
				notification.previewSummary = "Evaluation"
				notification.previewBody = manager.getError()
				notification.publish()
			}
			resultsview.updateHistory()
			functionlist.updatemodel++
			textfield.text = ""
		}
	}
}
