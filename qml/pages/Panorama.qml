import QtQuick 2.2
import Sailfish.Silica 1.0
import Nemo.Notifications 1.0

Page
{
	property int statusmargin: window.height / 16
	property int buttonmargin: window.width / 50
	property int helpmargin: buttonmargin * 2

	property int fontsize: statusmargin / 2
	property int fontsizelist: fontsize * 0.8
	property int lineheight: fontsizelist * 1.5
	property int settingheight: statusmargin * 1.2

	property int resultheight: lineheight
	property int keyboardheight: (window.height === 960 ? 446 : window.height * 45 / 100)
	property int historyheight: window.height - keyboardheight - textfield.height - titlebar.height - resultheight / 2

	property int buttonwidth: (width - buttonmargin) / keyboard.buttoncolumns - buttonmargin
	property int bulletwidth: window.width / 20

	property bool needsupdate: false
	property bool oneclickinsert: false

	allowedOrientations: Orientation.Portrait
//	allowedOrientations: Orientation.All

	Rectangle
	{
		id: titlebar
		width: parent.width; height: statusmargin; color: "transparent"
		Row
		{
			id: headerindicator
			width: bulletwidth * 4; height: parent.height; spacing: bulletwidth / 2
			anchors { top: parent.top; left: parent.left; leftMargin: spacing }
			Switch { width: bulletwidth; anchors.verticalCenter: parent.verticalCenter; onClicked: screen.goToPage(0) }
			Switch { width: bulletwidth; anchors.verticalCenter: parent.verticalCenter; checked: true; onClicked: screen.goToPage(1) }
			Switch { width: bulletwidth; anchors.verticalCenter: parent.verticalCenter; onClicked: screen.goToPage(2) }
		}
		Text
		{
			width: window.width - headerindicator.width; height: parent.height; color: Theme.highlightColor
			anchors { top: parent.top; right: parent.right; rightMargin: buttonmargin }
			horizontalAlignment: Text.AlignRight
			verticalAlignment: Text.AlignVCenter
			text: "SpeedCrunch"
			font { pixelSize: Theme.fontSizeLarge; weight: Font.Bold }
		}
	}
	Pager
	{
		id: screen
		width: parent.width; height: parent.height - statusmargin; color: "transparent"
		anchors { top: titlebar.bottom; left: parent.left; right: parent.right }
		isHorizontal: true
		model: pages
		focus: true
		indicator: headerindicator
		startIndex: 1
		Timer
		{
			id: functionstimer
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
		Timer
		{
			id: historytimer
			interval: 250; running: false; repeat: false
			onTriggered: { resultsview.updateHistory() }
		}
		onIndexChanged: { functionstimer.running = true }
	}
	VisualItemModel
	{
		id: pages
		Rectangle
		{
			width: window.width; height: window.height - statusmargin; color: "transparent"
			Rectangle
			{
				id: filterrectangle
				width: parent.width; height: settingheight; color: "transparent"
				anchors.top: parent.top
				z: 10
				ComboBox
				{
					id: filterlist
					label: qsTr("Type Filter")
					menu: ContextMenu
					{
						MenuItem { text: qsTr("All") }
						MenuItem { text: qsTr("Functions") }
						MenuItem { text: qsTr("Units") }
						MenuItem { text: qsTr("Constants") }
						MenuItem { text: qsTr("User defined") }
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
				width: parent.width; height: searchfunctions.height
				anchors.top: filterrectangle.bottom
				TextField
				{
					id: searchfunctions
					anchors { top: searchrectangle.top; left: parent.left; right: clearsearch.left }
					placeholderText: qsTr("search")
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
						onClicked: { searchfunctions.text = "" }
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
				snapMode: "SnapToItem"
				clip: true
				model: { eval(manager.getFunctions(searchfunctions.text, filtertype, updatemodel)) }
				delegate: Component
				{
					ListItem
					{
						id: functionitem
						contentHeight: lineheight
						Text
						{
							id:textitem
							width: parent.width - 40; color: "white"
							anchors.centerIn: parent
							text: modelData.name
							font { pixelSize: fontsizelist; weight: (modelData.recent ? Font.Bold: Font.Light) }
						}
						RemorseItem { id: functionremorse }
						menu: Component
						{
							ContextMenu
							{
								MenuItem
								{
									text: qsTr("Insert: ") + modelData.label
									onClicked: insertitem()
								}
								MenuItem
								{
									text: qsTr("Remove from recent")
									visible: modelData.recent
									onClicked: functionremorse.execute(functionitem, qsTr("Removing"), removeRecent)
								}
								MenuItem
								{
									text: qsTr("Delete user defined")
									visible: modelData.user
									onClicked: functionremorse.execute(functionitem, qsTr("Deleting"), deleteUserDefined)
								}
							}
						}
						onClicked: { if ( oneclickinsert ) insertitem() }
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
						function insertitem()
						{
							functionlist.currentIndex = index;
							var value = modelData.value
							var text = textfield.text; var pos = textfield.cursorPosition
							textfield.text = text.substring(0, pos) + value + text.substring(pos, text.length)
							textfield.cursorPosition = pos + value.length
							if ( modelData.usage !== "" )
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
			width: window.width; height: window.height - statusmargin; color: "transparent"
			SilicaFlickable
			{
				anchors.fill: parent
				Column
				{
					anchors { fill: parent; margins: 10 }
					SilicaListView
					{
						property int updatehistory: 0
						id: resultsview
						width: parent.width; height: historyheight
						snapMode: "SnapOneItem"
						clip: true
						model: { eval(manager.getHistory(updatehistory)) }
						delegate: Component
						{
							ListItem
							{
								id: resultitem
								contentHeight: lineheight
								Text
								{
									id:textitem
									width: parent.width - 40; color: "white"
									anchors.centerIn: parent
									text: modelData.expression + " = " + modelData.value
									font { pixelSize: fontsizelist; weight: (resultsview.currentItem == resultitem  ? Font.Bold: Font.Light) }
								}
								RemorseItem { id: historyremorse }
								menu: Component
								{
									ContextMenu
									{
										MenuItem
										{
											text: qsTr("Insert: ") + modelData.value
											onClicked: insertitem()
										}
										MenuItem
										{
											text: qsTr("Edit: ") + modelData.expression
											onClicked: { textfield.text = modelData.expression }
										}
										MenuItem
										{
											text: qsTr("Remove from history")
											onClicked: historyremorse.execute(resultitem, qsTr("Removing"), removeHistory)
										}
									}
								}
								onClicked: { if ( oneclickinsert ) insertitem() }
								function removeHistory()
								{
									manager.clearHistory(index)
									historytimer.running = true
								}
								function insertitem()
								{
									var text = textfield.text; var pos = textfield.cursorPosition
									textfield.text = text.substring(0, pos) + modelData.value + text.substring(pos, text.length)
									textfield.cursorPosition = pos + modelData.value.length
								}
							}
						}
						function updateHistory()
						{
							updatehistory++
							currentIndex = count - 1
							positionViewAtEnd()
/*
							if ( count )
							{
								window.latestExpression = "foo"
//								window.latestResult = resultitem.modelData.value
							}
*/
						}
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
							placeholderText: qsTr("expression")
							softwareInputPanelEnabled: false
							Keys.onReturnPressed:
							{
								textfield.softwareInputPanelEnabled = false
								textfield.forceActiveFocus()
							}
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
									label = "= " + result
								else
									label = manager.getError()
							}
						}
						Image
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
						Button
						{
							id: evaluatebutton
							width: buttonwidth; color: Theme.highlightColor
							anchors { top: textfield.top; topMargin: buttonmargin; right: parent.right }
							text: "="
							onClicked: { evaluate() }
						}
					}
					Keyboard
					{
						id: keyboard
						width: parent.width; height: keyboardheight - statusmargin; spacing: buttonmargin; color: "transparent"
						anchors.top: textfield.bottom
						indicator: footerindicator
					}
				}
				Item
				{
					id: statusbar
					width: parent.width; height: statusmargin
					anchors { bottom: parent.bottom; left: parent.left }
					Row
					{
						id: footerindicator
						width: buttonwidth * 2 + buttonmargin; height: statusmargin; spacing: bulletwidth / 2
						anchors { bottom: parent.bottom; left: parent.left; leftMargin: spacing }
						Switch { width: bulletwidth; anchors.verticalCenter: parent.verticalCenter; onClicked: keyboard.goToPage(0) }
						Switch { width: bulletwidth; anchors.verticalCenter: parent.verticalCenter; onClicked: keyboard.goToPage(1) }
					}
					Label
					{
						id: resultformat
						width: buttonwidth * 2 + buttonmargin; height: statusmargin; color: Theme.highlightColor
						anchors { bottom: parent.bottom; left: footerindicator.right; leftMargin: buttonmargin }
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
					MenuItem { text: qsTr("Copy result"); onClicked: manager.setClipboard(window.latestResult) }
					MenuItem { text: qsTr("Copy expression"); onClicked: manager.setClipboard(window.latestExpression + " = " + window.latestResult) }
					MenuItem
					{
						text: qsTr("Paste")
						onClicked:
						{
							var text = textfield.text; var pos = textfield.cursorPosition
							textfield.text = text.substring(0, pos) + manager.getClipboard() + text.substring(pos, text.length)
							textfield.cursorPosition = pos + value.length
						}
					}
					MenuItem
					{
						text: qsTr("Clear history")
						onClicked: { manager.clearHistory(-1); resultsview.updateHistory() }
					}
				}
			}
		}
		Rectangle
		{
			width: window.width; height: window.height - statusmargin; color: "transparent"
			Column
			{
				anchors.fill: parent
				Settings
				{
					id: settings
					width: parent.width; height: settingheight * 7; color: "transparent"
					anchors.top: parent.top
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
						text: "Tap on the expression twice to edit it with the virtual\nkeyboard."
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
		id: notification;
		category: "SpeedCrunch"
	}
	Component.onCompleted:
	{
		textfield.softwareInputPanelEnabled = false
		textfield.forceActiveFocus()
		historytimer.running = true
	}
	Component.onDestruction: { manager.saveSession(); }
	function evaluate()
	{
		if ( textfield.text != "" )
		{
			var result = manager.calculate(textfield.text)
			if ( result === "NaN" )
			{
				var error = manager.getError()
				if ( error.length )
				{
					notification.previewSummary = qsTr("Evaluation error")
					notification.previewBody = error
					notification.publish()
				}
			}
			else
			{
				var assign = manager.getAssignId()
				if ( assign.length )
				{
					functionlist.updatemodel++
					window.latestExpression = manager.autoFix(textfield.text)
					window.latestResult = ""
					resultsview.updateHistory()
					notification.previewSummary = qsTr("Function added")
					notification.previewBody = ""
					notification.publish()
				}
				else
				{
					window.latestExpression = manager.autoFix(textfield.text)
					window.latestResult = result
					resultsview.updateHistory()
				}
				textfield.text = ""
			}
		}
	}
}
