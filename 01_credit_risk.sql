WITH user_segments AS (
    SELECT 
        id,
        CASE 
            WHEN credit_score >= 800 THEN '1. Exceptional (Rui ro cuc thap)'
            WHEN credit_score BETWEEN 740 AND 799 THEN '2. Very Good (Rui ro thap)'
            WHEN credit_score BETWEEN 670 AND 739 THEN '3. Good (Rui ro trung binh)'
            WHEN credit_score BETWEEN 580 AND 669 THEN '4. Fair (Rui ro cao)'
            ELSE '5. Poor (Rui ro rat cao)'
        END AS muc_do_rui_ro
    FROM banking.users
)
SELECT 
    muc_do_rui_ro,
    COUNT(id) AS tong_so_khach_hang,
    ROUND(COUNT(id) * 100.0 / SUM(COUNT(id)) OVER(), 2) AS ty_le_phan_tram
FROM user_segments
GROUP BY muc_do_rui_ro
ORDER BY muc_do_rui_ro;
