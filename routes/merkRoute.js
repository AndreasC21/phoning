const express = require("express");
const db = require("../config/db");

const router = express.Router();

// PAGE DAFTAR PHONE
router.get("/:nama_merk", (req, res) => {
  const nama_merk = req.params.nama_merk;
  const sql = `SELECT * FROM phone WHERE nama_merk = '${nama_merk}';`;

  db.query(sql, [nama_merk], (err, result) => {
    if (err) throw err;
    res.render("merk", { phones: result, namaMerk: nama_merk, user: req.user });
  });
});

// PAGE DETAIL PHONE
router.get("/:nama_merk/:nama_phone", (req, res) => {
  const nama_phone = req.params.nama_phone;
  const sql = `SELECT * FROM phone JOIN spec ON phone.id_phone = spec.id_phone WHERE phone.nama_phone = '${nama_phone}';`;

  db.query(sql, [nama_phone], (err, result) => {
    if (err) throw err;
    res.render("phone", {
      phone: result[0],
      spec: result,
      namaPhone: nama_phone,
      user: req.user,
    });
  });
});

module.exports = router;
