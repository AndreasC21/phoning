const db = require("../config/db");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");

module.exports = {
  // MEKANISME REGISTER
  register: (req, res) => {
    const { name, password, passwordConfirm } = req.body;

    db.query(
      "SELECT name FROM users WHERE name = ?",
      [name],
      async (err, result) => {
        if (err) throw err;

        if (result.length > 0) {
          if (err) throw err;
          return res.render("render", {
            message: "Username telah dipakai",
          });
        } else if (passwordConfirm !== password) {
          if (err) throw err;
          return res.render("render", {
            message: "Password tidak sama",
          });
        } else {
          let hashedPassword = await bcrypt.hash(password, 8);

          db.query(
            "INSERT INTO users SET ?",
            { name: name, password: hashedPassword },
            (err, result) => {
              if (err) throw err;
              else {
                if (err) throw err;
                return res.render("register", {
                  message: "Berhasil mendaftar, silakan login",
                });
              }
            }
          );
        }
      }
    );
  },

  // MEKANISME LOGIN
  login: (req, res) => {
    const { name, password } = req.body;

    db.query(
      "SELECT * FROM users WHERE name = ?",
      [name],
      async (err, result) => {
        if (err) throw err;

        // JIKA USER DITEMUKAN
        if (result.length > 0) {
          const user = result[0];
          const hashedPassword = result[0].password;
          const isMatch = await bcrypt.compare(password, hashedPassword);

          // JIKA PASSOWRD SAMA
          if (isMatch) {
            //MEMBUAT TOKEN
            const token = jwt.sign(
              {
                id: user.id,
                name: user.name,
                no_telp: user.no_telp,
                alamat: user.alamat,
                email: user.email,
              },
              process.env.JWT_SECRET,
              { expiresIn: "1h" }
            );

            //MASUKKAN TOKEN KE COOKIE, DAN LANGSUNG KE HOME PAGE
            res.cookie("jwt", token, {
              httpOnly: true,
              maxAge: 3600000,
            });
            res.redirect("/");
          } else {
            //JIKA PASSOWRD TIDAK SAMA, PINDAHKAN KE LOGIN PAGE
            if (err) throw err;
            res.render("login", {
              message: "Salah password",
            });
          }
        } else {
          //JIKA USER TIDAK DITEMUKAN, PINDAHKAN KE LOGIN PAGE
          if (err) throw err;
          res.render("login", {
            message: "Username tidak ditemukan",
          });
        }
      }
    );
  },

  // MEKANISME LOGOUT
  logout: (req, res) => {
    res.clearCookie("jwt");
    res.redirect("/");
  },
};
