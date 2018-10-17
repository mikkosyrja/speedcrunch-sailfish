import QtQuick 2.2
import Sailfish.Silica 1.0

Rectangle
{
	property QtObject model

	property int index: view.currentIndex
	property int startIndex: 0
	property Item indicator

	property alias spacing: view.spacing

	ListView
	{
		id: view
		anchors.fill: parent
		model: parent.model
		orientation: ListView.Horizontal
		snapMode: ListView.SnapOneItem;
		flickDeceleration: 500
		maximumFlickVelocity: parent.width * 5
		boundsBehavior: Flickable.StopAtBounds
		highlightFollowsCurrentItem: true
		highlightRangeMode: ListView.StrictlyEnforceRange
		preferredHighlightBegin: 0
		preferredHighlightEnd: 0
//		cacheBuffer: width;
		onCurrentIndexChanged: parent.indexChanged()
		Component.onCompleted: { positionViewAtIndex(startIndex, ListView.Contain) }
	}
	Timer
	{
		id: pagertimer
		interval: 250; running: false; repeat: false
		onTriggered:
		{
			for ( var index = 0; index < indicator.children.length; index++ )
				indicator.children[index].checked = false
			indicator.children[parent.index].checked = true
		}
	}
	onIndexChanged: { pagertimer.running = true }
	function goToPage(page)
	{
		view.currentIndex = page
		view.positionViewAtIndex(page, ListView.Beginning)
	}
}
