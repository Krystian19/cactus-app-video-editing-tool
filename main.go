package main

import (
	"log"
	"os"
	"fmt"
	"github.com/urfave/cli"
)

func main() {
	err := cli.NewApp().Run(os.Args)
	
	// If there was an error
	if (err != nil) {
		log.Fatal(err)
	}

	fmt.Println("Here we are gents !!!!")
}