pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.services
import qs.modules.weather.objects

Scope {
    id: global
    default property Component content
    property bool enableCelestialObjs: true
    Variants {
        model: Quickshell.screens
        PanelWindow {
            id: root
            required property var modelData
            screen: modelData

            anchors { top: true; bottom: true; left: true; right: true }
            color: "transparent"

            /*Image {
                anchors.fill: parent
                source: Qt.resolvedUrl("../../assets/tinybg.png")
            }*/

            exclusionMode: ExclusionMode.Ignore
            WlrLayershell.namespace: "overviewEffect"
            WlrLayershell.layer: WlrLayer.Background

            Loader {
                active: MouseTracker.active
                sourceComponent: global.content
                visible: status == Loader.Ready
            }

            Loader {
                property Component sun: Component { Sun {} }
                property Component moon: Component { Moon {} }

                active: global.enableCelestialObjs && MouseTracker.active
                asynchronous: true; visible: status == Loader.Ready
                source: Weather.daytime ? "objects/Sun.qml" : "objects/Moon.qml"
            }
        }
    }
}
