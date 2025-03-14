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

purge:
	docker stop pg
	docker rm pg

test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb purge test