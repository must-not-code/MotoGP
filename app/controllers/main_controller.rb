class MainController < ApplicationController
  def index
  end

  def signup
    @user = User.new(user_params)
    @user.token = SecureRandom.hex(64)

    if @user.save
      session[:token] = @user.token
      render json: { message: 'Зарегался' }, status: :created
    else
      render json: { error: @user.errors.first[1] }, status: :unprocessable_entity
    end
  end

  def login
    @user = User.find_by(tricolor: params[:tricolor]).try(:authenticate, params[:password])
    if @user.present?
      @user.update(token: SecureRandom.hex(64))
      session[:token] = @user.token
      render json: { message: 'Вошел' }, status: :ok
      #render partial: 'json_partial', formats: [:json]
    else
      render json: { error: 'Неправильный логин или пароль' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:name, :surname, :patronymic, :phone, :email, :tricolor, :password, :password_confirmation)
  end
end
