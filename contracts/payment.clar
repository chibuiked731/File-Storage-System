;; Payment Contract

;; Define fungible token for payments
(define-fungible-token storage-token)

;; Define data structures
(define-map balances principal uint)

;; Error codes
(define-constant err-insufficient-balance (err u100))
(define-constant err-transfer-failed (err u101))

;; Functions
(define-public (deposit (amount uint))
  (let
    ((sender-balance (default-to u0 (map-get? balances tx-sender))))
    (try! (ft-transfer? storage-token amount tx-sender (as-contract tx-sender)))
    (map-set balances tx-sender (+ sender-balance amount))
    (ok true)
  )
)

(define-public (withdraw (amount uint))
  (let
    ((sender-balance (default-to u0 (map-get? balances tx-sender))))
    (asserts! (>= sender-balance amount) err-insufficient-balance)
    (try! (as-contract (ft-transfer? storage-token amount tx-sender tx-sender)))
    (map-set balances tx-sender (- sender-balance amount))
    (ok true)
  )
)

(define-public (pay (recipient principal) (amount uint))
  (let
    ((sender-balance (default-to u0 (map-get? balances tx-sender)))
     (recipient-balance (default-to u0 (map-get? balances recipient))))
    (asserts! (>= sender-balance amount) err-insufficient-balance)
    (map-set balances tx-sender (- sender-balance amount))
    (map-set balances recipient (+ recipient-balance amount))
    (ok true)
  )
)

(define-read-only (get-balance (account principal))
  (default-to u0 (map-get? balances account))
)

