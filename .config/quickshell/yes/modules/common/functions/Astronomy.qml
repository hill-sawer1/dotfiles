pragma Singleton

import QtQuick
import Quickshell

Singleton {
    function drawMoon(context, color, diameter, phase) {
        // adapted from https://codepen.io/anowodzinski/pen/ZWKXPQ
        const ctx = context
        const radius = diameter / 2

        function drawDisc() {
            ctx.beginPath();
            ctx.arc(radius, radius, radius, 0, 2 * Math.PI, true);
            ctx.closePath();
            ctx.fillStyle = color;
            ctx.fill();
        }

        function drawPhase(internalPhase) {
            ctx.globalCompositeOperation = "destination-out";
            ctx.beginPath();
            ctx.arc(radius, radius, radius + 1, -Math.PI/2, Math.PI/2, true);
            ctx.closePath();
            ctx.fill();
            if (!(phase > 0.25 && phase < 0.75)) {
                ctx.lineWidth = 2;
                ctx.stroke();
            } // clunky fix

            ctx.globalCompositeOperation = "source-over";
            ctx.translate(radius, radius);
            ctx.scale(internalPhase, 1);
            ctx.translate(-radius, -radius);

            ctx.beginPath();
            ctx.arc(radius, radius, radius, -Math.PI/2, Math.PI/2, true);
            ctx.closePath();
            ctx.fillStyle = color;
            ctx.globalCompositeOperation = internalPhase > 0 ? "source-over" : "destination-out";
            ctx.fill();
            ctx.globalCompositeOperation = "source-over";
        }

        function paint() {
            ctx.save();
            ctx.clearRect(0, 0, diameter, diameter);

            if (phase <= 0.5) {
                drawDisc();
                drawPhase(4 * phase - 1);
            } else {
                ctx.translate(radius, radius);
                ctx.rotate(Math.PI);
                ctx.translate(-radius, -radius);
                drawDisc();
                drawPhase(4 * (1 - phase) - 1);
            }

            ctx.restore();
        }

        if (phase > 1) { phase = 0; }

        paint();
    }

    function isDaytime(lat, lon) { // vibecoded af
        const now = new Date();
        const localHour = now.getHours() + now.getMinutes() / 60;
        const utcOffset = now.getTimezoneOffset() / 60;

        const start = new Date(now.getFullYear(), 0, 0);
        const day = Math.floor((now - start) / 86400000);

        const decl = -23.45 * Math.cos(2 * Math.PI * (day + 10) / 365.25) * (Math.PI / 180);
        const latRad = lat * (Math.PI / 180);
        const hourAngle = Math.acos(-Math.tan(latRad) * Math.tan(decl));

        if (isNaN(hourAngle)) { return Math.abs(lat) < Math.abs(decl * (180 / Math.PI)) }

        const sunriseUtc = 12 - hourAngle * 12 / Math.PI - lon / 15;
        const sunsetUtc = 12 + hourAngle * 12 / Math.PI - lon / 15;

        const sunriseLocal = sunriseUtc - utcOffset;
        const sunsetLocal = sunsetUtc - utcOffset;

        return localHour >= sunriseLocal && localHour <= sunsetLocal;
    }

    function calculateMoonPhase() { // also vibecoded af
        const date = new Date();
        let year = date.getFullYear();
        let month = date.getMonth() + 1;

        if (month <= 2) { year--; month += 12; }

        const a = Math.floor(year / 100);
        const jd = Math.floor(365.25 * (year + 4716)) + Math.floor(30.6001 * (month + 1)) +
        date.getDate() + 2 - a + Math.floor(a / 4) - 1524.5 +
        (date.getHours() + date.getMinutes()/60) / 24;

        const T = (jd - 2451545.0) / 36525;
        let elong = ((218.3164477 + 481267.88123421 * T) - (280.4664567 + 36000.76982779 * T)) % 360;

        return ((elong % 360 + 360) % 360) / 360;
    }
}
