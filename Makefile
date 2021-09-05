NAME = rs-status
VERSION ?= nil

GOOS ?= $(shell go env GOOS)
GOARCH ?= $(shell go env GOARCH)
LDFLAGS ?= -w -s -X 'main.programVersion=$(VERSION)'
MAIN_GO = ./cmd/rs-status.go


PREFIX ?= /usr/local

MAINTAINER ?= nil <nil>
SITE_URL = https://github.com/lcomrade/rs-status
SITE_RELEASE_URL = https://github.com/lcomrade/rs-status/releases/tag/v$(VERSION)


TMP_BUILD_DIR := /tmp/$(NAME)_build_$(shell head -c 100 /dev/urandom | base64 | sed 's/[+=/A-Z]//g' | tail -c 10)

.PHONY: all test release install uninstall deb rpm clean

all:
	mkdir -p dist/
	
	go build -ldflags="$(LDFLAGS)" -o dist/$(NAME).$(GOOS).$(GOARCH) $(MAIN_GO)
	chmod +x dist/$(NAME).$(GOOS).$(GOARCH)

test:
	go test -v ./...

install:
	mkdir -p $(DESTDIR)$(PREFIX)/bin/
	cp dist/$(NAME).$(GOOS).$(GOARCH) $(DESTDIR)$(PREFIX)/bin/$(NAME)

uninstall:
	rm $(DESTDIR)$(PREFIX)/bin/$(NAME)

