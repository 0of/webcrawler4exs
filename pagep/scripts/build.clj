(require '[cljs.build.api :as b])

(println "Building ...")

(let [start (System/nanoTime)]
  (b/build "src"
    {:main 'pagep.core
     :output-to "gen/pagep-core.js"
     :output-dir "gen"
     :verbose true})
  (println "... done. Elapsed" (/ (- (System/nanoTime) start) 1e9) "seconds"))


