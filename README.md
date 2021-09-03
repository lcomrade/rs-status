## Description
**rs-status** is utility that allows you to see the availability of popular services from the terminal.
Many popular services are supported, such as GitHub, Dropbox, DigitalOcean, Discord, Reddit, and others.

## How it works
All of the above services use the status page from Atlassian (statuspage.io).
This program retrieves information from the public status API and outputs it to the terminal.

## Usage
Get detailed information about one service:
```
rs-status -format="long" -target="GitHub"
```

Get short information about many services:
```
rs-status -format="short" -target="GitHub DigitalOcean Discord"
```

Get short information of all known services:
```
rs-status -format="short" -target="all"
```

Read more in the help:
```
rs-status -help
```

## Bugs and Suggestion
If you find a bug or have a suggestion, create an Issue [here](https://github.com/lcomrade/rs-status/issues)
