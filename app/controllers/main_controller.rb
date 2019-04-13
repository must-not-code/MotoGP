class MainController < ApplicationController
  def index
    @user = current_user
    @reset_token = params[:reset_token]
  end

  def signup
    @user = User.new(user_params)
    @user.token = SecureRandom.hex(64)

    if @user.save
      session[:token] = @user.token
      render partial: 'quiz.html.slim'
    else
      render json: { error: @user.errors.first[1] }, status: :unprocessable_entity
    end
  end

  def login
    @user = User.find_by(tricolor: params[:tricolor]).try(:authenticate, params[:password])
    if @user.present?
      @user.update(token: SecureRandom.hex(64))
      session[:token] = @user.token
      render partial: 'quiz.html.slim'
    else
      render json: { error: 'Неправильный логин или пароль' }, status: :unauthorized
    end
  end

  def quiz
    if @user = current_user
      if @user.stage_three
        render json: { error: 'Выбор уже нельзя изменить' }, status: :unprocessable_entity
      else
        @user.update(stage_three: [params[:minutes], params[:seconds], params[:milliseconds]].join(':'))
        render partial: 'thx.html.slim'
      end
    else
      render json: { error: 'Ошибка аутентификации' }, status: :unauthorized
    end
  end

  def reset
    if @user = User.find_by(email: params[:email])
      @user.update(reset_token: SecureRandom.hex(12))
      PasswordRecoveryMailer.with(
        email: @user.email,
        name: @user.name,
        link: "https://motortricolor.ru/?reset_token=#{@user.reset_token}#form"
      ).password_recovery_email.deliver_now
    end
    render partial: 'reseted.html.slim'
  end

  def password
    if @user = User.find_by(reset_token: params[:reset_token])
      if params[:password] == params[:password_confirmation]
        @user.update(password: params[:password], reset_token: nil)
        render partial: 'updated.html.slim'
      else
        render json: { error: 'Пароли не совпадают' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Ссылка неправильная или устарела' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:name, :surname, :patronymic, :phone, :email, :tricolor, :password, :password_confirmation)
  end
end
