pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects
import qs.services
import qs.modules.common.functions

CelestialObject {
    id: moon
    Canvas { // TODO: Make an image mask on this
        id: moonShape
        anchors.fill: parent
        onPaint: Astronomy.drawMoon(getContext("2d"), "#ddddff", moon.size, Weather.moonPhase)
        layer.enabled: true
        layer.effect: MultiEffect {
            source: moonShape
            blurEnabled: true; blurMultiplier: 0.25; blur: 0.2
        }
    }
}
