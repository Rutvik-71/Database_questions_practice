SELECT
    s1.score,
    COUNT(DISTINCT s2.score) AS `rank`
FROM Scores s1
INNER JOIN Scores s2 ON s2.score >= s1.score
GROUP BY s1.id, s1.score
ORDER BY s1.score DESC;