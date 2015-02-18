class User < ActiveRecord::Base

  validates :name, presence: true
  validates :number, presence: true, uniqueness: true
end