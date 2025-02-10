;; Storage Contract

;; Define data structures
(define-map files
  { file-id: uint }
  {
    owner: principal,
    name: (string-utf8 64),
    hash: (buff 32)
  }
)

(define-data-var next-file-id uint u1)

;; Error codes
(define-constant err-unauthorized (err u100))
(define-constant err-file-not-found (err u101))

;; Functions
(define-public (store-file (name (string-utf8 64)) (hash (buff 32)))
  (let
    ((file-id (var-get next-file-id)))
    (map-set files
      { file-id: file-id }
      {
        owner: tx-sender,
        name: name,
        hash: hash
      }
    )
    (var-set next-file-id (+ file-id u1))
    (ok file-id)
  )
)

(define-read-only (get-file (file-id uint))
  (map-get? files { file-id: file-id })
)

