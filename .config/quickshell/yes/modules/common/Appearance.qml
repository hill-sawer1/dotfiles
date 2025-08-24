pragma Singleton
import Quickshell
import QtQuick
// ts sucks
Singleton {
    id: root
    property QtObject everforest
    property QtObject sizes
    property QtObject font

    everforest: QtObject { // wtf bruh make this an enum or something
        // TODO: add dark/light theme switch support (if/else)
        // TODO: add match case type thing for hard, medium, soft

        // hard
        readonly property color bgDim: "#1e2326"
        readonly property color bg0: "#272e33"
        readonly property color bg1: "#3a464c"
        readonly property color bg2: "#434f55"
        readonly property color bg3: "#4d5960"
        readonly property color bg4: "#555f66"
        readonly property color bg5: "#5d6b66"
        readonly property color bg_visual: "#5c3f4f"
        readonly property color bg_red: "#59464c"
        readonly property color bg_green: "#48584e"
        readonly property color bg_blue: "#3f5865"
        readonly property color bg_yellow: "#55544a"

        readonly property color fg: "#d3c6aa"
        readonly property color red: "#e67e80"
        readonly property color orange: "#e69875"
        readonly property color yellow: "#dbbc7f"
        readonly property color green: "#a7c080"
        readonly property color aqua: "#83c092"
        readonly property color blue: "#7fbbb3"
        readonly property color purple: "#d699b6"
        readonly property color grey0: "#7a8478"
        readonly property color grey1: "#859289"
        readonly property color grey2: "#9da9a0"
    }

    sizes: QtObject {
        readonly property int barHeight: 30
    }

    font: QtObject {
        readonly property string sans: "Adwaita Sans"
        readonly property string mono: "Noto Sans Mono"
    }
}


