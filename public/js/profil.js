//MENAMPILKAN FOTO YANG DIUPLOAD SEBAGAI PREVIEW
function previewImage(event) {
  const reader = new FileReader();
  reader.onload = function () {
    const profileImg = document.getElementById("profileImg");
    profileImg.src = reader.result;
  };
  reader.readAsDataURL(event.target.files[0]);
}
