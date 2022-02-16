package main

import (
	"flag"
	"fmt"
	"os"

	"github.com/tenfyzhong/gengotag/gentag"
)

var (
	tagtype   = ""
	jsondata  = ""
	omitempty = false
)

func init() {
	flag.StringVar(&tagtype, "type", "json", "type of tag")
	flag.StringVar(&jsondata, "jsondata", "", "the jsondata to read")
	flag.BoolVar(&omitempty, "omitempty", false, "omitempty tag")
	flag.Parse()
}

func main() {
	data := []byte(jsondata)
	text, err := gentag.Gen(data, tagtype, omitempty)
	if err != nil {
		fmt.Fprintf(os.Stderr, "%v\n", err)
		os.Exit(3)
	}
	fmt.Printf("%s", text)
}
