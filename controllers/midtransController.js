const midtransClient = require("midtrans-client");
const db = require("../config/db");
const dotenv = require("dotenv");
dotenv.config({ path: "./.env" });

let snap = new midtransClient.Snap({
  isProduction: false,
  serverKey: process.env.MT_SERVERKEY,
});

module.exports = {
  //IMPLEMENTASI MIDTRANS SEBAGAI PAYMENT GATEWAY
  midtrans: async (req, res) => {
    const {
      grossAmount,
      firstName,
      lastName,
      email,
      phone,
      phoneId,
      quantity,
      shipping,
      fee,
    } = req.body;
    //MEMBUAT PARAMETER BERISI INFORMASI YANG DIBUTUHKAN MIDTRANS
    let parameter = {
      transaction_details: {
        order_id: "P" + Date.now() + "G",
        gross_amount: grossAmount,
        phoneId: phoneId,
        shipping: shipping,
        fee: fee,
      },
      credit_card: {
        secure: true,
      },
      customer_details: {
        first_name: firstName,
        last_name: lastName,
        email: email,
        phone: phone,
      },
      //REDIRECT KE LINK BERIKUT SETELAH PROSES PEMBAYARAN
      callbacks: {
        finish: "https://phoning.vercel.app/auth/payment/finish",
        error: "https://phoning.vercel.app/auth/payment/error",
        pending: "https://phoning.vercel.app/auth/payment/pending",
      },
    };

    //MEMBUAT TRANSAKSI BERDASARKAN PARAMETER
    try {
      const transaction = await snap.createTransaction(parameter);
      let transactionToken = transaction.token;
      res.json({
        transactionToken,
        redirectUrl: transaction.redirect_url,
      });

      //ORDERAN DIMASUKKAN KE DALAM DATABASE
      const userId = req.user.id;
      const orderId = parameter.transaction_details.order_id;
      const sql = `INSERT INTO orders (id_order, id_user, id_phone, quantity, total_price, shipping, fee, order_date) VALUES (?, ?, ?, ?, ?, ?, ?, NOW())`;

      db.query(
        sql,
        [orderId, userId, phoneId, quantity, grossAmount, shipping, fee],
        (err, result) => {
          if (err) throw err;
        }
      );
      //JIKA ERROR, AKAN CONSOLE ERROR, SERTA KODE 500
    } catch (error) {
      console.error("Error creating Midtrans transaction:", error);
      res.status(500).json({ error: "Failed to create transaction" });
    }
  },

  //UNTUK MENAMPILKAN PAGE SETELAH PEMBAYARAN
  paymentFinish: (req, res) => {
    const userId = req.user.id;
    const orderId = req.query.order_id;
    const sql = `SELECT name, email, no_telp, img, alamat FROM users WHERE id = ${userId};`;
    const sqlUpdate = `UPDATE orders SET status = 'on progress' WHERE id_order = '${orderId}' `;

    db.query(sqlUpdate, (err, result) => {
      if (err) throw err;

      db.query(sql, [userId], (err, result) => {
        if (err) throw err;
        res.render("payment-success", {
          user: req.user,
          userData: result[0],
          orderId: orderId,
          transactionStatus: req.query.transaction_status,
        });
      });
    });
  },

  paymentError: (req, res) => {
    const userId = req.user.id;
    const orderId = req.query.order_id;
    const sql = `SELECT name, email, no_telp, img, alamat FROM users WHERE id = ${userId};`;
    const sqlUpdate = `UPDATE orders SET status = 'cancelled' WHERE id_order = '${orderId}' `;

    db.query(sqlUpdate, (err, result) => {
      if (err) throw err;

      db.query(sql, [userId], (err, result) => {
        if (err) throw err;
        res.render("payment-error", {
          user: req.user,
          userData: result[0],
          orderId: orderId,
          transactionStatus: req.query.transaction_status,
        });
      });
    });
  },

  paymentPending: (req, res) => {
    const userId = req.user.id;
    const orderId = req.query.order_id;
    const sql = `SELECT name, email, no_telp, img, alamat FROM users WHERE id = ${userId};`;
    const sqlUpdate = `UPDATE orders SET status = 'pending' WHERE id_order = '${orderId}' `;

    db.query(sqlUpdate, (err, result) => {
      if (err) throw err;

      db.query(sql, [userId], (err, result) => {
        if (err) throw err;
        res.render("payment-pending", {
          user: req.user,
          userData: result[0],
          orderId: orderId,
          transactionStatus: req.query.transaction_status,
        });
      });
    });
  },
};
