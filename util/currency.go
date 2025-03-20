package util

// Constants for all supported currencies
const (
	USD = "USD"
	EUR = "EUR"
	MAD = "MAD"
)

// IsSupportedCurrency returns true if the currency is supported
func IsSupportedCurrency(currency string) bool {
	switch currency {
	case USD, EUR, MAD:
		return true
	}
	return false
}
