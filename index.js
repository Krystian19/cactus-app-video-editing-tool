#!/usr/bin/env node

const program = require('commander');
const path = require('path');
const fs = require('fs');

const Download = require('./steps/download');
const GenerateThumbnails = require('./steps/generateThumbnails');

// Output path for the files
const outputPath = path.join(__dirname, 'output');

// Creates output directory if it doesn't exists
if (!fs.existsSync(outputPath)) {
  fs.mkdirSync(outputPath);
}

program
  .version('0.1.0')
  .usage('[command] [options]')

program
  .command('dl <url> <output_file>')
  .usage('<url> <output_file> [options]')
  .action(function (url, output_file, cmd) {
    const fullOutputFilePath = path.join(outputPath, output_file);

    (async () => {
      try {
        // Download the video throught the provided url/path
        await Download(url, fullOutputFilePath);

        // Generates thumbnails based on the provided video file
        await GenerateThumbnails(fullOutputFilePath);

      } catch (err) {
        console.log(err)
        process.exit(1)
      }
    })();

  })

program.parse(process.argv)

if (process.argv.length < 3) {
  program.help()
}