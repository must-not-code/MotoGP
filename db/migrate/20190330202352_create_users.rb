class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.string :patronymic
      t.string :email
      t.string :phone
      t.string :tricolor
      t.string :stage_one
      t.string :stage_two
      t.string :stage_three
      t.string :password_digest
      t.string :token

      t.timestamps
    end
  end
end
