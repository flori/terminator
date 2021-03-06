package main

import (
	"log"

	ps "github.com/shirou/gopsutil/v3/process"
)

var Executable = "/foo/bar/PleaseKillMeNow"

func main() {
	var procs []*ps.Process

	procs, err := ps.Processes()
	if err != nil {
		log.Fatalf("Could not fetch processes: %v", err)
	}

	log.Printf("Scanning for processes executing \"%s\"…", Executable)
	for _, p := range procs {
		cl, _ := p.CmdlineSlice()
		if len(cl) < 1 {
			continue
		}
		if Executable == cl[0] {
			log.Printf("Terminating process with pid %d running \"%s\" now.", p.Pid, Executable)
			p.Terminate()
		}
	}
}
