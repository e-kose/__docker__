.PHONY: up down build clean

all: build up

build:
	docker-compose -f /srcs/docker-compose.yml build

up:
	docker-compose -f /srcs/docker-compose.yml up -d 

down:
	docker-compose -f /srcs/docker-compose.yml down

clean:down
	docker-compose -f srcs/docker-compose.yml rm -f
    docker volume prune -f

	wget -c -O "Halo.S02E01.1080p.HEVC.x265-MeGusta%5Beztv.re%5D.mkv" -t 20 "https://www.2embed.skin/tv/tt2934286&s=1&e=1"