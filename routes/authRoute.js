const express = require("express");
const authController = require("../controllers/authController");
const midtransController = require("../controllers/midtransController");
const profileController = require("../controllers/profileController");

const upload = profileController.upload;

const router = express.Router();

router.post("/register", authController.register);
router.post("/login", authController.login);
router.get("/logout", authController.logout);

router.post("/payment", midtransController.midtrans);
router.get("/payment/finish", midtransController.paymentFinish);
router.get("/payment/error", midtransController.paymentError);
router.get("/payment/pending", midtransController.paymentPending);

router.post("/profile", upload.single("img"), profileController.update);

module.exports = router;
