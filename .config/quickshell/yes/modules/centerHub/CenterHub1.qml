import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.modules.common
import qs.services


Item {
    id: root
    visible: true
    required property var anchorWindow

    signal finished()

    PanelWindow {
        visible: root.visible
        WlrLayershell.layer: WlrLayer.Overlay
        exclusionMode: ExclusionMode.Ignore

        anchors {top: true; bottom: true; left: true; right: true}
        color: "transparent"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.visible = false
                root.finished()
            }
        }
    }

    PopupWindow {
        implicitWidth: 500; implicitHeight: 300
        visible: root.visible; color: "transparent"

        anchor {
            window: root.anchorWindow
            rect.x: root.anchorWindow.width / 2 - implicitWidth / 2
            rect.y: root.anchorWindow.height + 12 // standardize
        }

        Rectangle {
            id: bg
            anchors.fill: parent
            color: Appearance.everforest.bg2
            radius: 12 // standardize
        }
    }
}

