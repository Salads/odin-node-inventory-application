
-- Sets the stock count for a product id
-- $1: Product ID
-- $2: New stock count

UPDATE products
	SET stock = $2::integer
	WHERE id = $1::integer
