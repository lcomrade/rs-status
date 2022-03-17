# Adding custom pages
At the moment, there is only one way to add custom pages - editing the source code of the program.

## Adding custom page in source code
Add your page to the file `./cmd/rs-status_config.go`:
```
var ApiList = []ApiListType{
	{
		Name: "GitHub",
		URL:  "https://www.githubstatus.com",
	},
	// Other pages
}
```

*Attention:*
- Pages in the list should be in alphabetical order
- The `Name` must not contain spaces
- The `URL` must begin with `http://` or `https://`
- The `URL` must not end in `/`

## Adding to main repo
To add your page to the main repository for this you can create a **pull request or issue**.
