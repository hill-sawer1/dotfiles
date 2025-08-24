import QtQuick
import QtQuick.Layouts

Item {
    id: root
    property real padding: 5 // TODO: add config option!!!
    implicitHeight: rowLayout.implicitHeight
    implicitWidth: rowLayout.implicitWidth + padding * 2
    default property alias items: rowLayout.children


    RowLayout {
        id: rowLayout
        anchors {
            //confusing, i dont remember why i did this
            verticalCenter: parent.verticalCenter
            left: parent.left
            right: parent.right

            leftMargin: root.padding
            rightMargin: root.padding
        }
        spacing: root.padding * 2
    }
}
