package main

import (
	"fmt"
	"net/http"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintln(w, "Hello, World!")
	})
	fmt.Println("Starting server at :8080")
	http.ListenAndServe(":8080", nil)
}
