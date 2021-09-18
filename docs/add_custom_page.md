# Adding custom pages
At the moment, there is only one way to add custom pages - by editing the source code of the program.

## Build
**1.** Getting the source code: `git clone https://github.com/lcomrade/rs-status.git`

**2.** `cd ./rs-status/`

**3.** Add your page to the file `./internal/config/config.go`:
```
var ApiList = []ApiListType{
	{
		Name: "GitHub",
		URL:  "https://www.githubstatus.com",
	},
}
```

*Attention:*
 - The `Name` must not contain spaces
 - The `URL` must begin with `http://` or `https://`
 - The `URL` must not end in `/`

**4.** Install `golang` and `make`

**5.** Run: `make`

**6.** The binary is located in the directory: `./dist`

## Adding to main repo
To add your page to the main repository for this you can create a **pull request or issue**.
