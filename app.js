//IMPORT LIBRARY
const express = require("express");
const cookieParser = require("cookie-parser");

//GUNAKAN LIBRARY, PORT, LOKASI FILE TERTENTU
const app = express();
const port = 3000;
const path = require("path");
const db = require("./config/db");
const { checkAuth } = require("./middleware/authMiddleware");

//GUNAKAN EJS, FOLDER PUBLIC
app.set("view engine", "ejs");
app.set("views", __dirname + "/views");
app.set("public", path.join(__dirname, "public"));
app.use("/uploads", express.static(path.join(__dirname, "uploads")));
app.use(express.static("public"));
app.use(
  "/css",
  express.static(path.join(__dirname, "node_modules/bootstrap/dist/css"))
);
app.use(
  "/js",
  express.static(path.join(__dirname, "node_modules/bootstrap/dist/js"))
);

// MIDDLEWARE
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());
app.use(checkAuth);

// MULAI SERVER
app.listen(port, () => {
  console.log(`Server running at ${port}`);
});

//PAGE KE ROUTE
app.use("/", require("./routes/pageRoute"));
app.use("/auth", require("./routes/authRoute"));
app.use("/merk", require("./routes/merkRoute"));
app.use("/cart", require("./routes/cartRoute"));

app.use((req, res, next) => {
  const user = req.user;
  res.status(404).render("error", { user });
});

app.use((err, req, res, next) => {
  const user = req.user;
  console.error(err.stack);
  res.status(500).render("error", { user, message: "Internal Server Error" });
});
