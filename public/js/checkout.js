// Fungsi untuk menampilkan popup
function showPopup(message) {
  const popup = document.getElementById("popup-email");
  const popupMessage = document.getElementById("popup-message");
  popupMessage.innerText = message;
  popup.style.display = "block";
}

document.getElementById("close-popup").addEventListener("click", function () {
  document.getElementById("popup").style.display = "none";
});

payButton = document.getElementById("pay-button");

//BUTTON ORDER NANTI MEMANGGIL MIDTRANS
payButton.addEventListener("click", function () {
  const email = document.getElementById("email").value;
  if (!email) {
    showPopup("Email tidak boleh kosong!");
    return;
  }

  const firstName = document.getElementById("firstName").value;
  const lastName = "";
  const phone = document.getElementById("phone").value;
  const phoneId = document.getElementById("phoneId").value;
  const quantity = document.getElementById("quantity").value;
  const shipping = parseFloat(document.getElementById("shipping").value);
  const fee = parseFloat(document.getElementById("fee").value);

  const totalPembayaranString =
    document.getElementById("totalPembayaran").innerText;
  const cleanedString = totalPembayaranString.replace(/Rp|\.|,/g, "").trim();
  const grossAmount = parseFloat(cleanedString);

  console.log("Gross Amount before sending:", grossAmount); // Log untuk debugging

  // Pastikan grossAmount adalah angka
  if (!grossAmount || isNaN(grossAmount)) {
    console.error("Gross Amount is required and must be a number.");
    return; // Hentikan eksekusi jika grossAmount tidak valid
  }

  fetch("/auth/payment", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      grossAmount: grossAmount,
      firstName: firstName,
      lastName: lastName || "",
      email: email,
      phone: phone,
      phoneId: phoneId,
      quantity: quantity,
      shipping: shipping,
      fee: fee,
    }),
  })
    .then((response) => response.json())
    .then((data) => {
      const transactionToken = data.transactionToken;
      if (transactionToken) {
        // Gunakan snap.pay dengan redirect
        window.snap.pay(transactionToken, {
          onSuccess: function (result) {
            console.log("Payment success:", result);
            // Redirect atau refresh halaman
            window.location.href =
              "/auth/payment/finish?order_id=" + result.order_id;
          },
          onPending: function (result) {
            console.log("Payment pending:", result);
            window.location.href =
              "/auth/payment/pending?order_id=" + result.order_id;
          },
          onError: function (result) {
            console.log("Payment error:", result);
            window.location.href =
              "/auth/payment/error?order_id=" + result.order_id;
          },
        });
      } else {
        console.error("Failed to get token");
      }
    });
});

function formatCurrency(value) {
  return "Rp" + value.toLocaleString("id-ID");
}

//MENGGUNAKAN VOUCHER
function applyVoucher() {
  const voucherCode = document.getElementById("voucherCode").value;
  const hargaAsli = parseFloat(document.getElementById("hargaAsli").value);
  const fee = parseFloat(document.getElementById("fee").value);
  const shipping = parseFloat(document.getElementById("shipping").value);

  fetch("/voucher/apply", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      voucherCode: voucherCode,
      hargaAsli: hargaAsli,
    }),
  })
    .then((response) => response.json())
    .then((data) => {
      let totalHarga;

      if (data.success) {
        const discountedHarga = data.discountedHarga;
        totalHarga = discountedHarga + fee + shipping;
        document.getElementById("totalPembayaran").innerText =
          formatCurrency(totalHarga);
        document.getElementById("totalHarga").value = totalHarga;

        const diskonValue = hargaAsli - discountedHarga;
        document.getElementById("diskon").innerText = `-${formatCurrency(
          diskonValue
        )}`;
        voucherMessage.innerText = "Voucher berhasil diterapkan!";
        voucherMessage.style.color = "green";
      } else {
        totalHarga = hargaAsli + fee + shipping;
        document.getElementById("totalPembayaran").innerText =
          formatCurrency(totalHarga);
        document.getElementById("totalHarga").value = totalHarga;
        voucherMessage.innerText = data.message;
        voucherMessage.style.color = "red";
      }
    })
    .catch((error) => {
      console.error("Error applying voucher:", error);
    });
}

document.addEventListener("DOMContentLoaded", function () {
  const popup = document.getElementById("popup");
  const closeButton = document.getElementById("close-popup");

  //MENAMPILKAN POPUP
  popup.style.display = "block";

  //MENUTUP POPUP
  closeButton.addEventListener("click", function () {
    popup.style.display = "none";
  });
});
