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
		Name: "Coinbase",
		URL:  "https://status.coinbase.com",
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
		Name: "Mozilla",
		URL:  "https://status.mozilla.org",
	},
	{
		Name: "NewRelic",
		URL:  "https://status.newrelic.com",
	},
	{
		Name: "Notion",
		URL:  "https://status.notion.so",
	},
	{
		Name: "npm",
		URL:  "https://status.npmjs.org",
	},
	{
		Name: "PinterestAds",
		URL:  "https://www.pintereststatus.com",
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
		Name: "RedHat",
		URL:  "https://status.redhat.com",
	},
	{
		Name: "Segment",
		URL:  "https://status.segment.com",
	},
	{
		Name: "Squarespace",
		URL:  "https://status.squarespace.com",
	},
	{
		Name: "TravisCI",
		URL:  "https://www.traviscistatus.com",
	},
	{
		Name: "Twilio",
		URL:  "https://status.twilio.com",
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
		Name: "Typeform",
		URL:  "https://status.typeform.com",
	},
	{
		Name: "Zoom",
		URL:  "https://status.zoom.us",
	},
}
