const db = require("../config/db");
const multer = require("multer");
const path = require("path");

//MEMBUAT STORAGE UNTUK MENGUPLOAD FOTO PROFILE
const storage = multer.diskStorage({
  //DESTINASI FILE DISIMPAN
  destination: function (req, file, cb) {
    cb(null, path.join("./uploads/profile"));
  },
  //PEMBERIAN NAMA FILE
  filename: function (req, file, cb) {
    const uniqueSuffix = Date.now() + "-" + Math.round(Math.random() * 1e9);
    const ext = path.extname(file.originalname);
    cb(null, file.fieldname + "-" + uniqueSuffix + ext);
  },
});

const upload = multer({ storage: storage });

//MENGUBAH ISI PROFILE
const update = (req, res) => {
  const userId = req.user.id;
  const { name, email, no_telp, alamat } = req.body;

  // MENGAMBIL FOTO DARI DATABASE
  const sqlGetCurrentUser = "SELECT img FROM users WHERE id = ?";

  db.query(sqlGetCurrentUser, [userId], (err, currentUserResult) => {
    if (err) throw err;

    //GUNAKAN FOTO LAMA JIKA ADA
    let photoPath = currentUserResult[0].img; // Gunakan foto lama sebagai default

    //JIKA ADA FILE BARU, GANTI FOTO
    if (req.file) {
      photoPath = req.file.path;
    }

    const sql = `UPDATE users SET name = ?, email = ?, no_telp = ?, alamat = ?, img = ? WHERE id = ?`;

    db.query(
      sql,
      [name, email, no_telp, alamat, photoPath, userId],
      (err, result) => {
        if (err) throw err;
        res.redirect("/profile");
      }
    );
  });
};
module.exports = { upload, update };
