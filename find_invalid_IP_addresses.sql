SELECT 
    ip,
    COUNT(*) AS invalid_count
FROM logs
WHERE
    -- Condition 1: Not exactly 4 octets
    ip NOT REGEXP '^([0-9]+\\.){3}[0-9]+$'
    
    OR
    
    -- Condition 2 & 3: Check each octet
    (
        CAST(SUBSTRING_INDEX(ip, '.', 1) AS UNSIGNED) > 255
        OR CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 2), '.', -1) AS UNSIGNED) > 255
        OR CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 3), '.', -1) AS UNSIGNED) > 255
        OR CAST(SUBSTRING_INDEX(ip, '.', -1) AS UNSIGNED) > 255
        
        OR
        
        -- Leading zero check
        SUBSTRING_INDEX(ip, '.', 1) REGEXP '^0[0-9]+'
        OR SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 2), '.', -1) REGEXP '^0[0-9]+'
        OR SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 3), '.', -1) REGEXP '^0[0-9]+'
        OR SUBSTRING_INDEX(ip, '.', -1) REGEXP '^0[0-9]+'
    )
    
GROUP BY ip
ORDER BY invalid_count DESC, ip DESC;