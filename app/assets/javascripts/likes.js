$('#like_form a[data-remote]').on('ajax:success', function (e, data, status, xhr) {
    alert($(this).text());
    alert(data.likes);
});
