(ns pagep.core)

(enable-console-print!)

;; imports
(def fs (js/require "fs"))
(def path (js/require "path"))

(defn new-window
  []
  (let [BrowserWindow (-> "electron"
                          js/require
                          .-BrowserWindow)]
    (BrowserWindow. (clj->js {:fullscreen true
                              :webPreferences {:javascript true
                                               :nodeIntegration false
                                               :webSecurity false
                                               :images false
                                               :webaudio false
                                               :webgl false}}))))

(defn load
  [url on-load]
  "load from url and return a `Window` object"
  (let [window (new-window)]
    (.openDevTools (.-webContents window))
    (.loadURL window url)
    (.on (.-webContents window) "did-finish-load" #(on-load window))))

(defn- get-hash 
  [url]
  (let [crypto (js/require "crypto")
        hash (.createHash crypto "sha256")]
    (.update hash (.concat url (.toString (js/Date.))))
    (.digest hash "hex")))

(defn- on-saved
  [err]
  (prn err))

(defn- save-buffer-to-file
  [buffer file-name]
  (.writeFile fs file-name buffer (clj->js {:encoding "binary" :flag "w"}) on-saved))

(defn snapshot
  [window save-dir]
  (let [file-name (.join path save-dir "snapshot.jpeg")
        on-captured (fn [native-image] (if 
                                        (instance? js/Error native-image)
                                        (on-save native-image)
                                        (save-buffer-to-file (.toJpeg native-image 33) file-name)))]
    (.capturePage window on-captured)))

(defn save 
  [window]
  (let [base-dir "/tmp"
        contents (.-webContents window)
        save-dir (.join path base-dir (get-hash (.getURL contents)))
        save-html-path (.join path save-dir "index.html")
        go-take-snapshot (fn [err] (if 
                                    (some? err)
                                    (on-saved err)
                                    (snapshot window save-dir)))]
    (.savePage contents save-html-path "HTMLComplete" go-take-snapshot)))

(defn- on-app-ready
  []
  (load "" save))

(defn -main
  [& args]
  (let [App (.-app (js/require "electron"))]
    (.on App "ready" on-app-ready)))

(set! *main-cli-fn* -main)