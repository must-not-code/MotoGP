$(document).ready(function() {
  $('#signup').submit(function(e) {
    e.preventDefault();
    $('#signup_form_button').prop('disabled', true);

    $.ajax({
      type: 'POST',
      url: $('#signup').attr('action'),
      data: $('#signup').serialize()
    })
    .done(function(data) {
      $('#form').text(data.message);
    })
    .fail(function(data) {
      $('#signup_form_button').prop('disabled', false);
      $('#signup_error').text(data.responseJSON.error);
    });
  });

  $('#login').submit(function(e) {
    e.preventDefault();
    $('#login_form_button').prop('disabled', true);

    $.ajax({
      type: 'POST',
      url: $('#login').attr('action'),
      data: $('#login').serialize()
    })
    .done(function(data) {
      $('#form').text(data.message);
    })
    .fail(function(data) {
      $('#login_form_button').prop('disabled', false);
      $('#login_error').text(data.responseJSON.error);
    });
  });

  $('#switch_to_login').click(function() {
    $('#signup_form').hide()
    $('#login_form').show()
  });

  $('#switch_to_signup').click(function() {
    $('#signup_form').show()
    $('#login_form').hide()
  });
});
