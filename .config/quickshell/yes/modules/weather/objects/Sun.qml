pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects

CelestialObject {
    id: sun
    Canvas {
        id: sunShape
        anchors.fill: parent
        onPaint: {
            const ctx = getContext("2d")
            const diameter = sun.size
            const radius = diameter / 2
            ctx.clearRect(0, 0, diameter, diameter);
            ctx.beginPath();
            ctx.arc(radius, radius, radius, 0, 2 * Math.PI);
            ctx.fillStyle = "#ffcc22";
            ctx.fill();
        }
        layer.enabled: true
        layer.effect: MultiEffect {
            source: sunShape
            blurEnabled: true; blur: 0.75; blurMax: 64;
            brightness: 1
        }
    }
}
