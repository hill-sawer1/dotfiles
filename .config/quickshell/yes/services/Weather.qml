pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import qs.modules.common.functions

Singleton {
    id: root
    readonly property real lat: 40.689247
    readonly property real lon: -74.044502

    property string forecast: ""
    property bool daytime: false
    property real moonPhase

    property var location: ({
        valid: false,
        lat: 0,
        lon: 0
    })

    function getData() {
        let coords = (false)  // replace with real gps condition (lazy)
        ? `${root.location.lat},${root.location.lon}`
        : `${root.lat},${root.lon}`

        let weatherCommand = `
        curl -sS https://api.weather.gov/points/${coords} \
        | jq -r '.properties.forecastHourly' \
        | xargs curl -s \
        | jq -r '.properties.periods[0].icon' \
        | sed -E 's|.*/(day|night)/([^?]+).*|\\2|'
        `

        let sunCommand = `
        curl -sS "https://api.sunrise-sunset.org/json?lat=${root.lat}&lng=${root.lon}&formatted=0" \
        | jq -r '.results | "\\(.sunrise) \\(.sunset)"'
        `

        weatherFetcher.command[2] = weatherCommand
        weatherFetcher.running = true

        root.daytime = Astronomy.isDaytime(lat, lon)
        root.moonPhase = Astronomy.calculateMoonPhase()
    }

    Process {
        id: weatherFetcher
        command: ["bash", "-c", ""]
        stdout: StdioCollector {
            onStreamFinished: {
                if (text.length === 0)
                    return;
                try {
                    root.forecast = text
                } catch (e) {
                    console.error(`[WeatherService] ${e.message}`)
                }
            }
        }
    }

    Timer {
        id: cooldown
        running: false
        interval: 10 * 60 * 1000
    }

    Connections {
        target: Niri
        function onOverviewStateChanged() {
            Niri.overviewState
            ? cooldown.running
                ? null
                : (updater.start(), cooldown.start())
            : updater.stop()
        }
    }

    Timer {
        id: updater
        running: false
        triggeredOnStart: true; repeat: true
        interval: 30 * 60 * 1000
        onTriggered: root.getData()
    }
}
