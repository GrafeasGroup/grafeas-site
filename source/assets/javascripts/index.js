// Email de-obfuscator
(function(){
  Array.from(document.querySelectorAll("[data-email]")).forEach(function(el) {
    var obfuscatedAddress = el.getAttribute("data-email");
    if (typeof obfuscatedAddress == "string" && obfuscatedAddress) {
      var cleanEmail = obfuscatedAddress.replace(/[a-zA-Z]/g, function(c){
        return String.fromCharCode((c<="Z"?90:122)>=(c=c.charCodeAt(0)+13)?c:c-26);
      });
      el.innerHTML = cleanEmail;
      if(el.hasAttribute("href")) {
        el.setAttribute("href", "mailto:"+cleanEmail);
      }
    }
  });
})();
