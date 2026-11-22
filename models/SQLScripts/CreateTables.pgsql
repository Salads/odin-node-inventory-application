
-- Creates all tables (if they don't exist)

CREATE TABLE IF NOT EXISTS products
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title text NOT NULL UNIQUE,
    stock integer NOT NULL DEFAULT 0 CHECK (stock >= 0)
);

CREATE TABLE IF NOT EXISTS developers
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    developer text NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS genres
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    genre text NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS product_genres
(
    product_id integer NOT NULL
		  REFERENCES products (id) ON DELETE CASCADE,
    genre_id integer NOT NULL
		  REFERENCES genres (id) ON DELETE RESTRICT,
    PRIMARY KEY (product_id, genre_id)
);

CREATE TABLE IF NOT EXISTS product_developers
(
    product_id integer NOT NULL
		  REFERENCES products (id) ON DELETE CASCADE,
    developer_id integer NOT NULL
		  REFERENCES developers (id) ON DELETE RESTRICT,
    PRIMARY KEY (product_id, developer_id)
);
