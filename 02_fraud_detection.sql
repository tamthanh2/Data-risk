WITH tx_with_location AS (
    SELECT 
        t1.card_id,
        t1.id AS transaction_id,
        t1.date AS current_tx_date,
        t1.amount,
        t1.merchant_state AS current_state,
        t2.merchant_state AS other_state
    FROM banking.transactions t1
    INNER JOIN banking.transactions t2 ON t1.card_id = t2.card_id 
    WHERE DATEDIFF(minute, t2.date, t1.date) BETWEEN 0 AND 1440
)
SELECT 
    card_id,
    transaction_id,
    current_tx_date,
    amount,
    current_state,
    COUNT(DISTINCT other_state) AS so_bang_giao_dich_24h
FROM tx_with_location
GROUP BY card_id, transaction_id, current_tx_date, amount, current_state
HAVING COUNT(DISTINCT other_state) >= 5
ORDER BY card_id, current_tx_date;
