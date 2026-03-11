SELECT 
    d.student_id, 
    d.subject, 
    s1.score AS first_score, 
    s2.score AS latest_score
FROM (
    -- Step 1: Get the first and latest exam dates for each student's subject
    SELECT 
        student_id, 
        subject, 
        MIN(exam_date) AS first_date, 
        MAX(exam_date) AS latest_date
    FROM Scores
    GROUP BY student_id, subject
    HAVING MIN(exam_date) < MAX(exam_date)
) d
-- Step 2: Join to get the score of the first exam
JOIN Scores s1 
    ON d.student_id = s1.student_id 
    AND d.subject = s1.subject 
    AND d.first_date = s1.exam_date
-- Step 3: Join to get the score of the latest exam
JOIN Scores s2 
    ON d.student_id = s2.student_id 
    AND d.subject = s2.subject 
    AND d.latest_date = s2.exam_date
-- Step 4: Filter for improvement
WHERE s2.score > s1.score
ORDER BY d.student_id ASC, d.subject ASC;