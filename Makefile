PROJECT=myproject
BRANCH=main
REGISTRY=your.docker.registry/$(PROJECT)

.PHONY: docker docker-push start test


start:
	./scripts/start.sh

# Stage 1 image is used to avoid downloading 2 Gb of PyTorch + nlp models
# every time we build our container
docker-stage1:
	docker build -t $(REGISTRY)/$(PROJECT):stage1 -f Dockerfile.stage1 .
	docker push $(REGISTRY)/$(PROJECT):stage1


docker:
	docker build -t $(REGISTRY)/$(PROJECT):$(BRANCH) .


docker-push:
	docker push $(REGISTRY)/$(PROJECT):$(BRANCH)


test:
	JSON_LOGS=False ./scripts/test.sh
