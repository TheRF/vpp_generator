function ShowHideP(chkPara) {
  var pDeb = document.getElementById("debugPara");
  pDeb.style.display = chkPara.checked ? "block" : "none";
}

function SetDebugText(chkPara) {
  var pDeb = document.getElementById("debugPara");
  pDeb.innerText = "Test";
}