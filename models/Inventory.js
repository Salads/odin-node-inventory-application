const dbPool = require("./DBPool");
const fs = require("node:fs");

const SQL = {
	CreateTables: fs.readFileSync("./SQLScripts/CreateTables.pgsql"),
	AddNewProductWithGenre: fs.readFileSync("./SQLScripts/NewProductWithGenres.pgsql"),
	AddDevsForProduct: fs.readFileSync("./SQLScripts/AddDevsForProduct.pgsql"),
	SetStockForProduct: fs.readFileSync("./SQLScripts/SetStockForProduct.pgsql"),
	GetAllProducts: fs.readFileSync("./SQLScripts/GetAllProducts.pgsql"),
	GetProductsByDev: fs.readFileSync("./SQLScripts/GetProductsByDeveloper.pgsql"),
	GetProductsByGenre: fs.readFileSync("./SQLScripts/GetProductsByGenre.pgsql")
};

const inventoryModel = {
	initializeDB: async () => {
		const client = await dbPool.connect();
		try {
			await client.query("BEGIN");
			await client.query(SQL.CreateTables);
			await client.query("COMMIT");
		}
		catch {
			await client.query("ROLLBACK");
		}
		finally {
			await client.release();
		}
	},

	addNewProduct: async(title, stock, genres, developers) => {
		const client = await dbPool.connect();
		let addedProductId = null;
		try {
			await client.query("BEGIN");
			const result = await client.query(SQL.AddNewProductWithGenre, [title, stock, genres]);
			addedProductId = result.rows[0].id;
			await client.query(SQL.AddDevsForProduct, [addedProductId, developers])
			await client.query("COMMIT");
		}
		catch {
			await client.query("ROLLBACK");
		}
		finally {
			await client.release();
		}

		return addedProductId;
	},

	setStockForProduct: async (productId, newStock) => {
		const client = await dbPool.connect();
		try {
			await client.query("BEGIN");
			await client.query(SQL.SetStockForProduct, [productId, newStock]);
			await client.query("COMMIT");
		}
		catch {
			await client.query("ROLLBACK");
		}
		finally {
			await client.release();
		}
	},

	getAllProducts: async () => {
		const client = await dbPool.connect();
		let result = null;
		try {
			await client.query("BEGIN");
			result = await client.query(SQL.GetAllProducts);
			await client.query("COMMIT");
		}
		catch {
			await client.query("ROLLBACK");
		}
		finally {
			await client.release();
		}

		return result;
	},

	getProductsByDeveloper: async (developer) => {
		const client = await dbPool.connect();
		let result = null;
		try {
			await client.query("BEGIN");
			result = await client.query(SQL.GetProductsByDev, [developer]);
			await client.query("COMMIT");
		}
		catch {
			await client.query("ROLLBACK");
		}
		finally {
			await client.release();
		}

		return result;
	},

	getProductsByGenre: async (genre) => {
		const client = await dbPool.connect();
		let result = null;
		try {
			await client.query("BEGIN");
			result = await client.query(SQL.GetProductsByGenre, [genre]);
			await client.query("COMMIT");
		}
		catch {
			await client.query("ROLLBACK");
		}
		finally {
			await client.release();
		}

		return result;
	}
};

module.exports = inventoryModel;