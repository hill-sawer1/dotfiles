import QtQuick
import Quickshell
import qs.modules.common.widgets
import qs.modules.common

PanelWindow {
    id: cornerPanelWindow
    property var corner
    color: "transparent"

    anchors { // me when readability
        top:  corner === RoundCorner.CornerEnum.TopLeft || corner === RoundCorner.CornerEnum.TopRight // corner < 2
        left: corner === RoundCorner.CornerEnum.TopLeft || corner === RoundCorner.CornerEnum.BottomLeft // !(corner % 2)
        bottom: corner === RoundCorner.CornerEnum.BottomLeft || corner === RoundCorner.CornerEnum.BottomRight // corner > 2
        right: corner === RoundCorner.CornerEnum.TopRight || corner === RoundCorner.CornerEnum.BottomRight // (corner % 2)
    }

    implicitWidth: cornerWidget.implicitWidth
    implicitHeight: cornerWidget.implicitHeight

    RoundCorner {
        id: cornerWidget
        corner: cornerPanelWindow.corner
        color: Appearance.everforest.bg0
        opacity: 0.75 // TODO: standardize in config
        implicitSize: 12 // TODO: standardize in config
    }
}
