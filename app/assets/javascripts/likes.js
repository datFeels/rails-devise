$(function() {
  $('#like a[data-remote]').on('ajax:success', function (e, data, status, xhr) {
    alert($(this).text());
    alert(data.likes);
    $("#like").addClass("hide");
    $("#unlike").removeClass("hide");
    $("#likeCounts").text(data.likes);
  });
  $('#unlike a[data-remote]').on('ajax:success', function (e, data, status, xhr) {
    alert($(this).text());
    alert(data.likes);
    $("#unlike").addClass("hide");
    $("#like").removeClass("hide");
    $("#likeCounts").text(data.likes);
  });
});
