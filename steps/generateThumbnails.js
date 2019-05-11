const { spawn } = require('child_process');
const fs = require('fs');
const path = require('path');

module.exports = async function generateThumbnails(file_path) {
  return new Promise((resolve, reject) => {
    const thumbnailOutputPath = path.join(
      path.dirname(file_path),
      `${path.parse(file_path).name}_thumbnail%02d.jpg`
    )

    // Check if outputPath file already exists
    if (fs.existsSync(thumbnailOutputPath)) {
      return reject('Thumbnails path already exists');
    }

    const ls = spawn(`ffmpeg`, [
      '-ss', '3',
      '-i', file_path,
      '-vf', '"select=gt(scene\,0.4)"',
      '-frames:v', '5',
      '-vsync', 'vfr',
      '-vf', 'fps=fps=1/600',
      thumbnailOutputPath,
    ]);

    ls.stdout.on('data', data => console.log(data.toString()))
    ls.stderr.on('data', data => console.log(data.toString()))

    ls.on('exit', function (code) {
      // If exit code was 0, then it was successful
      if (!parseInt(code.toString())) {
        resolve()
      }

      console.log('Thumbnail generation process exited with code ' + code.toString());
      reject()
    });
  })
}