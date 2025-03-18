SHELL := /bin/bash
include app.env

postgres:
	docker run --name pg -p 5432:5432 -e POSTGRES_USER=$(DB_USER) -e POSTGRES_PASSWORD=$(DB_PASSWORD) -d postgres

createdb:
	docker exec -it pg createdb --username=$(DB_USER) --owner=$(DB_USER) bankapp

dropdb:
	docker exec -it pg dropdb bankapp

migrateup1:
	migrate -path db/migration/ -database="$(DB_SOURCE)" -verbose up 1

migrateup:
	migrate -path db/migration/ -database="$(DB_SOURCE)" -verbose up

migratedown:
	migrate -path db/migration/ -database="$(DB_SOURCE)" -verbose down

migratedown1:
	migrate -path db/migration/ -database="$(DB_SOURCE)" -verbose down 1

sqlc:
	sqlc generate

server:
	go run main.go

purge:
	docker stop pg
	docker rm pg

test:
	go test -v ./...

mock:
	mockgen -package mockdb -destination=./db/mock/store.go github.com/ajemraou/bankapp/db/sqlc Store

.PHONY: postgres createdb dropdb purge test server mock migrateup migratedown migrateup1 migratedown1
