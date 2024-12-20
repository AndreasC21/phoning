const db = require("../config/db");

module.exports = {
  //MENAMPILKAN PAGE CART
  viewCart: (req, res) => {
    console.log("viewCart function called");
    const userId = req.user.id;
    const sql = `SELECT * FROM cart JOIN phone ON cart.id_phone = phone.id_phone WHERE cart.id_user = ${userId} `;
    db.query(sql, [userId], (err, result) => {
      if (err) throw err;
      res.render("cart", {
        cartItems: result,
        user: req.user,
      });
    });
  },

  //MENAMBAH PHONE KE DALAM CART
  addToCart: (req, res) => {
    const userId = req.user.id;
    const { phoneId, quantity } = req.body;

    const sqlCheck = `SELECT * FROM cart WHERE id_user = ? AND id_phone = ?`;
    const sqlUser = `SELECT name, email, no_telp, img, alamat FROM users WHERE id = ${userId};`;

    db.query(sqlUser, (err, resultUser) => {
      db.query(sqlCheck, [userId, phoneId], (err, result) => {
        if (err) throw err;

        if (result.length > 0) {
          const sqlUpdate = `UPDATE cart SET quantity = quantity + ? WHERE id_user = ? AND id_phone = ?`;
          db.query(sqlUpdate, [quantity, userId, phoneId], (err) => {
            if (err) throw err;
            res.render("cart-added", {
              user: req.user,
              userData: resultUser[0],
            });
          });
        } else {
          const sqlInsert =
            "INSERT INTO cart (id_user, id_phone, quantity) VALUES (?, ?, ?)";
          db.query(sqlInsert, [userId, phoneId, quantity], (err) => {
            if (err) throw err;
            res.render("cart-added", {
              user: req.user,
              userData: resultUser[0],
            });
          });
        }
      });
    });
  },

  //MENGUBAH JUMLAH PHONE DI CART
  updateCartQuantity: (req, res) => {
    const { cartId, quantity } = req.body;
    const userId = req.user.id;

    const sql =
      "UPDATE cart SET quantity = ? WHERE id_cart = ? AND id_user = ?";
    db.query(sql, [quantity, cartId, userId], (err) => {
      if (err) throw err;
      res.json({ success: true });
    });
  },

  //MENGHAPUS PHONE DARI CART
  removeFromCart: (req, res) => {
    const { cartId } = req.body;
    const userId = req.user.id;

    const sql = "DELETE FROM cart WHERE id_cart = ? AND id_user = ?";
    db.query(sql, [cartId, userId], (err) => {
      if (err) throw err;
      res.json({ success: true });
    });
  },

  //CHECKOUT JIKA DARI PAGE CART
  checkoutFromCart: (req, res) => {
    const userId = req.user.id;
    const selectedItem = req.query.cartId;
    const clientKey = process.env.MT_CLIENTKEY;

    const cartSql = `
    SELECT * FROM cart 
    JOIN phone ON cart.id_phone = phone.id_phone 
    JOIN merk ON phone.nama_merk = merk.nama_merk
    JOIN users ON cart.id_user = users.id 
    WHERE cart.id_user = ? AND cart.id_phone = ?
    `;

    db.query(cartSql, [userId, selectedItem], (err, result) => {
      if (err) throw err;

      const cartItems = result[0];

      const hargaAsli = cartItems.harga * cartItems.quantity;
      const shipping = 25000;
      const fee = hargaAsli * (0.3 / 100);
      const totalHarga = hargaAsli + shipping + fee;

      console.log(cartItems.harga);

      res.render("checkout", {
        clientKey,
        totalHarga: totalHarga,
        namaMerk: cartItems.nama_merk,
        phoneId: cartItems.id_phone,
        img: cartItems.img_phone,
        namaPhone: cartItems.nama_phone,
        desc: cartItems.description,
        harga: cartItems.harga,
        hargaAsli: hargaAsli,
        shipping: shipping,
        fee: fee,
        jumlah: cartItems.quantity,
        totalHarga: totalHarga,
        user: req.user,
        no_telp: cartItems.no_telp,
        alamat: cartItems.alamat,
        email: cartItems.email,
      });
    });
  },
};
