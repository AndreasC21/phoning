const express = require("express");
const { protectRoute } = require("../middleware/authMiddleware");
const db = require("../config/db");
const message = "";
const dotenv = require("dotenv");

dotenv.config({ path: "./.env" });

const router = express.Router();

//LANDING PAGE
router.get("/", (req, res) => {
  const sqlMerk = `SELECT * FROM merk`;
  const sqlPhone = `SELECT * FROM phone ORDER BY RAND() LIMIT 4`;
  db.query(sqlMerk, (err, merkResult) => {
    if (err) throw err;

    db.query(sqlPhone, (err, phoneResult) => {
      if (err) throw err;
      res.render("index", {
        merk: merkResult,
        phones: phoneResult,
        user: req.user,
      });
    });
  });
});

//MENAMPILKAN PAGE LOGIN
router.get("/login", (req, res) => {
  if (req.user) {
    return res.redirect("/");
  }
  res.render("login", { message });
});

//MENAMPILKAM PAGE REGISTER
router.get("/register", (req, res) => {
  if (req.user) {
    return res.redirect("/");
  }
  res.render("register", { message });
});

//MENAMPILKAN HASIL PENMCARIAN
router.get("/search", (req, res) => {
  const query = req.query.query;
  const user = req.user;

  const sql = `SELECT * FROM phone JOIN merk ON phone.nama_merk = merk.nama_merk WHERE phone.nama_phone LIKE ?`;
  db.query(sql, [`%${query}%`], (err, result) => {
    if (err) {
      console.error(err);
      return res.status(500).send("Internal Server Error");
    }

    res.render("search-results", { user, phone: result, query });
  });
});

//MENAMPILKAN PAGE PROFILE
router.get("/profile", protectRoute, (req, res) => {
  const userId = req.user.id;
  const sql = `SELECT name, email, no_telp, img, alamat FROM users WHERE id = ?;`;

  db.query(sql, [userId], (err, result) => {
    if (err) throw err;
    res.render("profile", { user: req.user, userData: result[0] });
  });
});

//KIRIM KE LANDING PAGE SAAT KE PAGE CHECKOUT SECARA MANUAL
router.get("/checkout", protectRoute, (req, res) => {
  res.redirect("/");
});

//MENAMPILKAN PAGE CHECKOUT YANG DATANYA DIAMBIL DARI PEMBELIAN PHONE, USER
router.post("/checkout", protectRoute, (req, res) => {
  const { phoneId, namaPhone, namaMerk, harga, quantity, img, desc } = req.body;
  const clientKey = process.env.MT_CLIENTKEY;
  console.log(req.body);

  const shipping = 25000;

  const hargaAsli = harga * quantity;
  const fee = hargaAsli * (0.3 / 100);

  const totalHarga = hargaAsli + fee + shipping;

  db.query(
    `SELECT name, email, no_telp, img, alamat FROM users WHERE id = ${req.user.id}`,
    (err, result) => {
      if (err) throw err;
      const userData = result[0];
      console.log(result);

      res.render("checkout", {
        clientKey,
        phoneId: phoneId,
        namaPhone: namaPhone,
        namaMerk: namaMerk,
        harga: harga,
        jumlah: quantity,
        fee: fee,
        desc: desc,
        shipping: shipping,
        hargaAsli: hargaAsli,
        totalHarga: totalHarga,
        img: img,
        user: req.user,
        no_telp: userData.no_telp,
        alamat: userData.alamat,
        email: userData.email,
      });
    }
  );
});

//MENAMPILKAN PAGE HISTORY
router.get("/history", protectRoute, (req, res) => {
  const userId = req.user.id;
  const sqlOrders = `SELECT * FROM orders JOIN phone ON orders.id_phone = phone.id_phone WHERE orders.id_user = ${userId};`;
  const sqlUser = `SELECT name, email, no_telp, img, alamat FROM users WHERE id = ${userId};`;

  db.query(sqlOrders, [userId], (err, resultOrders) => {
    db.query(sqlUser, [userId], (err, resultUsers) => {
      if (err) throw err;
      res.render("history", {
        user: req.user,
        userData: resultUsers[0],
        orders: resultOrders,
      });
    });
  });
});

//MENGAPPLY VOUCHER DI HALAMAN CHECKOUT
router.post("/voucher/apply", protectRoute, (req, res) => {
  const { voucherCode, hargaAsli } = req.body;

  const sqlVoucher = `SELECT * FROM vouchers WHERE code = ? AND status = 'aktif'`;

  db.query(sqlVoucher, [voucherCode], (err, results) => {
    if (err) {
      return res
        .status(500)
        .json({ success: false, message: "Gagal memeriksa voucher" });
    }

    if (results.length > 0) {
      const voucher = results[0];
      let discountedHarga;

      if (voucher.tipe === "persentase") {
        discountedHarga = hargaAsli - hargaAsli * (voucher.nilai / 100);
      } else if (voucher.tipe === "nominal") {
        discountedHarga = hargaAsli - voucher.nilai;
      }

      discountedHarga = Math.max(discountedHarga, 0);

      return res.json({
        success: true,
        discountedHarga: discountedHarga,
        diskon: voucher.nilai,
        tipeDiskon: voucher.tipe,
      });
    } else {
      return res.json({
        success: false,
        message: "Voucher tidak valid atau tidak ditemukan",
      });
    }
  });
});

module.exports = router;
