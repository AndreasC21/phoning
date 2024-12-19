const express = require("express");
const cartController = require("../controllers/cartController");
const { protectRoute } = require("../middleware/authMiddleware");

const router = express.Router();

router.post("/add", protectRoute, cartController.addToCart);
router.get(
  "/",
  protectRoute,
  (req, res, next) => {
    console.log("Cart route accessed");
    console.log("User:", req.user);
    next();
  },
  cartController.viewCart
);
router.post(
  "/update-quantity",
  protectRoute,
  cartController.updateCartQuantity
);
router.post("/remove", protectRoute, cartController.removeFromCart);
router.get("/checkout", protectRoute, cartController.checkoutFromCart);
router.post("/checkout", protectRoute, cartController.checkoutFromCart);

module.exports = router;
