package token

import (
	"errors"
	"time"

	"github.com/golang-jwt/jwt/v5"
	"github.com/google/uuid"
)

// diffrenet tpye of error returned by the VerifyToken function
var (
	ErrInvalidToken = errors.New("token is invalid")
	ErrTokenExpired = errors.New("token is expired")
)

// Payload contains the payload data of the token
type Payload struct {
	ID			uuid.UUID	`json:"id"`
	Username	string		`json:"username"`
	IssuedAt	time.Time	`json:"issued_at"`
	ExpiredAt	time.Time	`json:"expired_at"`	
	jwt.RegisteredClaims
}

// NewPayload creates a new token payload with a specific username and duration
func NewPayload(username string, duration time.Duration) (*Payload, error) {
	tokenId, err := uuid.NewRandom()

	if err != nil {
		return nil, err
	}

	payload := &Payload{
		ID:	tokenId,
		Username: username,
		IssuedAt: time.Now(),
		ExpiredAt: time.Now().Add(duration),

	}
	return payload, nil
}

// Valid checks for the token payload is valid or not
func (payload *Payload) Valid() error {
	if time.Now().After(payload.ExpiredAt) {
		return ErrTokenExpired
	}
	return nil
}