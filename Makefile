SHELL := /bin/bash

postgres:
	docker run --name pg -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres

createdb:
	docker exec -it pg createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it pg dropdb simple_bank

migrateup:
	migrate -path db/migration/ -database="postgres://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration/ -database="postgres://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down


sqlc:
	sqlc generate

server:
	go run main.go

purge:
	docker stop pg
	docker rm pg

test:
	go test -v -cover ./...

mock:
	mockgen -package mockdb -destination=./db/mock/store.go github.com/ajemraou/bankapp/db/sqlc Store

tst:
	ls -la && cat app.env

.PHONY: postgres createdb dropdb purge test server mock
