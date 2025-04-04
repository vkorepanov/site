#!/bin/bash

set -e

INPUT_FORMAT=gfm

function to_pdf() {
    local input_file="$1"
    local output_file="$2"
    local title="$3"
    sed -ze "s/+++.*+++.*\.pdf)/\# $title/" "$input_file" |
        pandoc --from="$INPUT_FORMAT" \
            --pdf-engine=xelatex \
            -Vmainfont="Liberation Sans" \
            -Vmonofont="Hack" \
            -Vgeometry:left=3cm,top=2cm,bottom=2cm,right=2cm \
            -o "$output_file"
}

echo Generating PDF from cv markdown files
to_pdf content/cv.md static/cv.pdf Резюме
to_pdf content/cv.en.md static/cv.en.pdf "Curriculum vitae"

echo "Starting hugo " "$@"
hugo "$@"
