class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :phone_number, presence: true, uniqueness: true, format: { with: /[0-9]/, message: "only allows numbers"}

  has_many :messages, dependent: :destroy

  def format_phone_number
    # @formatted_phone_number = number_to_phone(phone_number, country_code: 1)
  end
end