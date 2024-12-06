.PHONY: up down build clean

all: build up

build:
	docker-compose -f ../data/srcs/docker-compose.yml build

up:
	docker-compose -f ../data/srcs/docker-compose.yml up -d 

down:
	docker-compose -f ../data/srcs/docker-compose.yml down

clean: down
	docker-compose -f ../data/srcs/docker-compose.yml rm -f
	docker volume prune -f
