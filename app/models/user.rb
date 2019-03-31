class User < ApplicationRecord
  has_secure_password

  before_validation :fix_phone

  validates_presence_of :name, message: 'Имя не может быть пустым'
  validates_presence_of :surname, message: 'Фамилия не может быть пустой'
  validates_presence_of :patronymic, message: 'Отчество не может быть пустым'
  validates_presence_of :email, message: 'Email не может быть пустым'
  validates_presence_of :phone, message: 'Телефон не может быть пустым'
  validates_presence_of :tricolor, message: 'Номер абонента ТриколорТВ не может быть пустым'
  validates_presence_of :password_digest, message: 'Пароль не может быть пустым'

  validates_uniqueness_of :email, case_sensitive: false, message: 'Пользователь с таким Email уже зарегистрирован'
  validates_uniqueness_of :phone, message: 'Пользователь с таким номером телефона уже зарегистрирован'
  validates_uniqueness_of :tricolor, message: 'Пользователь с таким номером абонента ТриколорТВ уже зарегистрирован'

  #:stage_one
  #:stage_two
  #:stage_three

  def fix_phone
    self.phone = phone.gsub(/\D/, '')
  end
end
