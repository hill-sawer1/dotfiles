import QtQuick
import qs.modules.common
import qs.services

Item {
    id: root
    default property alias content: container.data

    property int size: 64
    property real elevationFactor: 4 // Adjust accordingly to what you like

    implicitWidth: size; implicitHeight: size

    x: MouseTracker.cursor.x - width/2
    y: Math.min(Math.max(MouseTracker.cursor.y / elevationFactor, Appearance.sizes.barHeight), 192 - height)

    opacity: visible ? 1 : 0
    Behavior on opacity {
        NumberAnimation { duration: 200 }
    }

    Behavior on x {
        enabled: MouseTracker.zip
        SmoothedAnimation { velocity: 4000 }
    }
    Behavior on y {
        enabled: MouseTracker.zip
        SmoothedAnimation { velocity: 4000 }
    }

    Item {
        id: container
        anchors.fill: parent
    }
}
