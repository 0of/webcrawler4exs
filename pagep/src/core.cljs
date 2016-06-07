(ns pagep.core)

(enable-console-print!)

(defn new-window
  []
  (let [BrowserWindow (-> "electron"
                          js/require
                          .-BrowserWindow)]
    (BrowserWindow. (clj->js {:webPreferences {:nodeIntegration true
                                               :webgl false}}))))
(defn load
  [url on-load]
  "load from url and return a `Window` object"
  (let [window (new-window)]
    (.loadURL window url)
    (.on (.-webContents window) "did-finish-load" #(.executeJavaScript (.-webContents window) "require('electron').ipcRenderer.send('chan0', document.body.innerHTML);"))))

(defn- on-app-ready4
  []
  (let [Ipc (.-ipcMain (js/require "electron"))]
    (.on Ipc "chan0" #(prn %))
    (load "" nil)))

(defn -main
  [& args]
  (let [App (.-app (js/require "electron"))]
    (.on App "ready" on-app-ready)))

(set! *main-cli-fn* -main)