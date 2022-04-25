.PHONY build deploy

build:
	docker-compose build --parallel

deploy:
	docker-compose up -d

stop:
	docker-compose stop
