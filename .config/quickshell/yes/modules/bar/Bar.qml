pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import QtQuick.Controls
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.centerHub
import qs.services

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: root

            required property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: Appearance.sizes.barHeight
            color: Qt.alpha(Appearance.everforest.bg0, 0.75) // TODO: add config for opacity

            BarCorner { visible: !Niri.overviewState; screen: root.modelData; corner: 0 } // top left
            BarCorner { visible: !Niri.overviewState; screen: root.modelData; corner: 1 } // top right

            // left

            // BarGroup {
            //     anchors.verticalCenter: parent.verticalCenter
            //     padding: 14
            //     Text {
            //         text: Object.values(Niri.workspaces).find(ws => ws.is_active)?.idx ?? 1
            //         font.family: Appearance.font.sans
            //         font.hintingPreference: Font.PreferFullHinting
            //         font.pixelSize: 14
            //         font.weight: 650
            //         color: Appearance.everforest.fg
            //     }
            // }



            // center

            Loader {
                id: hubLoader
                active: false; asynchronous: true
                sourceComponent: CenterHub {
                    anchorWindow: root
                    onFinished: (destroy) => { if (destroy) { hubLoader.active = false; } }
                }
            }

            Button { // might have to revamp
                id: centerButton
                anchors.centerIn: parent
                onClicked: {hubLoader.active = !hubLoader.active}

                background: Rectangle {
                    color: Appearance.everforest.bg1
                    radius: height / 2
                    opacity: parent.hovered ? 0.75 : 0
                    Behavior on opacity { NumberAnimation { duration: 75 } } // TODO: standardize
                }

                contentItem: BarGroup {
                    DateWidget {
                        // TODO: change to some kind of standardized font
                        font.family: Appearance.font.sans
                        font.hintingPreference: Font.PreferFullHinting
                        font.pixelSize: 14
                        font.weight: 650
                        color: Appearance.everforest.fg
                    }

                    ClockWidget {
                        font.family: Appearance.font.sans
                        font.hintingPreference: Font.PreferFullHinting
                        font.pixelSize: 14
                        font.weight: 650
                        color: Appearance.everforest.fg
                    }
                }
            }

            // right





        }
    }
}
