//  This file is part of rs-status.

//  rs-status is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.

//  rs-status is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.

//  You should have received a copy of the GNU General Public License
//  along with rs-status.  If not, see <https://www.gnu.org/licenses/>.

package main

import (
	"../internal/config"
	"encoding/json"
	"flag"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"os"
	"strings"
)

// Logining
var logWarning = log.New(os.Stdout, colorYellow+"Warning:"+colorNormal+" ", log.Lshortfile)
var logError = log.New(os.Stderr, colorRed+"Error:"+colorNormal+" ", log.Lshortfile)

// Console colors
var (
	colorGreen  = "\033[1;32m"
	colorYellow = "\033[1;33m"
	colorRed    = "\033[1;31m"
	colorCyan   = "\033[1;36m"

	colorNormal = "\033[0m"
)

// Used API v2
type APIsummary struct {
	Page       APIpage         `json:page`
	Components []APIcomponents `json:components`
	Status     APIstatus       `json:status`
}

type APIpage struct {
	//ID string `json:id`
	Name string `json:name`
	//URL string `json:url`
	//TimeZone string `json:time_zone`
	//UpdatedAt string `json:updated_at`
}

type APIcomponents struct {
	//ID string `json:id`
	Name   string `json:name`
	Status string `json:status`
	//CreatedAt string `json:created_at`
	//UpdatedAt string `json:updated_at`
	//Position int64 `json:position`
	Description string `json:description`
	//Showcase bool `json:showcase`
	//StartDate string `json:start_date`
	//GroupID string `json:group_id`
	//PageID string `json:page_id`
	//Group bool `json:group`
	//OnlyShowIfDegraded bool `json:only_show_if_degraded`
}

type APIstatus struct {
	//Indicator string `json:indicator`
	Description string `json:description`
}

// Receiving raw API data
func GetApiAnswer(url string) []byte {
	resp, err := http.Get(url)
	if err != nil {
		logWarning.Println(err)
	}

	out, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		logWarning.Println(err)
	}

	return out
}

// Parsing raw API data
func ParseApiAnswer(jsonData []byte) APIsummary {
	var out APIsummary

	err := json.Unmarshal(jsonData, &out)
	if err != nil {
		logWarning.Println(err)
	}

	return out
}

// Print status
func PrintStatusShort(api APIsummary) {
	if api.Status.Description == "All Systems Operational" {
		fmt.Println(colorGreen+"["+api.Status.Description+"]"+colorNormal, api.Page.Name)
	} else {
		fmt.Println(colorYellow+"["+api.Status.Description+"]"+colorNormal, api.Page.Name)
	}
}

func PrintStatusDetails(api APIsummary) {
	fmt.Println(colorCyan+"Name:"+colorNormal, api.Page.Name)
	fmt.Println("")

	for i := range api.Components {
		// Green
		if api.Components[i].Status == "operational" {
			fmt.Println(" "+colorGreen+"[Operational]"+colorNormal, api.Components[i].Name)

			// Yellow
		} else if api.Components[i].Status == "degraded_performance" {
			fmt.Println(" "+colorYellow+"[Degraded Performance]"+colorNormal, api.Components[i].Name)

		} else if api.Components[i].Status == "partial_outage" {
			fmt.Println(" "+colorYellow+"[Partial Outage]"+colorNormal, api.Components[i].Name)

			// Red
		} else if api.Components[i].Status == "major_outage" {
			fmt.Println(" "+colorRed+"[Major Outage]"+colorNormal, api.Components[i].Name)
		}
	}

	fmt.Println("")
	if api.Status.Description == "All Systems Operational" {
		fmt.Println(colorCyan+"Description:"+colorNormal, colorGreen+api.Status.Description+colorNormal)
	} else {
		fmt.Println(colorCyan+"Description:"+colorNormal, colorYellow+api.Status.Description+colorNormal)
	}
}

func StatusChecker(ii int, format string) {
	rawApiData := GetApiAnswer(config.ApiList[ii].URL + "/api/v2/summary.json")
	apiData := ParseApiAnswer(rawApiData)

	if format == "short" {
		PrintStatusShort(apiData)
		return
	}

	if format == "long" {
		PrintStatusDetails(apiData)
		return

	}

	logError.Fatal("Unknown format '" + format + "'")
}

func main() {
	// Flags
	argList := flag.Bool("list", false, "Print a list of known pages")
	argTarget := flag.String("target", "", "Names of pages to be checked, separated by spacing")
	argFormat := flag.String("format", "short", "Console output format. (short | long)")
	argNoColors := flag.Bool("no-colors", false, "Disable colorized console output")
	argHelp := flag.Bool("help", false, "Show help and exit")

	flag.Parse()

	// -no-colors
	if *argNoColors == true {
		logWarning = log.New(os.Stdout, "Warning: ", log.Lshortfile)
		logError = log.New(os.Stderr, "Error: ", log.Lshortfile)

		colorGreen = ""
		colorYellow = ""
		colorRed = ""
		colorCyan = ""

		colorNormal = ""
	}

	// -list flag
	if *argList == true {
		for i := range config.ApiList {
			fmt.Println(config.ApiList[i].Name)
		}

		os.Exit(0)
	}

	// -help flag
	if *argHelp == true {
		flag.PrintDefaults()
		os.Exit(0)
	}

	// Checking pages status
	if *argTarget == "" || *argTarget == "all" {
		for ii := range config.ApiList {
			StatusChecker(ii, *argFormat)
		}

	} else {
		targetPages := strings.Fields(*argTarget)

		for i := range targetPages {
			for ii := range config.ApiList {
				if targetPages[i] == config.ApiList[ii].Name {
					StatusChecker(ii, *argFormat)
					break
				}
			}
		}
	}
}
