pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property var workspaces: ({})

    property var kbLayouts: []
    property int currentKbLayout: 0

    property var windows: ({})

    property bool overviewState: false

    readonly property string socketPath: Quickshell.env("NIRI_SOCKET")
    readonly property string configPath: Quickshell.env("HOME") + "/.dotfiles/.config/niri/config.kdl"

    function activateWorkspace(id: int) {
        send({
            Action: {
                FocusWorkspace: {
                    reference: {
                        Id: id
                    }
                }
            }
        });
    }

    function send(request) {
        requestSocket.write(JSON.stringify(request) + "\n");
    }

    FileView {
        id: configFile
        path: root.configPath
    }

    function levitate(enable) {
        let content = configFile.text();

        content = enable && !content.includes("window-rule { baba-is-float true; }")
        ? content + "\nwindow-rule { baba-is-float true; }\n"
        : content.replace(/\nwindow-rule { baba-is-float true; }\n/g, "");

        configFile.setText(content);
    }

    Socket {
        id: eventStreamSocket
        path: root.socketPath
        connected: true

        onConnectionStateChanged: {
            write('"EventStream"\n');
        }

        parser: SplitParser {
            onRead: line => {
                const event = JSON.parse(line);
                const eventType = Object.keys(event)[0];

                switch(eventType) {
                    case "WorkspacesChanged":
                        const wsc = event.WorkspacesChanged;
                        const workspaces = {};

                        for (const ws of wsc.workspaces) {
                            workspaces[ws.id] = ws;
                        }
                        root.workspaces = workspaces;
                        break;
                    case "WorkspaceActivated":
                        const wsa = event.WorkspaceActivated;
                        const ws = root.workspaces[wsa.id];
                        const output = ws.output;

                        for (const id in root.workspaces) {
                            const ws = root.workspaces[id];
                            const got_activated = ws.id === wsa.id;

                            if (ws.output === output) {
                                ws.is_active = got_activated;
                            }

                            if (wsa.focused) {
                                ws.is_focused = got_activated;
                            }
                        }

                        root.workspacesChanged();
                        break;
                    case "KeyboardLayoutsChanged":
                        const kbc = event.KeyboardLayoutsChanged.keyboard_layouts;
                        root.kbLayouts = kbc.names;
                        root.currentKbLayout = kbc.current_idx;
                        break;
                    case "KeyboardLayoutSwitched":
                        const kbs = event.KeyboardLayoutSwitched;
                        root.currentKbLayout = kbs.idx;
                        break;
                    case "WindowsChanged":
                        const wc = event.WindowsChanged;
                        const windows = {};

                        for (const win of wc.windows) {
                            windows[win.id] = win;
                        }

                        root.windows = windows;
                        break;
                    case "WindowOpenedOrChanged":
                        const woc = event.WindowOpenedOrChanged;
                        const win = woc.window;
                        root.windows[win.id] = win;

                        if (win.is_focused) {
                            for (const id in root.windows) {
                                const win = root.windows[id];
                                win.is_focused = win.id === woc.window.id;
                            }
                        }

                        root.windowsChanged();
                        break;
                    case "WindowClosed":
                        const wx = event.WindowClosed;
                        delete root.windows[wx.id];
                        root.windowsChanged();
                        break;
                    case "WindowLayoutsChanged":
                        const wlc = event.WindowLayoutsChanged;

                        for (const change of wlc.changes) {
                            root.windows[change[0]].layout = change[1];
                        }

                        root.windowsChanged();
                        break;
                    case "OverviewOpenedOrClosed":
                        const o = event.OverviewOpenedOrClosed
                        root.overviewState = o.is_open;
                        //root.levitate(o.is_open);
                }
            }
        }
    }

    Socket {
        id: requestSocket
        path: root.socketPath
        connected: true
    }
}
