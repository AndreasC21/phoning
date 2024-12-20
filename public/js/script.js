const scrollLeftButton = document.getElementById("scroll-left");
const scrollRightButton = document.getElementById("scroll-right");
const list = document.getElementById("list");

let scrollAmount = 350;

//MEMEKAN TOMBOL KIRI AKAN BERGESER KE KIRI DAFTAR MERKNYA
scrollLeftButton.addEventListener("click", () => {
  list.scrollBy({
    left: -scrollAmount,
    behavior: "smooth",
  });
});

//MEMEKAN TOMBOL KANAN AKAN BERGESER KE KANAN DAFTAR MERKNYA
scrollRightButton.addEventListener("click", () => {
  list.scrollBy({
    left: scrollAmount,
    behavior: "smooth",
  });
});

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
