class ChangeNumberToPhoneNumbewr < ActiveRecord::Migration
  def change
    rename_column :users, :number, :phone_number
  end
end
