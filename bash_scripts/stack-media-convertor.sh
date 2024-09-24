#!/usr/bin/bash

if [ "$(command -v ffmpeg)" ]; then
    echo "command \"ffmpeg\" exists on system"
else
    echo 'ffmpeg is needed to run this command, please consider installing it'
    exit 1
fi


find "$1" \( -iname "*.mp3" -o -iname "*.m4a" \) | while read -r file; do
    fileName="${file%.*}"
    outputFile="{$fileName}.ogg"
    if ffmpeg -nostdin -i "$file" -c:a libvorbis "$outputFile"; then
        echo "Success: $file converted into $outputFile"
    else
        echo "Error: Unable to convert $file"
    fi
done