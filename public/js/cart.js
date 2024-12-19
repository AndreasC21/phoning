document.addEventListener("DOMContentLoaded", () => {
  // MENGUBAH QUANTITY DI CART
  document.querySelectorAll(".quantity-btn").forEach((btn) => {
    btn.addEventListener("click", (e) => {
      const cartId = e.target.dataset.cartId;
      const input = e.target.parentElement.querySelector(".quantity-input");
      let quantity = parseInt(input.value);

      const priceElement = document.getElementById(`price-original-${cartId}`);
      const priceText = priceElement.innerText
        .replace(/[^0-9.,]/g, "")
        .replace(/\./g, "")
        .replace(/,/g, ".");
      const originalPrice = parseFloat(priceText);

      if (e.target.classList.contains("increase")) {
        quantity++;
      } else if (e.target.classList.contains("decrease") && quantity > 1) {
        quantity--;
      }

      input.value = quantity;
      const totalPrice = originalPrice * quantity;

      const totalPriceElement = document.getElementById(
        `total-price-${cartId}`
      );
      totalPriceElement.innerText = "Rp" + totalPrice.toLocaleString("id-ID");

      fetch("/cart/update-quantity", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ cartId, quantity }),
      })
        .then((response) => response.json())
        .then((data) => {
          if (!data.success) {
            console.error("Gagal memperbarui quantity");
          }
        })
        .catch((err) => console.error("Error:", err));
    });
  });

  // DELETE ITEM DARI CART
  document.querySelectorAll(".remove-btn").forEach((btn) => {
    btn.addEventListener("click", (e) => {
      const cartId = e.target.dataset.cartId;
      fetch("/cart/remove", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ cartId }),
      })
        .then((response) => response.json())
        .then((data) => {
          if (data.success) {
            // Hapus item dari DOM
            e.target.closest(".cart-item").remove();
          } else {
            alert("Gagal menghapus item dari keranjang.");
          }
        })
        .catch((err) => console.error("Error:", err));
    });
  });
});

// CHECKOUT DARI CART
document.getElementById("checkout-btn").addEventListener("click", () => {
  const selectedItem = [];
  document.querySelectorAll(".item-checkbox:checked").forEach((radio) => {
    selectedItem.push(radio.getAttribute("data-phone-id"));
  });

  if (selectedItem.length > 0) {
    const queryString = selectedItem
      .map((phone) => `cartId=${phone}`)
      .join("&");
    window.location.href = `/cart/checkout?${queryString}`;
  } else {
    alert("Silakan pilih setidaknya satu item untuk checkout.");
  }
});
