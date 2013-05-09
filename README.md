# Description

This project counts the word frequencies from a given text-input-file
and writes the frequencies to a given output-file.

Load the asdf-system with:

      > (asdf:load-system :wordcount)

Start word counting with:

     > (wordcount:count-words "inputfile.txt" "output.txt")

Or with quicklisp:

Prerequsities see:

http://xach.livejournal.com/278047.html?thread=674335              

     > (quicklisp:quickload :wordcount)