release:
	#GNU/Linux 386, amd64, arm64
	GOOS=linux GOARCH=386   go build -ldflags="$(LDFLAGS)" -o dist/$(NAME).linux.386  $(MAIN_GO)
	GOOS=linux GOARCH=amd64 go build -ldflags="$(LDFLAGS)" -o dist/$(NAME).linux.amd64 $(MAIN_GO)
	GOOS=linux GOARCH=arm64 go build -ldflags="$(LDFLAGS)" -o dist/$(NAME).linux.arm64 $(MAIN_GO)

	GOOS=linux GOARCH=386   DEBARCH=i386  VERSION=$(VERSION) MAINTAINER="$(MAINTAINER)" make deb
	GOOS=linux GOARCH=amd64 DEBARCH=amd64 VERSION=$(VERSION) MAINTAINER="$(MAINTAINER)" make deb
	GOOS=linux GOARCH=arm64 DEBARCH=arm64 VERSION=$(VERSION) MAINTAINER="$(MAINTAINER)" make deb

	GOOS=linux GOARCH=386   RPMARCH=i386    VERSION=$(VERSION) MAINTAINER="$(MAINTAINER)" make rpm
	GOOS=linux GOARCH=amd64 RPMARCH=x86_64  VERSION=$(VERSION) MAINTAINER="$(MAINTAINER)" make rpm
	GOOS=linux GOARCH=arm64 RPMARCH=aarch64 VERSION=$(VERSION) MAINTAINER="$(MAINTAINER)" make rpm

	#GNU/Linux ARM
	GOOS=linux GOARCH=arm GOARM=5 go build -ldflags="$(LDFLAGS)" -o dist/$(NAME).linux.arm_v5 $(MAIN_GO)
	GOOS=linux GOARCH=arm GOARM=6 go build -ldflags="$(LDFLAGS)" -o dist/$(NAME).linux.arm_v6 $(MAIN_GO)
	GOOS=linux GOARCH=arm GOARM=7 go build -ldflags="$(LDFLAGS)" -o dist/$(NAME).linux.arm_v7 $(MAIN_GO)

	GOOS=linux GOARCH=arm_v5 GOARM=5 DEBARCH=armel  VERSION=$(VERSION) MAINTAINER="$(MAINTAINER)" make deb
	GOOS=linux GOARCH=arm_v7 GOARM=7 DEBARCH=armhf  VERSION=$(VERSION) MAINTAINER="$(MAINTAINER)" make deb

	#GNU/Linux MIPS
	GOOS=linux GOARCH=mips     go build -ldflags="$(LDFLAGS)" -o dist/$(NAME).linux.mips     $(MAIN_GO)
	GOOS=linux GOARCH=mipsle   go build -ldflags="$(LDFLAGS)" -o dist/$(NAME).linux.mipsle   $(MAIN_GO)
	GOOS=linux GOARCH=mips64le go build -ldflags="$(LDFLAGS)" -o dist/$(NAME).linux.mips64le $(MAIN_GO)

	GOOS=linux GOARCH=mips     DEBARCH=mips     VERSION=$(VERSION) MAINTAINER="$(MAINTAINER)" make deb
	GOOS=linux GOARCH=mipsle   DEBARCH=mipsel   VERSION=$(VERSION) MAINTAINER="$(MAINTAINER)" make deb
	GOOS=linux GOARCH=mips64le DEBARCH=mips64el VERSION=$(VERSION) MAINTAINER="$(MAINTAINER)" make deb

	#GNU/Linux PPC
	GOOS=linux GOARCH=ppc64    go build -ldflags="$(LDFLAGS)" -o dist/$(NAME).linux.ppc64   $(MAIN_GO)
	GOOS=linux GOARCH=ppc64le  go build -ldflags="$(LDFLAGS)" -o dist/$(NAME).linux.ppc64le $(MAIN_GO)

	GOOS=linux GOARCH=ppc64    DEBARCH=ppc64     VERSION=$(VERSION) MAINTAINER="$(MAINTAINER)" make deb
	GOOS=linux GOARCH=ppc64le  DEBARCH=ppc64el   VERSION=$(VERSION) MAINTAINER="$(MAINTAINER)" make deb

	#GNU/Linux RISC
	GOOS=linux GOARCH=riscv64  go build -ldflags="$(LDFLAGS)" -o dist/$(NAME).linux.riscv64 $(MAIN_GO)

	GOOS=linux GOARCH=riscv64  DEBARCH=riscv64   VERSION=$(VERSION) MAINTAINER="$(MAINTAINER)" make deb

	#GNU/Linux s390x
	GOOS=linux GOARCH=s390x  go build -ldflags="$(LDFLAGS)" -o dist/$(NAME).linux.s390x $(MAIN_GO)

	GOOS=linux GOARCH=s390x  DEBARCH=s390x   VERSION=$(VERSION) MAINTAINER="$(MAINTAINER)" make deb

	#BSD
	GOOS=freebsd GOARCH=386   go build -ldflags="$(LDFLAGS)" -o dist/$(NAME).freebsd.386   $(MAIN_GO)
	GOOS=freebsd GOARCH=amd64 go build -ldflags="$(LDFLAGS)" -o dist/$(NAME).freebsd.amd64 $(MAIN_GO)
	GOOS=freebsd GOARCH=arm   go build -ldflags="$(LDFLAGS)" -o dist/$(NAME).freebsd.arm   $(MAIN_GO)
	GOOS=freebsd GOARCH=arm64 go build -ldflags="$(LDFLAGS)" -o dist/$(NAME).freebsd.arm64 $(MAIN_GO)

	GOOS=openbsd GOARCH=386   go build -ldflags="$(LDFLAGS)" -o dist/$(NAME).openbsd.386   $(MAIN_GO)
	GOOS=openbsd GOARCH=amd64 go build -ldflags="$(LDFLAGS)" -o dist/$(NAME).openbsd.amd64 $(MAIN_GO)
	GOOS=openbsd GOARCH=arm   go build -ldflags="$(LDFLAGS)" -o dist/$(NAME).openbsd.arm   $(MAIN_GO)
	GOOS=openbsd GOARCH=arm64 go build -ldflags="$(LDFLAGS)" -o dist/$(NAME).openbsd.arm64 $(MAIN_GO)

	GOOS=netbsd GOARCH=386    go build -ldflags="$(LDFLAGS)" -o dist/$(NAME).netbsd.386   $(MAIN_GO)
	GOOS=netbsd GOARCH=amd64  go build -ldflags="$(LDFLAGS)" -o dist/$(NAME).netbsd.amd64 $(MAIN_GO)
	GOOS=netbsd GOARCH=arm    go build -ldflags="$(LDFLAGS)" -o dist/$(NAME).netbsd.arm   $(MAIN_GO)
	GOOS=netbsd GOARCH=arm64  go build -ldflags="$(LDFLAGS)" -o dist/$(NAME).netbsd.arm64 $(MAIN_GO)

	#UNIX-like
	GOOS=darwin GOARCH=amd64  go build -ldflags="$(LDFLAGS)" -o dist/$(NAME).darwin.amd64 $(MAIN_GO)

	GOOS=plan9 GOARCH=386   go build -ldflags="$(LDFLAGS)" -o dist/$(NAME).plan9.386   $(MAIN_GO)
	GOOS=plan9 GOARCH=amd64 go build -ldflags="$(LDFLAGS)" -o dist/$(NAME).plan9.amd64 $(MAIN_GO)
	GOOS=plan9 GOARCH=arm   go build -ldflags="$(LDFLAGS)" -o dist/$(NAME).plan9.arm   $(MAIN_GO)

	GOOS=solaris GOARCH=amd64 go build -ldflags="$(LDFLAGS)" -o dist/$(NAME).solaris.amd64 $(MAIN_GO)
	
