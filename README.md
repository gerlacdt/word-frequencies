# Description

This project counts the word frequencies from a given text-input-file
and writes the frequencies to a given output-file.

Load the asdf-system with:

      > (asdf:load-system :wordcount)

Start word counting with:

     > (wordcount:count-words "inputfile.txt" "output.txt")
