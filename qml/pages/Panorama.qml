import QtQuick 2.2
import Sailfish.Silica 1.0
import Nemo.Notifications 1.0

Page
{
	property int titleheight: Screen.height / 16
	property int statusheight: Screen.height / 16
	property int buttonmargin: Screen.width / 50

	property real fontsize: titleheight / 2
	property real fontscale: 1.0
	property real fontsizelist: fontsize * fontscale
	property real lineheight: fontsizelist * 1.5

	property int settingheight: titleheight * (isLandscape ? 1.0 : 1.2)
	property int resultheight: lineheight
	property int keyboardheight: (keyboard.buttonheight + buttonmargin) * keyboard.buttonrows
	property int historyheight: wholeHeight - keyboardheight - textrow.height - (isLandscape ? buttonmargin : statusheight) - titleheight

	property int buttonwidth: (width - buttonmargin) / keyboard.buttoncolumns - buttonmargin
	property int bulletwidth: Screen.width / 20

	property bool needsupdate: false
	property bool oneclickinsert: false

	property int wholeHeight: (isLandscape ? Screen.width : Screen.height)	// with virtual keyboard

	onOrientationChanged: { historytimer.running = true }

	id: main
	width: isLandscape ? Screen.height : Screen.width
	height: isLandscape ? Screen.width : Screen.height
	allowedOrientations: Orientation.All

	Rectangle
	{
		id: titlebar
		width: parent.width; height: titleheight; color: "transparent"
		Row
		{
			id: headerindicator
			width: (buttonwidth + buttonmargin) * 2; height: parent.height; spacing: bulletwidth / 2
			anchors { top: parent.top; left: parent.left; leftMargin: spacing }
			Switch { width: bulletwidth; anchors.verticalCenter: parent.verticalCenter; onClicked: screen.goToPage(0) }
			Switch { width: bulletwidth; anchors.verticalCenter: parent.verticalCenter; checked: true; onClicked: screen.goToPage(1) }
			Switch { width: bulletwidth; anchors.verticalCenter: parent.verticalCenter; onClicked: screen.goToPage(2) }
		}
		Label
		{
			id: titleresultformat
			width: (isLandscape ? (buttonwidth + buttonmargin) * 3 : 0); height: parent.height; color: Theme.highlightColor
			anchors { bottom: parent.bottom; left: headerindicator.right; leftMargin: buttonmargin }
			verticalAlignment: Text.AlignVCenter
			font.pixelSize: Theme.fontSizeExtraSmall
			text: settings.resultformat
			visible: isLandscape
		}
		Label
		{
			id: titleangleunit
			width: (isLandscape ? buttonwidth : 0); height: parent.height; color: Theme.highlightColor
			anchors { bottom: parent.bottom; left: titleresultformat.right; rightMargin: buttonmargin }
			verticalAlignment: Text.AlignVCenter
			font.pixelSize: Theme.fontSizeExtraSmall
			text: settings.angleunit
			visible: isLandscape
		}
		Text
		{
			width: parent.width - headerindicator.width - titleresultformat.width - titleangleunit.width
			height: parent.height; color: Theme.highlightColor
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
		width: parent.width; height: parent.height - titleheight; color: "transparent"
		anchors { top: titlebar.bottom; left: parent.left; right: parent.right }
		model: pages
		startIndex: 1
		indicator: headerindicator
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
			onTriggered: { historyview.updateHistory() }
		}
		onIndexChanged: { functionstimer.running = true }
	}
	VisualItemModel
	{
		id: pages
		Rectangle	// functions page
		{
			width: main.width; height: main.height - titleheight; color: "transparent"
			Rectangle
			{
				id: filterrectangle
				width: parent.width; height: settingheight; color: "transparent"
				z: 200
				anchors.top: parent.top
				ComboBox
				{
					id: filterlist
					//: Setting title
					label: qsTrId("id-type-filter")
					menu: ContextMenu
					{
						MenuItem { text: qsTrId("id-all"); height: settingheight }
						MenuItem { text: qsTrId("id-functions"); height: settingheight }
						MenuItem { text: qsTrId("id-units"); height: settingheight }
						MenuItem { text: qsTrId("id-constants"); height: settingheight }
						MenuItem { text: qsTrId("id-user-defined"); height: settingheight }
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
					//: Placeholder
					placeholderText: qsTrId("id-search")
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
					source: Theme.colorScheme ?  "clear-light.png" : "clear-dark.png"
					MouseArea
					{
						id: clearsearcharea
						anchors { fill: parent; margins: -buttonmargin }
						onClicked: { searchfunctions.text = "" }
					}
				}
			}
			SilicaListView		// functions
			{
				property string filtertype: "a"
				property int updatemodel: 0
				id: functionlist
				width: parent.width
				anchors { top: searchrectangle.bottom; bottom: parent.bottom }
				z: 100	// for remorse
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
							width: parent.width - 40; color: Theme.primaryColor
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
									height: settingheight
									//: Popup menu item
									text: qsTrId("id-insert-item") + " " + modelData.label
									onClicked: insertitem()
								}
								MenuItem
								{
									height: settingheight
									//: Popup menu item
									text: qsTrId("id-remove-from-recent")
									visible: modelData.recent
									onClicked: functionremorse.execute(functionitem, qsTrId("id-removing"), removeRecent)
								}
								MenuItem
								{
									height: settingheight
									//: Popup menu item
									text: qsTrId("id-delete-user-defined")
									visible: modelData.user
									onClicked: functionremorse.execute(functionitem, qsTrId("id-deleting"), deleteUserDefined)
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
		Rectangle	// calculator page
		{
			width: main.width; height: main.height - titleheight; color: "transparent"
			SilicaFlickable		// for pull-up
			{
				anchors.fill: parent
				SilicaListView		// history
				{
					property int updatehistory: 0
					id: historyview
					width: parent.width; height: historyheight / (textfield.activekeyboard ? 2 : 1)
					anchors { top: parent.top; leftMargin: 10; rightMargin: 10; topMargin: 10 }
					z: 100	// for remorse
					snapMode: "SnapToItem"
					clip: true
					model: { eval(manager.getHistory(updatehistory)) }
					delegate: Component
					{
						ListItem
						{
							id: historyitem
							contentHeight: lineheight
							Text
							{
								id:textitem
								width: parent.width - 40; color: Theme.primaryColor
								anchors.centerIn: parent
								text: modelData.expression + " = " + modelData.value
								font { pixelSize: fontsizelist; weight: (historyview.currentItem == historyitem  ? Font.Bold: Font.Light) }
							}
							RemorseItem { id: historyremorse }
							menu: Component
							{
								ContextMenu
								{
									MenuItem
									{
										height: settingheight
										//: Popup menu item
										text: qsTrId("id-insert-item") + " " + modelData.value
										onClicked: insertitem()
									}
									MenuItem
									{
										height: settingheight
										//: Popup menu item
										text: qsTrId("id-edit-item") + " " + modelData.expression
										onClicked:
										{
											historyview.clip = true
											textfield.text = modelData.expression
										}
									}
									MenuItem
									{
										height: settingheight
										//: Popup menu item
										text: qsTrId("id-remove-from-history")
										onClicked:
										{
											historyview.clip = true
											historyremorse.execute(historyitem, qsTrId("id-removing"), removeHistory)
										}
									}
									onClosed: { historyview.clip = true }
								}
							}
							onPressAndHold: { historyview.clip = false }	// for popup
							onClicked:
							{
								if ( oneclickinsert )
									insertitem()
							}
							function removeHistory()
							{
								manager.clearHistory(index)
								historytimer.running = true
							}
							function insertitem()
							{
								historyview.clip = true
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
//							window.latestResult = historyitem.modelData.value
						}
*/
					}
				}
				Rectangle
				{
					id: textrow
					width: parent.width; height: textfield.height; color: "transparent"
					anchors { top: historyview.bottom }
					TextField
					{
						property bool activekeyboard: isLandscape && focus && softwareInputPanelEnabled && !activatekeyboard
						property bool activatekeyboard: false
						id: textfield
						anchors { left: parent.left; right: cleartext.left }
						inputMethodHints: Qt.ImhNoPredictiveText | Qt.ImhNoAutoUppercase;
						//: Placeholder
						placeholderText: qsTrId("id-expression")
						softwareInputPanelEnabled: false
						Keys.onReturnPressed:
						{
							textfield.softwareInputPanelEnabled = false
							textfield.forceActiveFocus()
						}
						onClicked:
						{
							activatekeyboard = !softwareInputPanelEnabled
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
						fillMode: Image.PreserveAspectFit; smooth: true;
						visible: textfield.text
						source: Theme.colorScheme ?  "clear-light.png" : "clear-dark.png"
						MouseArea
						{
							id: cleararea
							anchors { fill: parent; margins: -buttonmargin }
							onPressed: { screen.interactive = false; keyboard.interactive = false }
							onReleased: { screen.interactive = true; keyboard.interactive = true }
							onExited: { screen.interactive = true; keyboard.interactive = true }
							onCanceled: { screen.interactive = true; keyboard.interactive = true }
							onClicked: { textfield.text = ""; textfield.forceActiveFocus() }
						}
					}
					CalcButton
					{
						id: evaluatebutton
						width: buttonwidth; color: Theme.highlightColor
						anchors { top: textfield.top; margins: buttonmargin; right: parent.right }
						text: "="; special: true; secondary: "ans"
						onRunFunction: evaluate()
					}
				}
				Rectangle
				{
					property int buttonheight: isLandscape ? landscapekeyboard.buttonheight : portraitkeyboard.buttonheight
					property int buttonrows: isLandscape ? landscapekeyboard.buttonrows : portraitkeyboard.buttonrows
					property int buttoncolumns: isLandscape ? landscapekeyboard.buttoncolumns : portraitkeyboard.buttoncolumns
					property alias interactive: portraitkeyboard.interactive

					id: keyboard
					width: parent.width; height: keyboardheight; color: "transparent"
					anchors.top: textrow.bottom
					Keyboard
					{
						id: portraitkeyboard
						visible: !isLandscape
						buttonspacing: buttonmargin
						indicator: footerindicator
					}
					Landscape
					{
						id: landscapekeyboard
						visible: isLandscape
						buttonspacing: buttonmargin
					}
					function setButtonLabels()
					{
						portraitkeyboard.setButtonLabels()
						landscapekeyboard.setButtonLabels()
					}
					function goToPage(page)
					{
						if ( !isLandscape )
							portraitkeyboard.goToPage(page)
					}
				}
				Item
				{
					id: statusbar
					width: parent.width; height: statusheight
					anchors { top: keyboard.bottom; left: parent.left }
					visible: !isLandscape
					Row
					{
						id: footerindicator
						width: buttonwidth * 2 + buttonmargin; height: parent.height; spacing: bulletwidth / 2
						anchors { top: parent.top; left: parent.left; leftMargin: spacing }
						Switch { width: bulletwidth; anchors.verticalCenter: parent.verticalCenter; onClicked: keyboard.goToPage(0) }
						Switch { width: bulletwidth; anchors.verticalCenter: parent.verticalCenter; onClicked: keyboard.goToPage(1) }
					}
					Label
					{
						id: resultformat
						width: buttonwidth * 2 + buttonmargin; height: parent.height; color: Theme.highlightColor
						anchors { bottom: parent.bottom; left: footerindicator.right; leftMargin: buttonmargin }
						verticalAlignment: Text.AlignVCenter
						font.pixelSize: Theme.fontSizeExtraSmall
						text: settings.resultformat
					}
					Label
					{
						id: angleunit
						width: buttonwidth; height: parent.height; color: Theme.highlightColor
						anchors { bottom: parent.bottom; right: parent.right; rightMargin: buttonmargin }
						verticalAlignment: Text.AlignVCenter
						font.pixelSize: Theme.fontSizeExtraSmall
						text: settings.angleunit
					}
				}
				PushUpMenu
				{
					width: parent.width
					//: Menu item
					MenuItem { text: qsTrId("id-copy-result"); onClicked: manager.setClipboard(window.latestResult) }
					//: Menu item
					MenuItem { text: qsTrId("id-copy-expression"); onClicked: manager.setClipboard(window.latestExpression + " = " + window.latestResult) }
					MenuItem
					{
						//: Menu item
						text: qsTrId("id-paste")
						onClicked:
						{
							var text = textfield.text; var pos = textfield.cursorPosition
							textfield.text = text.substring(0, pos) + manager.getClipboard() + text.substring(pos, text.length)
							textfield.cursorPosition = pos + value.length
						}
					}
					MenuItem
					{
						//: Menu item
						text: qsTrId("id-clear-history")
						onClicked: { manager.clearHistory(-1); historyview.updateHistory() }
					}
				}
			}
		}
		Rectangle	// settings page
		{
			width: main.width; height: main.height - titleheight; color: "transparent"
			Settings
			{
				id: settings
				anchors.fill: parent; color: "transparent"
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
					//: Notification message
					notification.previewSummary = qsTrId("id-evaluation-error")
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
					historyview.updateHistory()
					//: Notification message
					notification.previewSummary = qsTrId("id-function-added")
					notification.previewBody = ""
					notification.publish()
				}
				else
				{
					window.latestExpression = manager.autoFix(textfield.text)
					window.latestResult = result
					historyview.updateHistory()
				}
				textfield.text = ""
			}
		}
	}
}
