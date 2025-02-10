;; Node Reputation Contract

;; Define data structures
(define-map node-reputations
  { node: principal }
  { reputation: uint }
)

;; Error codes
(define-constant err-node-not-found (err u100))

;; Functions
(define-public (register-node)
  (ok (map-set node-reputations { node: tx-sender } { reputation: u0 }))
)

(define-public (update-reputation (new-reputation uint))
  (match (map-get? node-reputations { node: tx-sender })
    node-data (ok (map-set node-reputations { node: tx-sender } { reputation: new-reputation }))
    (err err-node-not-found)
  )
)

(define-read-only (get-node-reputation (node principal))
  (map-get? node-reputations { node: node })
)

