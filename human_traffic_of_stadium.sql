WITH filtered AS (
    SELECT *,
           id - ROW_NUMBER() OVER (ORDER BY id) AS grp
    FROM Stadium
    WHERE people >= 100
),
grouped AS (
    SELECT grp
    FROM filtered
    GROUP BY grp
    HAVING COUNT(*) >= 3
)
SELECT f.id, f.visit_date, f.people
FROM filtered f
JOIN grouped g ON f.grp = g.grp
ORDER BY f.visit_date;