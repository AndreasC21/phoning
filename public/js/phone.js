document.addEventListener("DOMContentLoaded", () => {
  const quantityInput = document.getElementById("quantity");
  const decreaseBtn = document.getElementById("btn-decrease");
  const increaseBtn = document.getElementById("btn-increase");
  const cartQuantityInput = document.getElementById("cart-quantity");
  const checkoutQuantityInput = document.getElementById("checkout-quantity");

  // Fungsi update quantity
  function updateQuantity(newQuantity) {
    quantityInput.value = newQuantity;
    cartQuantityInput.value = newQuantity;
    checkoutQuantityInput.value = newQuantity;
  }

  //MENGURANGI QUANTITY DI PHONE
  decreaseBtn.addEventListener("click", () => {
    let currentQuantity = parseInt(quantityInput.value);
    if (currentQuantity > 1) {
      updateQuantity(currentQuantity - 1);
    }
  });

  //MENAMBAH QUANTITY DI PHONE
  increaseBtn.addEventListener("click", () => {
    let currentQuantity = parseInt(quantityInput.value);
    updateQuantity(currentQuantity + 1);
  });

  quantityInput.addEventListener("change", () => {
    let newQuantity = parseInt(quantityInput.value);
    if (isNaN(newQuantity) || newQuantity < 1) {
      updateQuantity(1);
    } else {
      updateQuantity(newQuantity);
    }
  });
});
