(declaim (optimize (debug 3)))

(in-package :wordcount)

(defstruct word-count-pair  
  (word nil)
  (count 0))

;;; hashtable <key = word-string> <value = count>
(defparameter *word-pair-table* (make-hash-table :test 'equal))

(defun count-words (input-file output-file)
  "Wrote all words in descending order according to their occurences
   into the given output file. The input-file and output-file should
   be strings consisting the filepath."
  (fill-table input-file)
  (write-pairs (gen-sorted-word-pair-list *word-pair-table*) output-file)
  (list 'word-frequencies-written-to output-file))

(defun fill-table (filename)
  "fills the global word-pair-table hashtable with all words and their 
   corresponding counts"
  (with-open-file (stream filename)
    (do ((line (read-line stream nil) (read-line stream nil)))
        ((null line))
      (add-words-in-table (split-line line)))))

(defun add-words-in-table (word-list)
  "add a constituent word in the global hashtable"
  (dolist (word word-list)
    (if (> (length word) 0)
        (cond ((null (gethash word *word-pair-table*)) 
               (setf (gethash word *word-pair-table*) 1))
              (t (incf (gethash word *word-pair-table*)))))))

(defun gen-sorted-word-pair-list (hashtable)
  "generates from a hashtable<key=word, val=count> a sorted list descending 
   to counts"
  (let ((word-pair-list nil))
    (maphash #'(lambda (key val)
                 (push 
                  (make-word-count-pair :word key :count val) word-pair-list)) 
             hashtable)
    (sort-pairs word-pair-list)))

(defun sort-pairs (word-pair-list)
  "sort a word-pair-list in descending order. Key is the count of a word"
  (sort word-pair-list #'> :key #'word-count-pair-count))

(defun split-line (line)
  "Split line into constiutent words. Remove punctuation from words and
   make counting case insensitve."
  (cl-ppcre:split "\\W" (nstring-downcase line)))

(defun punctuation-p (char)
  (if (or (char-equal #\. char) (char-equal #\, char) 
          (char-equal #\- char) (char-equal #\_ char)
          (char-equal #\" char))
      t
      nil))

(defun write-pairs (list output-file)
  "for outputting the result into a file"
  (with-open-file (stream output-file :direction :output :if-exists :supersede)
    (mapcar #'(lambda (list-entry)
                (format stream "~&~A -> ~A" 
                        (word-count-pair-word list-entry) 
                        (word-count-pair-count list-entry))) list)))

(defun write-hashtable (hashtable output-file)
  "for debugging"
  (with-open-file (stream output-file :direction :output :if-exists :supersede)
    (maphash #'(lambda (key val)
                 (format stream "~&~A -> ~A" key val)) hashtable)))