package main

import "time"

func main() {
	time.Sleep(time.Duration(1<<63 - 1))
}
