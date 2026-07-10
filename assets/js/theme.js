(function () {
  var h = document.documentElement;

  function syncToggle() {
    var btn = document.getElementById("theme");
    if (!btn) return;
    var dark = h.dataset.theme === "dark";
    btn.setAttribute("aria-pressed", dark ? "true" : "false");
    btn.setAttribute("aria-label", dark ? "Switch to light mode" : "Switch to dark mode");
  }

  var btn = document.getElementById("theme");
  if (!btn) return;
  syncToggle();
  btn.addEventListener("click", function () {
    var next = h.dataset.theme === "dark" ? "light" : "dark";
    h.style.colorScheme = next;
    h.dataset.theme = next;
    localStorage.theme = next;
    syncToggle();
  });
})();
