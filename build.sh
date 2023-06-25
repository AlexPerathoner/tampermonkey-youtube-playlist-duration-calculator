#!/bin/bash

REPO="nrednav/youtube-playlist-duration-calculator"
LATEST_RELEASE=$(curl -s "https://api.github.com/repos/$REPO/releases/latest" | jq -r '.tag_name')
# remove "v" from version
LATEST_RELEASE=${LATEST_RELEASE:1}

template_file="tampermonkey-script-template.js"
library_file="library.js"
content_file="content.js"
output_file="tampermonkey-script.user.js"

echo $template_file
echo $library_file
echo $content_file
echo $output_file



# Read content
template_content=$(cat "$template_file")
library_content=$(cat "$library_file")
content_content=$(cat "$content_file")

# add library and content to end of template, also add final string "})();"
echo -e "$template_content\n\n$library_content\n\n$content_content\n\n})();" > "$output_file"

# replace version in output file with latest release
sed -i '' "s/TEMPLATE-VERSION/$LATEST_RELEASE/g" "$output_file"
