import Quickshell

import "./modules/bar/"
import "./modules/glow/"
//import "./services/"
//import "./modules/weather/"
import "./modules/weather/effects"
import "./modules/notificationPopup/"
// import "./modules/common/"

ShellRoot {
    LazyLoader {active: true; component: Bar {} }
    //LazyLoader {active: true; component: NotificationPopup {} }
    LazyLoader {active: true; component: Glow {} }
}
