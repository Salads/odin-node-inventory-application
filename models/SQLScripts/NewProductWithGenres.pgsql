
-- Inserts a NEW product, and it's genre relation.
-- $1: title
-- $2: stock (number in inventory)
-- $3: an string array of genres

WITH new_product_ids AS (
	INSERT INTO products (title, stock) VALUES ($1, $2) RETURNING id
),
input_genres AS (
	SELECT DISTINCT unnest($3::text[]) AS genre
),
input_genres_ids AS (
	INSERT INTO genres (genre)
		SELECT genre FROM input_genres
		ON CONFLICT (genre) DO UPDATE SET genre = EXCLUDED.genre
		RETURNING id
),
output_product_ids AS (
	INSERT INTO product_genres (product_id, genre_id)
		SELECT new_product_ids.id, input_genres_ids.id 
		FROM new_product_ids CROSS JOIN input_genres_ids
		RETURNING product_id
)
SELECT id FROM new_product_ids;
