// Gets audio data!
pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property var amplitudes

    Process {
        command: ["cava", "-p", Quickshell.env("HOME") + "/.config/cava/raw"] // seperate config that outputs the raw audio volumes
        running: true

        stdout: SplitParser {
            onRead: data => {
                let values = data.trim().split(';').map(x => parseInt(x) || 0)
                if (values[values.length - 1] === 0 && data.trim().endsWith(';')) {
                    values.pop()
                }
                root.amplitudes = values.map(x => x / 100)
            }
        }
    }
}
