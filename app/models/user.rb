class User < ApplicationRecord
  before_create :confirmation_token
  has_secure_password
  validates :email, presence: true,
                  format: /\A\S+@\S+\z/,
                  uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8, allow_blank: true }
  has_one_attached :avatar

  def self.authenticate(email, password)
    user = User.find_by(email: email)
    user && user.authenticate(password)
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  private
  
  def confirmation_token
      if self.confirm_token.blank?
          self.confirm_token = SecureRandom.urlsafe_base64.to_s
      end
    end
end
