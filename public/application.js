var Sinatrabook = (function() {
  var initialize = function() {
    $('#people li').click(function() {
      var name = $(this).text();
      $('#search').attr('src', 'http://www.google.com/search?q=' + name);
    });
  };

  return {
    init : initialize
  };
})();

$(document).ready(function() {
  Sinatrabook.init();
});
