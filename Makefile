USER_NAME=asazanoff

all: build push

build:
	cd src/ui && bash docker_build.sh
	cd src/post-py && bash docker_build.sh 
	cd src/comment && bash docker_build.sh
	cd monitoring/prometheus && bash docker_build.sh 

push:
	docker push $(USER_NAME)/ui
	docker push $(USER_NAME)/comment
	docker push $(USER_NAME)/post
	docker push $(USER_NAME)/prometheus
