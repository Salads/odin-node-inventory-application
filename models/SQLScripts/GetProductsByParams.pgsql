-- Get all products with search params.
-- The search parameters are all "AND" relation.
-- $1: title search text (contains)
-- $2: array of developer ids to filter for
-- $3: array of genre ids to filter for

WITH product_info AS ( -- Build lookup table for developers and genres
	SELECT
		p.id,
		p.title,
		p.stock,
		COALESCE(gd.genre_ids, ARRAY[]::integer[]) AS genre_ids,
		COALESCE(gd.genres, ARRAY[]::text[]) AS genres,
		COALESCE(dd.developer_ids, ARRAY[]::integer[]) AS developer_ids,
		COALESCE(dd.developers, ARRAY[]::text[]) AS developers
	FROM 
		products AS p
		LEFT JOIN (
				SELECT -- Build complete genres table (all products)
					pg.product_id,
					array_agg(pg.genre_id ORDER BY g.genre) AS genre_ids,
					array_agg(g.genre ORDER BY g.genre) AS genres
				FROM 
					product_genres AS pg JOIN genres AS g 
						ON g.id = pg.genre_id
				GROUP BY pg.product_id
			) AS gd ON gd.product_id = p.id
		LEFT JOIN (
				SELECT -- Build complete developers table (all products)
					pd.product_id,
					array_agg(pd.developer_id ORDER BY d.developer) AS developer_ids,
					array_agg(d.developer ORDER BY d.developer) AS developers
				FROM 
					product_developers AS pd JOIN developers AS d 
						ON d.id = pd.developer_id
				GROUP BY pd.product_id
			) AS dd ON dd.product_id = p.id
)
SELECT id, title, genres, developers, stock
FROM product_info
WHERE
	($1 IS NULL OR title LIKE ('%' || $1 || '%')::text)
	AND COALESCE($2::integer[], ARRAY[]::integer[]) <@ developer_ids
	AND COALESCE($3::integer[], ARRAY[]::integer[]) <@ genre_ids;