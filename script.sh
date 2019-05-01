#/bin/bash

VIDEO_LINK="https://dl.v.vrv.co//evs//d5055c18f0b1527048f3384edf9eef90//assets//d1d073c012e531ad06ffede657189492_,3654217.mp4,3654219.mp4,3654215.mp4,3654211.mp4,3654213.mp4,.urlset//master.m3u8?Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cCo6Ly9kbC52LnZydi5jby9ldnMvZDUwNTVjMThmMGIxNTI3MDQ4ZjMzODRlZGY5ZWVmOTAvYXNzZXRzL2QxZDA3M2MwMTJlNTMxYWQwNmZmZWRlNjU3MTg5NDkyXywzNjU0MjE3Lm1wNCwzNjU0MjE5Lm1wNCwzNjU0MjE1Lm1wNCwzNjU0MjExLm1wNCwzNjU0MjEzLm1wNCwudXJsc2V0L21hc3Rlci5tM3U4IiwiQ29uZGl0aW9uIjp7IkRhdGVMZXNzVGhhbiI6eyJBV1M6RXBvY2hUaW1lIjoxNTU2ODMyNzU0fX19XX0_&Signature=VyQNci2s3jtgAvykBqwkwqB6QP~aWXevqGEDUtBziPKDx~HKFGpk-ACyBFn1PRENjXMZofSyg~b66oku~Z9648HZX2nBVSAomdAL6ZWvVI2qnmkCk8WQrahFEAQo-wip9B92oOGCBwP-akKj2cFpbUTRveWDjfxuJiggE3OnhjdrT0W~tGEmAUsKAnPDiEeNfAOMufK1oSlHoFIOsD~IIuk4lOx9znBTPHzFI5Jh23s1PhgqK-yUG3kzjWoj1uFrnwAgGhqss1RKg5FIwySquj9fbmCKFiwyK3G7Gltu1ksGrCUj6zh2bbJQ8p0gg9A5BKj2TO3dy0JlUJ4nKXxvEg__&Key-Pair-Id=DLVR"
OUTPUT_FILE="demon_hunter3.mp4"
QUALITY_OUTPUT_FILE="demon_hunter3_720p.mp4"
FINAL_OUTPUT_FILE="demon_hunter3_720p_with_logo.mp4"

echo "==================================================================================="
echo "========================== DOWNLOADING VIDEO FILE ================================="
echo "==================================================================================="

# Downloads the video
ffmpeg -i $VIDEO_LINK -c copy -bsf:a aac_adtstoasc $OUTPUT_FILE

echo "==================================================================================="
echo "====================== FILE DOWNLOADED, NOW REDUCING SIZE=========================="
echo "==================================================================================="

# Converts 1080p to 720p
ffmpeg -i $OUTPUT_FILE -vf scale=-1:720 -c:v libx264 -crf 18 -preset veryslow -c:a copy $QUALITY_OUTPUT_FILE

echo "==================================================================================="
echo "===================== FILE SIZE REDUCED, NOW INCLUDING WATERMARK =================="
echo "==================================================================================="

# Includes logo inside the video frame
ffmpeg -i $QUALITY_OUTPUT_FILE -i logo.png -filter_complex "[1:v][0:v]scale2ref=w='iw*5/100':h='ow/mdar'[logo1][base]; [base][logo1] overlay=main_w-overlay_w-25:main_h-overlay_h-25" -codec:a copy $FINAL_OUTPUT_FILE