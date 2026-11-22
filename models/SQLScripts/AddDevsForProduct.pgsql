
-- Inserts product-developer relation-rows for an EXISTING product.
-- $1: Product ID (returned from InsertNewProductWithGenre.pgsql)
-- $2: String array of developers

WITH input_developers AS (
	SELECT DISTINCT unnest($2::text[]) AS developer
),
input_developers_ids AS (
	INSERT INTO developers (developer)
		SELECT developer FROM input_developers
		ON CONFLICT (developer) DO UPDATE SET developer = EXCLUDED.developer
		RETURNING id
)
INSERT INTO product_developers (product_id, developer_id)
	SELECT $1::integer, d.id
	FROM input_developers_ids as d;
