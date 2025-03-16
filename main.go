package main

import (
	"database/sql"
	"log"

	_ "github.com/lib/pq"

	"github.com/ajemraou/bankapp/api"
	db "github.com/ajemraou/bankapp/db/sqlc"
	"github.com/ajemraou/bankapp/util"
)

func main() {
	config, err := util.LoadConfig(".")
	if err != nil {
		log.Fatal("cannot load config")
	}
	conn, err := sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	store := db.NewStore(conn)
	server := api.NewServer(store)

	err = server.Start(config.ServerAddress)
	if err != nil {
		log.Fatal("cannot start server:", err)
	}

}