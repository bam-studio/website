.check-release:
ifndef BAMSTUDIO_RELEASE
		$(error BAMSTUDIO_RELEASE is undefined)
endif

.docker-tags: .check-release
ifdef BAMSTUDIO_RELEASE
engine-release := $(BAMSTUDIO_RELEASE)-locomotivecms$(shell grep locomotive_cms engine/Gemfile.lock | head -n 1 | grep -oe '\d.\d.\d')
db-release := $(BAMSTUDIO_RELEASE)-mongo$(shell head -n 1 db/Dockerfile | cut -d':' -f 2)
endif

docker: .docker-tags
	docker build -t bamstudio/web ./engine
	docker tag bamstudio/web bamstudio/web:$(engine-release)
	docker build -t bamstudio/db ./db
	docker tag bamstudio/db bamstudio/db:$(db-release)

dryrun: .docker-tags
	@echo would\> docker build -t bamstudio/web ./engine
	@echo would\> docker tag bamstudio/web bamstudio/web:$(engine-release)
	@echo would\> docker build -t bamstudio/db ./db
	@echo would\> docker tag bamstudio/db bamstudio/db:$(db-release)

