class AddEmailToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :email, :string
    add_column :users, :email_confirmation, :string
  end
end
