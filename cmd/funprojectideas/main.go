package main

import (
	"log"
	"net/http"
)

func main() {
	http.HandleFunc("/healthz", func(w http.ResponseWriter, r *http.Request){
		//do stuff
		log.Println("Request Recieved")
	})
	log.Fatal(http.ListenAndServe(":8080", nil))
}
