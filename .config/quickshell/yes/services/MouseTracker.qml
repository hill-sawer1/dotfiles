pragma Singleton

import QtQuick
import Quickshell
import qs.modules.common.functions

PanelWindow {
    id: root
    property bool active: false
    property point cursor
    property bool zip: false

    anchors { top: true; bottom: true; left: true; right: true }
    color: "transparent"
    visible: false

    Connections {
        target: Niri
        function onOverviewStateChanged() {
            MouseTracker.visible = Niri.overviewState
            MouseTracker.active = false
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onPositionChanged: root.cursor = mapToGlobal(mouseX, mouseY)
        onClicked: {
            root.visible = false
            Ydotool.click()
            Qt.callLater(() => {
                root.visible = Niri.overviewState
                root.active = !root.active && Niri.overviewState
            })
        }
        onExited: root.zip = true
        onEntered: zipDelay.start()
    }

    Timer {
        id: zipDelay
        interval: 350 //TODO: centralize
        onTriggered: root.zip = false
    }
}
