// main.go
package main

import (
	"fmt"
	"plugin"
)

func main() {
	// Load the plugin
	plug, err := plugin.Open("plugin.so")
	if err != nil {
		fmt.Println("Error loading plugin:", err)
		return
	}

	// Lookup for the exported Hello function in the plugin
	helloSymbol, err := plug.Lookup("Hello")
	if err != nil {
		fmt.Println("Error finding Hello function:", err)
		return
	}

	// Assert the type of the function to match the expected type
	helloFunc, ok := helloSymbol.(func())
	if !ok {
		fmt.Println("Plugin has no function Hello with the correct signature")
		return
	}

	// Call the Hello function from the plugin
	helloFunc()
}
