class PasswordRecoveryMailer < ActionMailer::Base
  def password_recovery_email
    @link = params[:link]
    @name = params[:name]

    mail(
      to: params[:email],
      from: 'support@motortricolor.ru',
      subject: 'Восстановление пароля'
    )
  end
end
