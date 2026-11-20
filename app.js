const path = require("path");
const express = require("express");
const app = express();

app.set("views", path.join(__dirname, "views"));
app.set("view engine", "ejs");

const staticPath = path.join(__dirname, "static");
app.use(express.static(staticPath));

const indexRouter = require("./routes/indexRouter");
app.use("/", indexRouter);

const PORT = 8080;
app.listen(PORT, (error) => {
	if(error) {
		throw error;
	}

	console.log(`Server Started - Listening on port ${PORT}`);
});