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
