const { spawn } = require('child_process');
const { existsSync } = require('fs');

module.exports = async function Download(url, outputPath) {
  return new Promise((resolve, reject) => {

    // Check if outputPath file already exists
    if (existsSync(outputPath)) {
      return reject('Download path already exists');
    }

    const ls = spawn(`ffmpeg`, [
      '-i', url,
      '-c', 'copy',
      '-bsf:a', 'aac_adtstoasc',
      outputPath,
    ]);

    ls.stdout.on('data', data => console.log(data.toString()))
    ls.stderr.on('data', data => console.log(data.toString()))

    ls.on('exit', function (code) {
      // If exit code was 0, then it was successful
      if (!parseInt(code.toString())) {
        resolve()
      }

      console.log('Download process exited with code ' + code.toString());
      reject()
    });
  })
}