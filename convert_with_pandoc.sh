#!/bin/bash
#
# Usage: convert_with_pandoc [format [input]]
#
# converts input to format or converts the document specified in this file to
# format. If no format is given, convert to html5.
#
# Save this script in the directory containing the files of the document.
# Update the input files in this script to point to the correct files in the
# correct order.
#

if [ "$1" = "" ]; then
    FORMAT="html5"
    EXT="html"
else
    if [ "$1" = "html" ]; then
        FORMAT="html5"
        EXT="html"
    else
        FORMAT="$1"
        EXT="$1"
    fi
fi

if [ "$2" = "" ]; then 
    # No input file is given, use specification below

    TITLE=`head -n 1 titlepage.markdown | sed -e 's/^%\s*//g' -e 's/\s\+/_/g'`
    TITLE="new-$TITLE"

    EXTRA_ARGS=""
    case $FORMAT in
        "html5") 
            EXTRA_ARGS="--mathjax --standalone"
            ;;
        "docx")
            REF="$TITLE.docx"  
            if [ -e "$REF" ]; then
                EXTRA_ARGS="--reference-docx=$REF"
            fi
            ;;
        "odt")
            REF="$TITLE.odt"
            if [ -e "$REF" ]; then
                EXTRA_ARGS="--reference-odt=$REF"
            fi
            ;;
    esac

    pandoc \
        --from=markdown \
        --to=$FORMAT \
        --css=assets/style.css \
        --csl=assets/apa.csl \
        --bibliography=assets/bibliography.bib \
        $EXTRA_ARGS \
        -o $TITLE.$EXT \
        titlepage.markdown \
        input1.markdown \
        input2.markdown \
        input....markdown \
        inputn.markdown 
else
    # Input file is specified in $2, convert it
    pandoc \
        --from=markdown \
        --to=$FORMAT \
        --mathjax \
        --css=assets/style.css \
        --csl=assets/apa.csl \
        --bibliography=assets/bibliography.bib \
        --standalone \
        -o $2.$EXT \
        $2
fi
