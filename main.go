package main

import (
	"net/http"
	"os"

	"log"

	"github.com/gin-gonic/gin"
)

//PORT=8080

func main() {

	log.Println("------------------------------- custom ----------------------------")

	hostname, err := os.Hostname()
	if err != nil {
		hostname = "UNKNOWN"
	}

	r := gin.Default()
	r.GET("/ping", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"message": "pong",
		})
	})

	r.GET("/", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"message": "hello world, I'm " + hostname,
		})
	})

	r.GET("/health", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"message": "healthy",
		})
	})
	r.Run() // listen and serve on 0.0.0.0:8080 (for windows "localhost:8080")
}