deb:
	mkdir -p $(TMP_BUILD_DIR)/$(NAME).$(GOOS).$(GOARCH)/DEBIAN/
	
	mkdir -p $(TMP_BUILD_DIR)/$(NAME).$(GOOS).$(GOARCH)/usr/share/doc/$(NAME)/
	cp README.md $(TMP_BUILD_DIR)/$(NAME).$(GOOS).$(GOARCH)/usr/share/doc/$(NAME)/
	
	echo 'Package: $(NAME)' > $(TMP_BUILD_DIR)/$(NAME).$(GOOS).$(GOARCH)/DEBIAN/control
	echo 'Provides: $(NAME)' >> $(TMP_BUILD_DIR)/$(NAME).$(GOOS).$(GOARCH)/DEBIAN/control
	echo 'Version: $(VERSION)' >> $(TMP_BUILD_DIR)/$(NAME).$(GOOS).$(GOARCH)/DEBIAN/control
	echo 'Architecture: $(DEBARCH)' >> $(TMP_BUILD_DIR)/$(NAME).$(GOOS).$(GOARCH)/DEBIAN/control
	bash -c 'if [ "$(DEBARCH)" == "amd64" ]; then echo "Depends: libc6" >> $(TMP_BUILD_DIR)/$(NAME).$(GOOS).$(GOARCH)/DEBIAN/control; fi'
	echo 'Priority: optional' >> $(TMP_BUILD_DIR)/$(NAME).$(GOOS).$(GOARCH)/DEBIAN/control
	echo 'Section: net' >> $(TMP_BUILD_DIR)/$(NAME).$(GOOS).$(GOARCH)/DEBIAN/control
	echo 'Maintainer: $(MAINTAINER)' >> $(TMP_BUILD_DIR)/$(NAME).$(GOOS).$(GOARCH)/DEBIAN/control
	echo 'Origin: $(SITE_URL)' >> $(TMP_BUILD_DIR)/$(NAME).$(GOOS).$(GOARCH)/DEBIAN/control
	echo 'Description: Utility that display the status of Internet resources' >> $(TMP_BUILD_DIR)/$(NAME).$(GOOS).$(GOARCH)/DEBIAN/control
	echo ' rs-status displays the status of the online resource and its components.' >> $(TMP_BUILD_DIR)/$(NAME).$(GOOS).$(GOARCH)/DEBIAN/control
	echo ' The program uses the statuspage.io API v2.' >> $(TMP_BUILD_DIR)/$(NAME).$(GOOS).$(GOARCH)/DEBIAN/control

	echo '$(NAME) ($(VERSION)) stable; urgency=medium' > $(TMP_BUILD_DIR)/$(NAME).$(GOOS).$(GOARCH)/usr/share/doc/$(NAME)/changelog
	echo '  ' >> $(TMP_BUILD_DIR)/$(NAME).$(GOOS).$(GOARCH)/usr/share/doc/$(NAME)/changelog
	echo '  * $(SITE_RELEASE_URL)' >> $(TMP_BUILD_DIR)/$(NAME).$(GOOS).$(GOARCH)/usr/share/doc/$(NAME)/changelog
	echo '  ' >> $(TMP_BUILD_DIR)/$(NAME).$(GOOS).$(GOARCH)/usr/share/doc/$(NAME)/changelog
	echo ' -- $(MAINTAINER)  $(shell date -R)' >> $(TMP_BUILD_DIR)/$(NAME).$(GOOS).$(GOARCH)/usr/share/doc/$(NAME)/changelog

	gzip -9 --no-name --force $(TMP_BUILD_DIR)/$(NAME).$(GOOS).$(GOARCH)/usr/share/doc/$(NAME)/changelog


	DESTDIR=$(TMP_BUILD_DIR)/$(NAME).$(GOOS).$(GOARCH) PREFIX=/usr make install

	bash -c "cd $(TMP_BUILD_DIR)/$(NAME).$(GOOS).$(GOARCH)/ && md5deep -r -l usr/ > DEBIAN/md5sums"

	fakeroot dpkg-deb --build $(TMP_BUILD_DIR)/$(NAME).$(GOOS).$(GOARCH)

	mv $(TMP_BUILD_DIR)/*.deb dist/$(NAME)_$(VERSION)_$(DEBARCH).deb
	
	rm -rf $(TMP_BUILD_DIR)/

rpm:
	mkdir -p $(TMP_BUILD_DIR)/BUILDROOT/$(NAME)-$(VERSION)-1.$(RPMARCH)/
	mkdir -p $(TMP_BUILD_DIR)/SPECS/

	mkdir -p $(TMP_BUILD_DIR)/BUILDROOT/$(NAME)-$(VERSION)-1.$(RPMARCH)/usr/share/doc/$(NAME)/
	cp README.md $(TMP_BUILD_DIR)/BUILDROOT/$(NAME)-$(VERSION)-1.$(RPMARCH)/usr/share/doc/$(NAME)/

	echo 'Name: $(NAME)' > $(TMP_BUILD_DIR)/SPECS/$(NAME).spec
	echo 'Version: $(VERSION)' >> $(TMP_BUILD_DIR)/SPECS/$(NAME).spec
	echo 'Release: 1' >> $(TMP_BUILD_DIR)/SPECS/$(NAME).spec
	echo 'Summary: Utility that display the status of Internet resources' >> $(TMP_BUILD_DIR)/SPECS/$(NAME).spec
	echo 'Packager: $(MAINTAINER)' >> $(TMP_BUILD_DIR)/SPECS/$(NAME).spec
	echo 'License: GPLv3+' >> $(TMP_BUILD_DIR)/SPECS/$(NAME).spec
	echo 'URL: $(SITE_URL)' >> $(TMP_BUILD_DIR)/SPECS/$(NAME).spec
	echo '' >> $(TMP_BUILD_DIR)/SPECS/$(NAME).spec
	echo '%description' >> $(TMP_BUILD_DIR)/SPECS/$(NAME).spec
	echo 'rs-status displays the status of the online resource and its components.' >> $(TMP_BUILD_DIR)/SPECS/$(NAME).spec
	echo 'The program uses the statuspage.io API v2.' >> $(TMP_BUILD_DIR)/SPECS/$(NAME).spec
	echo '%files' >> $(TMP_BUILD_DIR)/SPECS/$(NAME).spec
	echo '%defattr(-,root,root)' >> $(TMP_BUILD_DIR)/SPECS/$(NAME).spec
	echo '/usr/bin/*' >> $(TMP_BUILD_DIR)/SPECS/$(NAME).spec
	echo '%doc /usr/share/doc/$(NAME)/*' >> $(TMP_BUILD_DIR)/SPECS/$(NAME).spec
	echo '' >> $(TMP_BUILD_DIR)/SPECS/$(NAME).spec
	echo '%changelog' >> $(TMP_BUILD_DIR)/SPECS/$(NAME).spec
	echo '* $(shell date "+%a %b %d %Y") $(MAINTAINER) - $(VERSION)-1' >> $(TMP_BUILD_DIR)/SPECS/$(NAME).spec
	echo '- $(SITE_RELEASE_URL)' >> $(TMP_BUILD_DIR)/SPECS/$(NAME).spec

	DESTDIR=$(TMP_BUILD_DIR)/BUILDROOT/$(NAME)-$(VERSION)-1.$(RPMARCH) PREFIX=/usr make install
	
	
	BUILDROOT=$(TMP_BUILD_DIR)/BUILDROOT rpmbuild --target $(RPMARCH) --define '_topdir $(TMP_BUILD_DIR)' -bb $(TMP_BUILD_DIR)/SPECS/$(NAME).spec

	mv $(TMP_BUILD_DIR)/RPMS/$(RPMARCH)/*.rpm dist/

	rm -rf $(TMP_BUILD_DIR)/

clean:
	rm -rf dist/
	rm -rf /tmp/$(NAME)_build_*
