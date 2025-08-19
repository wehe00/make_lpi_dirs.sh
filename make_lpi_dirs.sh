#! /bin/bash

# Scrape LPI objectives and generate directory structure.
# version 0.1 by Werner Heuser
# _(weight:_2)

# create main destination directory
DEST="test_lpic"
rm -rf "$DEST" && \
mkdir "$DEST" -v

function scrape(){
  curl -s https://wiki.lpi.org/wiki/LPIC-2_Objectives_V5.0 | \
  lynx -dump -stdin | grep -E "^[1-9][0-9][0-9]\.[1-9] [a-zA-Z]"
}

while read -r LINE
do
  # convert spaces to underscores
  # convert uppercase to lowercase
  DIR=$(echo "$LINE" | tr " " "_" | tr "[:upper:]" "[:lower:]")
  # create directories
  echo "create directory: $DIR" && \
  mkdir -p "$DEST/$DIR"
done < <(scrape)

echo "created $(( $( find "$DEST" -type d | wc -l ) -1 )) directories"
