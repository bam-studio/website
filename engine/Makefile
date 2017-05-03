check-release:
ifndef BAMSTUDIO_RELEASE
		$(error BAMSTUDIO_RELEASE is undefined)
endif

set-release: check-release
ifdef BAMSTUDIO_RELEASE
release := $(BAMSTUDIO_RELEASE)-engine$(shell docker run --rm -it bamstudio/backend bundle show locomotive_cms | cut -c 29-)
endif

localhost:
	docker-compose up --remove-orphans

docker:
	docker build -t bamstudio/backend .

release: check-release docker set-release
	git tag $(release)
	git push origin $(release) 

release-dryrun: check-release docker set-release
	@echo git tag $(release)
	@echo git push origin $(release)
