const path = require("path");
const express = require("express");
const app = express();


const PORT = 8080;

app.set("views", path.join(__dirname, "views"));
app.set("view engine", "ejs");

const staticPath = path.join(__dirname, "static");
app.use(express.static(staticPath));

const indexRouter = require("./routes/indexRouter");
app.use("/", indexRouter);

async function start() {
	// Ensure DB is initialized BEFORE listening to requests
	const inventoryModel = require("./models/Inventory");
	await inventoryModel.initializeDB();

	app.listen(PORT, (error) => {
		if(error) { throw error; }
		console.log(`Server Started - Listening on port ${PORT}`);
	});
}

console.log("Starting Server...");
start().catch((ex) => {
	console.log(ex);
	process.exit(1);
});
