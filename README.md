# Video Editing script
This project is the automated editing pipeline of cactus-app

## Requirements
```sh
node -v # Or later
  v10.15.3

ffmpeg -version
  ffmpeg version 4.1.3 Copyright (c) 2000-2019 the FFmpeg developers
```

## How to use (Shell version)
+ Usage
```sh
./script.sh <input_path/input_url> <output_filename.mp4>
```

+ For example
```sh
./script.sh input_file.mp4 output_file.mp4
```

+ Now, measure execution time with `time`
```sh
time ./script.sh wise_man_grandchild.mp4 aloha.mp4
```

## How to use (Nodejs version)
+ Usage
```ss
./index.js <input_path/input_url> <output_filename.mp4> [options]
```

+ Generate thumbnails for the provided video and Embed the Watermark
```sh
./index.js wise_man_grandchild.mp4 aloha.mp4 -tw
```

## License
MIT © [Jan Guzman](https://github.com/Krystian19)