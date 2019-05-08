# !/bin/bash

# Check if ffmpeg is installed
if ! [ -x "$(command -v ffmpeg)" ]; then
  echo 'Error: ffmpeg is not installed.' >&2
  echo 'ffmpeg version 4.1.3 is required to run this tool' >&2
  exit 1
fi

OUTPUT_FILE_PATH=$(pwd)/output

# Creates output folder if it doesn't exits
if ! [ -d $OUTPUT_FILE_PATH ]; then
  mkdir $OUTPUT_FILE_PATH
fi

# Check that the script has the required positioned args
if [ ! $# -eq 2 ]; then
  echo "Usage: ./scripts <file_path/file_url> <output_file_name>"
  exit
fi

# PRINT OUT ARGS FOR DEBUG

# echo "This should be video download URl/path"
# echo $1

# echo "This should be the file name output"
# echo $2


# Remove any backslashes from the VIDEO_PATH value
VIDEO_PATH=$(sed 's/\\//g' <<< $1)
OUTPUT_FILE_NAME=$2

# VIDEO_LINK="https://dl.v.vrv.co//evs//d5055c18f0b1527048f3384edf9eef90//assets//d1d073c012e531ad06ffede657189492_,3654217.mp4,3654219.mp4,3654215.mp4,3654211.mp4,3654213.mp4,.urlset//master.m3u8?Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cCo6Ly9kbC52LnZydi5jby9ldnMvZDUwNTVjMThmMGIxNTI3MDQ4ZjMzODRlZGY5ZWVmOTAvYXNzZXRzL2QxZDA3M2MwMTJlNTMxYWQwNmZmZWRlNjU3MTg5NDkyXywzNjU0MjE3Lm1wNCwzNjU0MjE5Lm1wNCwzNjU0MjE1Lm1wNCwzNjU0MjExLm1wNCwzNjU0MjEzLm1wNCwudXJsc2V0L21hc3Rlci5tM3U4IiwiQ29uZGl0aW9uIjp7IkRhdGVMZXNzVGhhbiI6eyJBV1M6RXBvY2hUaW1lIjoxNTU2ODMyNzU0fX19XX0_&Signature=VyQNci2s3jtgAvykBqwkwqB6QP~aWXevqGEDUtBziPKDx~HKFGpk-ACyBFn1PRENjXMZofSyg~b66oku~Z9648HZX2nBVSAomdAL6ZWvVI2qnmkCk8WQrahFEAQo-wip9B92oOGCBwP-akKj2cFpbUTRveWDjfxuJiggE3OnhjdrT0W~tGEmAUsKAnPDiEeNfAOMufK1oSlHoFIOsD~IIuk4lOx9znBTPHzFI5Jh23s1PhgqK-yUG3kzjWoj1uFrnwAgGhqss1RKg5FIwySquj9fbmCKFiwyK3G7Gltu1ksGrCUj6zh2bbJQ8p0gg9A5BKj2TO3dy0JlUJ4nKXxvEg__&Key-Pair-Id=DLVR"
# VIDEO_LINK="https://storage.googleapis.com/mucho-anime.appspot.com/c24c5147c197d4e211017682b7049725.mp4"
# OUTPUT_FILE="black_clover84.mp4"
# QUALITY_OUTPUT_FILE="black_clover84_720p.mp4"
# FINAL_OUTPUT_FILE="black_clover84_720p_with_logo.mp4"

echo "==================================================================================="
echo "========================== DOWNLOADING VIDEO FILE ================================="
echo "==================================================================================="

# Name of the initial file unconverted file
INITIAL_FILE_PATH=$OUTPUT_FILE_PATH/$OUTPUT_FILE_NAME

# Downloads the video
ffmpeg -i $VIDEO_PATH -c copy -bsf:a aac_adtstoasc $INITIAL_FILE_PATH

RESULT=$?
if [ ! $RESULT -eq 0 ]; then
  echo "ERROR: Could not retrieve the video file with the given URL/PATH"
  exit
fi

echo "==================================================================================="
echo "====================== FILE DOWNLOADED, NOW REDUCING SIZE=========================="
echo "==================================================================================="

INITIAL_FILE_BASENAME=$(basename ${INITIAL_FILE_PATH})
INITIAL_FILE_FILENAME=${INITIAL_FILE_BASENAME%.*}
INITIAL_FILE_EXTENSION=${INITIAL_FILE_BASENAME##*.}
REDUCED_SIZE_FILENAME=(${INITIAL_FILE_FILENAME}_720p.${INITIAL_FILE_EXTENSION})

REDUCED_SIZEFILE_PATH=$OUTPUT_FILE_PATH/$REDUCED_SIZE_FILENAME

# Converts 1080p to 720p
ffmpeg -i $INITIAL_FILE_PATH -vf scale=-1:720 -c:v libx264 -crf 18 -preset veryslow -c:a copy $REDUCED_SIZEFILE_PATH

RESULT=$?
if [ ! $RESULT -eq 0 ]; then
  echo "ERROR: while reducing file size"
  exit
fi

echo "==================================================================================="
echo "===================== FILE SIZE REDUCED, NOW INCLUDING WATERMARK =================="
echo "==================================================================================="

INITIAL_FILE_BASENAME=$(basename ${REDUCED_SIZEFILE_PATH})
INITIAL_FILE_FILENAME=${INITIAL_FILE_BASENAME%.*}
INITIAL_FILE_EXTENSION=${INITIAL_FILE_BASENAME##*.}
WITH_LOGO_FILENAME=(${INITIAL_FILE_FILENAME}_with_logo.${INITIAL_FILE_EXTENSION})

WITH_LOGO_FILENAME_PATH=$OUTPUT_FILE_PATH/$WITH_LOGO_FILENAME

# Includes logo inside the video frame
ffmpeg -i $REDUCED_SIZEFILE_PATH -i logo.png -filter_complex "[1:v][0:v]scale2ref=w='iw*5/100':h='ow/mdar'[logo1][base]; [base][logo1] overlay=main_w-overlay_w-25:main_h-overlay_h-25" -codec:a copy $WITH_LOGO_FILENAME_PATH

RESULT=$?
if [ ! $RESULT -eq 0 ]; then
  echo "ERROR: while embedding watermark"
  exit
fi

# Generate a meaningful thumbnail from a video
# https://superuser.com/questions/538112/meaningful-thumbnails-for-a-video-using-ffmpeg
# ffmpeg -ss 3 -i wise_man_grandchild.mp4 -vf "select=gt(scene\,0.4)" -frames:v 5 -vsync vfr -vf fps=fps=1/600 thumbnail%02d.jpg