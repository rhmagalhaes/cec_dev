class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :account
  accepts_nested_attributes_for :account, allow_destroy: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def test_admin
    is_admin
  end

  def test_client
    is_client
  end

  def test_partner
    is_partner
  end  
  
  def user_id_account
    id
  end

end
