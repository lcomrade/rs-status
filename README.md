[![Go report](https://goreportcard.com/badge/github.com/lcomrade/rs-status?style=flat-square)](https://goreportcard.com/report/github.com/lcomrade/rs-status)
[![Release](https://img.shields.io/github/downloads/lcomrade/rs-status/total?style=flat-square)](https://github.com/lcomrade/rs-status/releases/latest)
[![License](https://img.shields.io/github/license/lcomrade/rs-status?style=flat-square)](https://github.com/lcomrade/rs-status/blob/main/LICENSE)

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

## Installation
### GNU/Linux
Under Linux there are several options available. All of them can be found on the [release page](https://github.com/lcomrade/rs-status/releases/latest):
- DEB
- RPM
- Lonely binary

### Windows
Installers, Choco and Scoop manifest packages for Windows starting with version 0.2 are no longer created.
The only available installation method is to use the zip archive from the [release page](https://github.com/lcomrade/rs-status/releases/latest).

### Another UNIX-like systems
1. Download a binary file for your OS and architecture from the [release page](https://github.com/lcomrade/rs-status/releases/latest)
2. Make the program executable
3. Place program in `/usr/local/bin/` or in another directory provided for installing binary files

## Documentation
- [Building on UNIX-like systems](https://github.com/lcomrade/rs-status/blob/main/docs/make.md)

## Bugs and Suggestion
If you find a bug or have a suggestion, create an Issue [here](https://github.com/lcomrade/rs-status/issues)
