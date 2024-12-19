const mysql = require("mysql");
const dotenv = require("dotenv");

dotenv.config({ path: "./.env" });

const db = mysql.createConnection({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
});

db.connect((err) => {
  if (err) {
    throw err;
  } else {
    console.log("Database terhubung");
  }
});

module.exports = db;
