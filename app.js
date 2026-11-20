const express = require("express");
const app = express();

app.get("/", (req, res) => res.send("Hello"));

const PORT = 8080;
app.listen(PORT, (error) => {
	if(error) {
		throw error;
	}

	console.log(`Server Started - Listening on port ${PORT}`);
});