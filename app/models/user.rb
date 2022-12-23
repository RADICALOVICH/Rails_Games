class User < ApplicationRecord
  attr_accessor :old_password, :admin_edit
 
  has_many :games
  has_secure_password validations: false

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, confirmation: true, allow_blank: true
  validate :password_presence
  validate :correct_old_password, on: :update, if: -> { password.present? && !admin_edit }

  before_create :confirmation_token

  before_update :clear_reset_password_token, if: :password_digest_changed?

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  def set_password_reset_token
    update password_reset_token: digest(SecureRandom.urlsafe_base64),
          password_reset_token_sent_at: Time.current
  end

  def clear_reset_password_token
    self.password_reset_token = nil
    self.password_reset_token_sent_at = nil
  end

  def password_reset_period_valid?
    password_reset_token_sent_at.present? && Time.current - password_reset_token_sent_at <= 60.minutes
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

  def digest(string)
    cost = if ActiveModel::SecurePassword
              .min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost: cost)
  end
end
