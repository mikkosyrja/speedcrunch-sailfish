import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"
import harbour.speedcrunch.Manager 1.0

ApplicationWindow
{
	property string latestExpression: ""
	property string latestResult: ""

	id: window

	initialPage: Qt.resolvedUrl("pages/Panorama.qml")
	cover: Qt.resolvedUrl("cover/CoverPage.qml")

	allowedOrientations: Orientation.All

	Manager { id: manager }
}
