
-- Get all products
-- Including title, genre(s), developer(s), stock

SELECT 
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
FROM products p;
