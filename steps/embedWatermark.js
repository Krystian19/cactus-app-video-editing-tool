const { spawn } = require('child_process');
const fs = require('fs');
const path = require('path');

module.exports = async function embedWatermark(video_path, logo_path) {
  return new Promise((resolve, reject) => {
    const embededWatermarkVideoPath = path.join(
      path.dirname(video_path),
      `${path.parse(video_path).name}_with_logo.${path.parse(video_path).ext}`
    )

    // Check if outputPath file already exists
    if (fs.existsSync(embededWatermarkVideoPath)) {
      return reject('Watermark embeded video path already exists');
    }

    const ls = spawn(`ffmpeg`, [
      '-i', video_path,
      '-i', logo_path,
      '-filter_complex', "[1:v][0:v]scale2ref=w='iw*5/100':h='ow/mdar'[logo1][base]; [base][logo1] overlay=main_w-overlay_w-25:main_h-overlay_h-25",
      '-codec:a', 'copy',
      embededWatermarkVideoPath,
    ]);

    ls.stdout.on('data', data => console.log(data.toString()))
    ls.stderr.on('data', data => console.log(data.toString()))

    ls.on('exit', function (code) {
      // If exit code was 0, then it was successful
      if (!parseInt(code.toString())) {
        resolve()
      }

      console.log('Embed Watermark process exited with code ' + code.toString());
      reject()
    });
  })
}