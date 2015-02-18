class User < ActiveRecord::Base

  validates :name, presence: true
  validates :phone, presence: true, uniqueness: true
end