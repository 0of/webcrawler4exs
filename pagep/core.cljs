(ns pagecap.core)

(enable-console-print!)

(defn load
  [url on-load]
  "load from url and return a `Window` object"
  (let [window (-> "nw.gui"
                   js/require
                   .-Window)
        on-opened (fn [opened] (.on opened "loaded" #(on-load opened)))]
    (.open window url #js {:new_instance false} on-opened)))

(defn snapshot
  [window on-finished]
  (.capturePage window on-finished #js {:format "png"
                                        :datatype "buffer"}))

(defn- filter-links
  [el]
  (let [href (.getAttribute el "href")]
    (and href
         (not= 0 (.-length href))
         (not= 0 (.indexOf href "javascript:"))
         (not= 0 (.indexOf href "#")))))

(defn crawl-links
  [window]
  "access doc and search <a href>"
  (let [doc (aget window "window" "document")]
    (->> (.getElementsByTagName doc "a")
         array-seq
         (filter filter-links)
         (map #(.-href %)))))

(defn -main
  [& args]
  (load "" (fn [window] (.showDevTools window) (prn (crawl-links window)))))

(-main)