# BankApp

A simple banking application written in Go, providing a RESTful API for managing users, accounts, and money transfers. The project uses PostgreSQL as the database and supports secure authentication with PASETO tokens.

## Features

- User registration and login with hashed passwords
- JWT/PASETO-based authentication middleware
- Account creation, retrieval, and listing (with pagination)
- Money transfer between accounts with transactional integrity
- Input validation and error handling
- Unit and integration tests with mocks
- Database migrations managed by [golang-migrate](https://github.com/golang-migrate/migrate)
- Docker and Docker Compose support for easy deployment

## Project Structure

```
.
├── api/           # HTTP handlers, middleware, and server setup
├── db/
│   ├── migration/ # Database migration files
│   ├── query/     # SQL queries for sqlc
│   └── sqlc/      # Generated Go code from sqlc
├── token/         # Token creation and verification (JWT, PASETO)
├── util/          # Utility functions (config, password, random, currency)
├── Dockerfile     # Docker build instructions
├── docker-compose.yaml # Docker Compose setup
├── main.go        # Application entry point
├── Makefile       # Useful development commands
└── README.md      # Project documentation
```

## Getting Started

### Prerequisites

- [Go](https://golang.org/doc/install) 1.24+
- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/)

### Running with Docker Compose

1. **Clone the repository:**
   ```sh
   git clone <your-repo-url>
   cd bankapp
   ```

2. **Create an `app.env` file** with your configuration (see below for required variables).

3. **Build and start the services:**
   ```sh
   docker-compose up --build
   ```

   This will start both the PostgreSQL database and the API server.

### Environment Variables

The application uses environment variables for configuration. Example `app.env`:

```
DB_DRIVER=postgres
DB_SOURCE=postgresql://root:secret@postgres:5432/simple_bank?sslmode=disable
SERVER_ADDRESS=0.0.0.0:8080
TOKEN_SYMMETRIC_KEY=your-32-char-secret-key
ACCESS_TOKEN_DURATION=15m
DB_USER=root
DB_PASSWORD=secret
```

### Database Migrations

To run migrations manually (requires [golang-migrate](https://github.com/golang-migrate/migrate)):

```sh
make migrateup
```

### Running Tests

```sh
make test
```

## API Endpoints

- `POST /users` - Register a new user
- `POST /users/login` - Login and receive an access token
- `POST /accounts` - Create a new account (authenticated)
- `GET /accounts/:id` - Get account details (authenticated)
- `GET /accounts` - List accounts with pagination (authenticated)
- `POST /transfers` - Transfer money between accounts (authenticated)

## Development

- SQL queries are defined in `db/query/` and Go code is generated using [sqlc](https://github.com/kyleconroy/sqlc).
- Mock implementations for testing are generated using [GoMock](https://github.com/golang/mock).
- Unit and integration tests are located alongside their respective packages.

## License

MIT License

---

**Note:** This project is for educational purposes and should not be used in production without further