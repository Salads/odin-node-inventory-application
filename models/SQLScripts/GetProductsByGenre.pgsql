
-- Get all products of some genre
-- $1: genre text to search for

WITH product_ids_with_genre AS (
	SELECT pg.product_id
	FROM (genres AS g JOIN product_genres AS pg ON g.id = pg.genre_id)
	WHERE g.genre = $1::text 
)
SELECT 
	p.id,
	p.title, 
	(
		SELECT COALESCE(array_agg(g.genre ORDER BY g.genre), ARRAY[]::text[])
		FROM 
			product_genres AS pg JOIN genres AS g 
				ON g.id = pg.genre_id
		WHERE pg.product_id = p.id
	) AS genres, 
	(
		SELECT COALESCE(array_agg(d.developer ORDER BY d.developer), ARRAY[]::text[])
		FROM product_developers AS pd JOIN developers AS d
			ON pd.developer_id = d.id
		WHERE pd.product_id = p.id
	) AS developers, 
	p.stock
FROM products AS p
WHERE p.id IN (SELECT product_id FROM product_ids_with_genre);
