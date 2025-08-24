import QtQuick
import Quickshell
import QtQuick.Effects
import Quickshell.Wayland
import qs.services
import qs.modules.common

Scope {
    Variants {
        model: Quickshell.screens
        PanelWindow {
            id: root
            required property var modelData
            screen: modelData

            anchors {top: true; bottom: true; left: true; right: true}
            color: "transparent"

            exclusionMode: ExclusionMode.Ignore
            WlrLayershell.layer: WlrLayer.Background
            WlrLayershell.namespace: "overviewEffect"

            visible: Niri.overviewState

            Rectangle {
                anchors.centerIn: parent
                width: screen.width / 2 + border.width; height: screen.height / 2 + border.width

                color: "transparent"
                border.color: Appearance.everforest.green; border.width: 20

                opacity: (Cava.amplitudes?.reduce((acc, val) => acc + val) / Cava.amplitudes?.length)

                layer.enabled: true
                layer.effect: MultiEffect {blurEnabled: true; blur: 1.5}
            }
        }
    }
}



