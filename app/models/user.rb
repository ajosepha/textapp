class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :phone_number, presence: true, uniqueness: true, format: { with: /[0-9]/, message: "only allows numbers"}

  def format_phone_number
    puts phone_number
  end
end