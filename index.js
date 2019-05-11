#!/usr/bin/env node

const program = require('commander');

program
  .version('0.1.0')
  .usage('[command]')

program
  .command('dl <url> <output_path>')
  .usage('<url> <output_path> [options]')
  .action(function (url, output, cmd) {
    const spawn = require('child_process').spawn;
    const ls = spawn(`ffmpeg`, [
      '-i', url,
      '-c', 'copy',
      '-bsf:a', 'aac_adtstoasc',
      `./output/${output}`
    ]);

    ls.stdout.on('data', function (data) {
      console.log('stdout: ' + data.toString());
    });

    ls.stderr.on('data', function (data) {
      console.log('stderr: ' + data.toString());
    });

    ls.on('exit', function (code) {
      console.log('child process exited with code ' + code.toString());
    });
  })

program.parse(process.argv)

if (process.argv.length < 3) {
  program.help()
}