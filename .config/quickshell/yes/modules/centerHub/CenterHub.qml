import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.modules.common
import qs


Item {
    id: root
    required property var anchorWindow

    property bool open
    Component.onCompleted: open = true
    onOpenChanged: { GlobalStates.centerHubOpen = root.open; anim.restart() }

    signal finished(destroy: bool)

    PanelWindow {
        exclusionMode: ExclusionMode.Ignore
        anchors {top: true; bottom: true; left: true; right: true}
        color: "transparent"
        MouseArea {
            anchors.fill: parent
            onClicked: root.open = false
        }
    }

    PopupWindow {
        implicitWidth: 500; implicitHeight: 300
        visible: root.visible; color: "transparent"
        //WlrLayershell.layer: WlrLayer.Overlay // breaks it for some reason

        anchor {
            window: root.anchorWindow
            rect.x: root.anchorWindow.width / 2 - width / 2
            rect.y: root.anchorWindow.height + 12 // TODO: standardize
        }

        Rectangle {
            id: popup
            anchors.fill: parent
            color: Appearance.everforest.bg2
            radius: 12 // standardize
            opacity: 0

            SequentialAnimation {
                id: anim
                NumberAnimation {
                    target: popup; property: "opacity";
                    to: root.open ? 1 : 0; duration: 75 // standardize
                }
                ScriptAction { script: root.finished(!popup.opacity) }
            }

        }
    }
}

