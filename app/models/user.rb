class User < ActiveRecord::Base

  validates :name, presence: true
  validates :phone_number, presence: true, uniqueness: true, format: { with: /[0-9]/, message: "only allows numbers"}
end