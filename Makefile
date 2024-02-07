appname = drag.app
archivedir = .archive
installdir = ~/Applications

archiveout = $(archivedir).xcarchive
installout = $(installdir)/$(appname)
sources = $(shell find . -name '*.swift' -type f)

newest = $(shell ls -dt $(1) | head -1)

.PHONY: install
install: $(installout)

$(installout): archive
	@rm -rf $(installout)
	@cp -r $(archiveout)/Products/Applications/$(appname)/ $(installout)
	@echo INSTALLED

.PHONY: archive
archive: $(archiveout)

$(archiveout): $(sources)
	@echo ARCHIVING ...
	@xcodebuild -scheme drag -archivePath $(archivedir) archive >/dev/null
	@echo ARCHIVE DONE

.PHONY: clean
clean:
	@trash $(archiveout)

.PHONY: clean-derived-data
clean-derived-data:
	@rm -rf ~/Library/Developer/Xcode/DerivedData
	
