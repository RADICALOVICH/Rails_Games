class User < ApplicationRecord
  attr_accessor :old_password
 
  has_secure_password validations: false

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, confirmation: true, allow_blank: true
  validate :password_presence
  validate :correct_old_password, on: :update

  before_create :confirmation_token

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end
  private

  def correct_old_password
    return if BCrypt::Password.new(password_digest_was).is_password?(old_password)

    errors.add :old_password, 'Не верный'
  end

  def password_presence
    errors.add(:password, :blank) if password_digest.blank?
  end

  def confirmation_token
    self.confirm_token = SecureRandom.urlsafe_base64.to_s if self.confirm_token.blank?
  end
end
