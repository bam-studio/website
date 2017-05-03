check-release:
ifndef BAMSTUDIO_RELEASE
		$(error BAMSTUDIO_RELEASE is undefined)
endif

set-release: check-release
ifdef BAMSTUDIO_RELEASE
release := $(BAMSTUDIO_RELEASE)-mongo$(shell head -n 1 Dockerfile | cut -d':' -f 2)
endif

docker:
	docker build -t bamstudio/mongo .

release: check-release docker set-release
	git tag $(release)
	git push origin $(release) 

release-dryrun: check-release docker set-release
	@echo git tag $(release)
	@echo git push origin $(release)
