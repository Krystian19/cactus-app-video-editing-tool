package main

import (
	"os"
	"fmt"
	"log"
	"os/exec"
	"strings"
	"bufio"
	"github.com/urfave/cli"
)

func main() {
	app := cli.NewApp()
	app.Name = "Video Editor tool"
	app.Usage = "Downloads and edits a video to include the specified watermark"

	myFlags := []cli.Flag{
		cli.StringFlag {
			Name: "path",
		},
		cli.StringFlag {
			Name: "name",
		},
	}

	app.Commands = []cli.Command{
		{
			Name: "dl",
			Flags: myFlags,
			Usage: "Downloads a video from a the specified host/path",
			Action: func(c *cli.Context) error {
				video_path := c.String("path")
				filename := c.String("name")

				videoDownload(video_path, filename)
				return nil
			},
		},
	}

	err := app.Run(os.Args)

	if err != nil {
		log.Fatal(err)
	}
}

func videoDownload(url string, filename string) {
	// ffmpeg -i $VIDEO_LINK -c copy -bsf:a aac_adtstoasc $OUTPUT_FILE
	args := "-i %s -c copy -bsf:a aac_adtstoasc %s"
	parsed_args := fmt.Sprintf(args, url, filename)

	// fmt.Println(fmt.Sprintf(args, url, filename))

	cmd := exec.Command("ffmpeg", strings.Split(parsed_args, " ")...)
	stdout, _ := cmd.StdoutPipe()
	
	cmd.Start()
	oneByte := make([]byte, 100)

	for {
		_, err := stdout.Read(oneByte)
		if err != nil {
			fmt.Printf(err.Error())
			break
		}
		r := bufio.NewReader(stdout)
		line, _, _ := r.ReadLine()
		fmt.Println(string(line))
	}

	cmd.Wait()

	// cmd := exec.Command("ffmpeg", strings.Split(parsed_args, " ")...)

	// stderr, _ := cmd.StderrPipe()
	// cmd.Start()

	// scanner := bufio.NewScanner(stderr)
	// scanner.Split(bufio.ScanWords)

	// for scanner.Scan() {
	// 		m := scanner.Text()
	// 		fmt.Println(m)
	// 		fmt.Println("\n")
	// }
	// cmd.Wait()
	
}

func videoQualityConversion() {
	fmt.Println("So you want to change the video quality ?")
}

func videoEmbedWatermark() {
	fmt.Println("So you want to embed the video watermark here ?")
}