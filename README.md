# Simple (One-File) Scripts

Now and then I find myself automating a simple task that others might find
useful as well.

## Generate histogram of word-occurrences in PDF files

**script:** `bib2important_words_list.rb`\
**requires:** [pdftotext](http://www.foolabs.com/xpdf/home.html)

During my research I gather lots of PDF files of scientific articles and
books. My interpretation of what the key terms are in the field do not alway
align with the actual key terms that are being used in the field. On the one
hand, people from different traditions and generations tend to use (slightly)
different terms to describe the same concepts. On the other hand, not being a
native English speaker, I think I sometimes have a different interpretation of a
term than meant by the authors.

Using `ruby bib2important_words_list.rb path/to/source-dir` allows me to
generate a histogram of occurrences of words in the PDF files in `source-dir`.
At the moment, the histogram only includes words that occur at least 10 times.
It does not ignore articles, and other irrelevant words at the moment, but
these are easy to recognize and strip afterwards.

## Capture a computer session

**script:** `capture_sreen`\
**requires:** [ffmpeg](https://trac.ffmpeg.org)

When testing educational software, I often would capture the computer sessions
for later analysis. Running the script `capture_screen some_string` captures the screen as
    a video and saves it in a date-prefixed, some-string-named webm file.

For more information about capturing screen sessions (including audio) see:
https://trac.ffmpeg.org/wiki/Capture/Desktop    

## Convert a PDF image to a bitmap

**script:** `pdf_to_img`\
**requires:** [ghostscripts](https://www.gnu.org/software/ghostscript)

During my research in history and education, I've collected a lot of PDF files
containing either historical documents or students' products. Sometimes I need
a (high resolution) raster image file to add to my papers or websites.

Usage:

    pdf_to_img input.pdf [output_format [resolution]]

This will convert input.pdf to output.output_format (default format is `png`)
with given resolution (default resolution is `300x300`). For more information
about possible output formats, see
https://www.gnu.org/software/ghostscript/devices.html

TODO: convert one page from a multi-page PDF file

## Listen to Dutch NPO radio (1-6)

**script:** `radio`\
**requires:** [vlc](http://www.videolan.org/vlc/) (other media players will
work as well, just adapt the script accordingly)


I like to listen to Dutch public radio. On
http://www.npo.nl/specials/digitale-radio you find information about the internet streams. As I got bored copying those urls in my mediaplayer, I wrote a simple script to start up one of the six radio stations.

Usage:

    radio [n]

with n, 1 <= n <= 6, the number of the radio station. By default radio 1 is
started.

## transcribe.vim

**script:** `transcribe.vim`\
**requires:** [mplayer](http://mplayerhq.hu)

While doing historical and educational research, I often made audio or video
recordings I had to transcribe afterwards. As it is a hassle to control two
application at the same time (editor and media player), I wrote a simple vim
script to control mplayer from within vim.
