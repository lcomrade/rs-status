`NOTE:` If you need **build and installation example**, see the 'Example' section.

# Environment variables
It is not necessary to specify those environment variables for which a default value is specified.

## Configuration
`VERSION` - specifies the version (default: `nil`)

`MAINTAINER` - name of the package maintainer (default: `nil`)

## Go compiler parameters
`GO` - path to Go compiler (default: `go`)

To get a complete list of architectures and OS run `go tool dist list`.

`GOOS` - specifies the OS (default: current OS)

`GOARCH` - specifies the arch (default: current arch)

To get the full list of ldfalgs run `go tool link -ldfalgs`.

`LDFLAGS` - go compiler flags (default: `-w -s -X 'main.programVersion=$(VERSION)'`)

## Inno Setup and 7-Zip
`ISCC` - path to ISCC compiler (default: `ISCC`)

`ZIP` - path to 7z.exe (default: `7z`)

## Installation paths
`DESTDIR` - installation path (default: `%WINDIR%`)

# Make targets
After the build, the program and documentation will appear in the `./dist` directory.

## make configure
Configures the project and prepares it for build.

**Environment variables**: `VERSION`, `MAINTAINER`

## make
Build project.

**Environment variables**: `GO`, `GOOS`, `GOARCH`, `LDFLAGS`

## make release
Builds a project for all supported arch and OS, creates packages.

**Environment variables**: `GO`, `LDFLAGS`

**Dependencies**: `make configure`

## make install
Installs program.

**Environment variables**: `DESTDIR`, `GOOS`, `GOARCH`

**Dependencies**: `make`

## make uninstall
Uninstalls program.

**Environment variables**: `DESTDIR`

## make installer
Builds the installer using Inno Setup.

**Environment variables**: `ISCC`, `GOARCH`

**Dependencies**: `make`

## make choco
Builds nupkg package for chocolatey.

**Environment variables**: `VERSION`

**Dependencies**: `make`

## make scoop
Create a json manifest for scoop.

**Environment variables**: `VERSION`

**Dependencies**: `make`

## make clean
Deletes all files created during configuration and build.

# Example
1. **Set go.exe location:** `set GO="C:\go\bin\go.exe"`
2. **Create binary file:** `make`
3. **Install:** `make install`
