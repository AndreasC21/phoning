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
