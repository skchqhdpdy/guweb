#!/usr/bin/env make

build:
	docker build -t guweb:latest .

run:
	docker compose up guweb

run-bg:
	docker compose up -d guweb


last?=1000
logs:
	docker compose logs -f guweb --tail ${last}