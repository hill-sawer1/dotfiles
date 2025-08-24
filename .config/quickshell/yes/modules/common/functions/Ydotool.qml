pragma Singleton

import Quickshell
import QtQuick
import Quickshell.Io

Singleton {
    function click() {
        process.command = ["ydotool", "click", "C0"]
        process.running = true
    }
    function scroll(x=0, y=0) {
        process.command = ["ydotool", "mousemove", "-w", "-x", `${x}`, "-y", `${y}`]
        process.running = true
    }
    Process { id: process }
}
