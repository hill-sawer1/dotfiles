import QtQuick
import QtQuick.Effects
import qs.modules.weather

WeatherEffect {
    Rectangle {
        width: 300
        height: 9
        x: 50
        y: 50
        radius: width / 2
    }
}

/*
 * TODO:
 *
 * Centralize Celestials
 * Get a basic shader that takes the underlying pixels and moves them horizontally a bit
 */
