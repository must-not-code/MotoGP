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
      $('#form').html(data);
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
      $('#form').html(data);
    })
    .fail(function(data) {
      $('#login_form_button').prop('disabled', false);
      $('#login_error').text(data.responseJSON.error);
    });
  });

  $('#reset').submit(function(e) {
    e.preventDefault();
    $('#reset_form_button').prop('disabled', true);

    $.ajax({
      type: 'POST',
      url: $('#reset').attr('action'),
      data: $('#reset').serialize()
    })
    .done(function(data) {
      $('#form').html(data);
    })
  });

  $('#password').submit(function(e) {
    e.preventDefault();
    $('#password_form_button').prop('disabled', true);

    $.ajax({
      type: 'POST',
      url: $('#password').attr('action'),
      data: $('#password').serialize()
    })
    .done(function(data) {
      $('#form').html(data);
      setTimeout(function() {
        window.location.href = 'https://motortricolor.ru/#form';
      }, 3000);
    })
    .fail(function(data) {
      $('#password_form_button').prop('disabled', false);
      $('#password_error').text(data.responseJSON.error);
    });
  });

  $('.switch_to_login').click(function() {
    $('#signup_form').hide();
    $('#reset_form').hide();
    $('#login_form').show();
  });

  $('.switch_to_signup').click(function() {
    $('#login_form').hide();
    $('#reset_form').hide();
    $('#signup_form').show();
  });

  $('.switch_to_reset_password').click(function() {
    $('#login_form').hide();
    $('#signup_form').hide();
    $('#reset_form').show();
  });

  $(document).on('submit', '#quiz', function(e){
    e.preventDefault();
    $('#quiz_button').prop('disabled', true);

    $.ajax({
      type: 'POST',
      url: $('#quiz').attr('action'),
      data: $('#quiz').serialize()
    })
    .done(function(data) {
      $('#form').html(data);
    })
    .fail(function(data) {
      $('#quiz_button').prop('disabled', false);
      $('#login_error').text(data.responseJSON.error);
    });
  });
});
