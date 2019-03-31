class MainController < ApplicationController
  def index
    @user = current_user
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
      if @user.stage_one && @user.stage_two
        render json: { error: 'Выбор уже нельзя изменить' }, status: :unprocessable_entity
      else
        @user.update(stage_one: params[:stage_one], stage_two: params[:stage_two])
        render partial: 'thx.html.slim'
      end
    else
      render json: { error: 'Ошибка аутентификации' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:name, :surname, :patronymic, :phone, :email, :tricolor, :password, :password_confirmation)
  end
end
