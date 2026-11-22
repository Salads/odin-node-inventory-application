const { Pool } = require("pg");

module.exports = new Pool({
	host: "localhost",
	user: "postgres",
	database: "OdinInventoryDB",
	password: "hi",
	port: 5432
});