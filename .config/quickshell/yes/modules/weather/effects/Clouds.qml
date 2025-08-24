import QtQuick
import QtQuick.Shapes
import QtQuick.Effects
import qs.modules.weather

WeatherEffect {
    id: root
    property bool wind: false
    property int clouds: 0
    enableCelestialObjs: true

    Item {
        implicitWidth: 500
        implicitHeight: 500
        Canvas {
            id: canvas
            anchors.fill: parent
            Component.onCompleted: {
                requestPaint()
            }
            onPaint: {
                const c = getContext("2d")
                const drawCloud = (x, y) => {
                    c.beginPath();
                    c.arc(x, y, 60, Math.PI * 0.5, Math.PI * 1.5);
                    c.arc(x + 70, y - 60, 70, Math.PI * 1, Math.PI * 1.85);
                    c.arc(x + 152, y - 45, 50, Math.PI * 1.37, Math.PI * 1.91);
                    c.arc(x + 200, y, 60, Math.PI * 1.5, Math.PI * 0.5);
                    c.moveTo(x + 200, y + 60);
                    c.lineTo(x, y + 60);
                    c.strokeStyle = '#797874';
                    c.stroke();
                    c.fillStyle = '#8ED6FF';
                    c.fill()
                }
                drawCloud(100,135);
            }
        }
    }


}
