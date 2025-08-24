// Time.qml
pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root
    // see https://doc.qt.io/qt-6/qml-qtqml-qt.html#formatDateTime-method

    readonly property string time: Qt.formatDateTime(clock.date, "h:mm AP")
    readonly property string date: Qt.formatDateTime(clock.date, "MMM d")

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
