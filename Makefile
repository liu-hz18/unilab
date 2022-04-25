.PHONY: build deploy

pull:
	git clone git@git.tsinghua.edu.cn:graduation-project/unilab.git --recurse-submodules

build:
	docker-compose build --parallel

deploy:
	docker-compose up -d

stop:
	docker-compose stop
