const jwt = require("jsonwebtoken");

//FUNGSI UNTUK CEK LOGIN, JIKA TIDAK LOGIN, USER = NULL
exports.checkAuth = (req, res, next) => {
  const token = req.cookies.jwt;

  if (token) {
    try {
      const decoded = jwt.verify(token, process.env.JWT_SECRET);
      req.user = decoded;
    } catch (err) {
      req.user = null;
    }
  } else {
    req.user = null;
  }
  next();
};

//FUNGSI UNTUK CEK LOGIN, JIKA TIDAK LOGIN, MAKA PADA PAGE TERTENTU AKAN DIREDIRECT KE PAGE LOGIN
exports.protectRoute = (req, res, next) => {
  console.log("Protect route middleware called");
  const token = req.cookies.jwt;
  if (!token) {
    return res.redirect("/login");
  }
  next();
};
