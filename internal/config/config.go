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
		Name: "CircleCI",
		URL:  "https://status.circleci.com",
	},
	{
		Name: "Codecov",
		URL:  "https://status.codecov.com",
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
		Name: "EpicGames",
		URL:  "https://status.epicgames.com",
	},
	{
		Name: "GitHub",
		URL:  "https://www.githubstatus.com",
	},
	{
		Name: "npm",
		URL:  "https://status.npmjs.org",
	},
	{
		Name: "Intercom",
		URL:  "https://www.intercomstatus.com",
	},
	{
		Name: "reddit",
		URL:  "https://www.redditstatus.com",
	},
	{
		Name: "TravisCI",
		URL:  "https://www.traviscistatus.com",
	},
	{
		Name: "Twitch",
		URL:  "https://status.twitch.tv",
	},
	{
		Name: "Twitter",
		URL:  "https://api.twitterstat.us",
	},
	{
		Name: "Zoom",
		URL:  "https://status.zoom.us",
	},
}
