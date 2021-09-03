package config

type ApiListType struct {
	Name string
	URL  string
}

var ApiList = []ApiListType{
	{
		Name: "Atlassian",
		URL:  "https://status.atlassian.com",
	},
	{
		Name: "DigitalOcean",
		URL:  "https://status.digitalocean.com",
	},
	{
		Name: "Discord",
		URL:  "https://discordstatus.com",
	},
	{
		Name: "Dropbox",
		URL:  "https://status.dropbox.com",
	},
	{
		Name: "GitHub",
		URL:  "https://www.githubstatus.com",
	},
	{
		Name: "Intercom",
		URL:  "https://www.intercomstatus.com",
	},
	{
		Name: "reddit",
		URL: "https://www.redditstatus.com",
	},
}
