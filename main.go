package main

import (
	"fmt"
	"log"
)

func main() {
	configPath, err := ParseFlags()
	if err != nil {
		log.Fatal(err)
	}
	config, err := LoadConfig(configPath)
	if err != nil {
		log.Fatal(err)
	}

	fmt.Printf("config: %+v", config)

	// TODO: application
	// ...

	return
}
