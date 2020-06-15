package main

import (
	"fmt"
	"flag"
	"os"
	"github.com/stianeikeland/go-rpio"
)

var (
	// mapping from https://github.com/simonmonk/squid
	green = rpio.Pin(23)
	red = rpio.Pin(18)
	blue = rpio.Pin(24)
)

func main() {


	fmt.Printf("Color Setting for Squid LED: ref https://github.com/simonmonk/squid\n")
 	color := flag.String("color", "off", "LED color: off, red, green, blue, white")

	// Open and map memory to access gpio, check for errors
	if err := rpio.Open(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	// Unmap gpio memory when done
	defer rpio.Close()

	// Set pins to output mode
	green.Output()
	red.Output()
	blue.Output()

	red.Low()
	green.Low()
	blue.Low()

	flag.Parse()
	output := "not set"

	switch *color {
	case "green":
		green.High()
		output = "Green (23)"
	case "red":
		red.High()
		output = "Red (18)"
	case "blue":
		blue.High()
		output = "Blue (24)"
	case "orange":
		red.High()
		green.High()
		output = "Red + Green (18, 23)"
	case "purple":
		red.High()
		blue.High()
		output = "Red + Blue (18, 24)"
	case "cyan":
		red.High()
		blue.High()
		output = "Green + Blue (23, 24)"
	case "white":
		blue.High()
		red.High()
		green.High()
		output = "White (18, 23, 24)"
	default:
		output = "Off (or unknown)"
	}		

	fmt.Printf("Set RPIO Color: %s\n", output)

}