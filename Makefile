REPO                      := onaio/python
PYTHON_VERSION          := 3.8

.PHONY: default clean clobber latest push

default: latest

.docker:
	mkdir -p $@

.docker/$(PYTHON_VERSION)-alpine-%: | .docker
	docker build \
	--build-arg PYTHON_VERSION=$(PYTHON_VERSION) \
	--iidfile $@ \
	--tag $(REPO):$(PYTHON_VERSION)-alpine-$* \
	--target $* \
	.

.docker/$(PYTHON_VERSION)-alpine: .docker/$(PYTHON_VERSION)-alpine-final
.docker/%:
	docker tag $$(cat $<) $(REPO):$*
	cp $< $@

clean:
	rm -rf .docker

clobber: clean
	docker image ls $(REPO) --quiet | uniq | xargs docker image rm --force

latest: .docker/$(PYTHON_VERSION)-alpine

push:
	-docker push $(REPO):$(PYTHON_VERSION)-alpine
