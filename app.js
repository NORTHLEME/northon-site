const year = document.querySelector("#ano");

if (year) {
  year.textContent = String(new Date().getFullYear());
}
