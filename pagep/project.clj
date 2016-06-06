(defproject pagep "0.1.0-SNAPSHOT"
  :description "web page processor"
  :dependencies [[org.clojure/clojure "1.8.0"]
                 [org.clojure/clojurescript "1.8.51"]]
  :jvm-opts ^:replace ["-Xmx1g" "-server"]
  :plugins [[lein-npm "0.6.1"]]
  :npm {:dependencies [[source-map-support "0.4.0"]]}
  :source-paths ["src" "target/classes"]
  :clean-targets ["gen" "release"]
  :target-path "target")
