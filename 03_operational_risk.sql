SELECT 
    c.card_type AS loai_the,
    COUNT(t.id) AS tong_so_giao_dich,
    SUM(CASE WHEN t.use_chip IS NULL THEN 1 ELSE 0 END) AS so_giao_dich_loi,
    ROUND(SUM(CASE WHEN t.use_chip IS NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(t.id), 2) AS ty_le_loi_pct
FROM banking.transactions t
JOIN banking.cards c ON t.card_id = c.id
GROUP BY c.card_type;
