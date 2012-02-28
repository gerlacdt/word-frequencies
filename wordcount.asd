(defsystem #:wordcount
   :description "Counts the word frequency of all words in a given
   input-text-file, sorts them according to their frequency and prints
   them to the given output-file."
   :version "0.1"
   :author "Daniel Gerlach"
   :licence "Simplified BSD License"
   :depends-on (#:cl-ppcre)
   :components ((:file "package")
                (:file "wordcount" :depends-on ("package"))))