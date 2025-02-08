class User < ApplicationRecord
  has_many :sessions, dependent: :destroy
  has_many :memberships
  has_many :projects, through: :memberships
  has_many :todos, dependent: :nullify

  has_secure_password
  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :name, presence: true

  def gravatar_url(**options)
    hash = Digest::MD5.hexdigest(email_address)
    options.reverse_merge!(default: :mp, rating: :pg, size: 24)
    "https://secure.gravatar.com/avatar/#{hash}.png?#{options.to_param}"
  end
end
