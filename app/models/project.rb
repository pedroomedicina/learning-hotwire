class Project < ApplicationRecord
  belongs_to :user
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :todos, dependent: :destroy

  validates :name, presence: true

  before_validation do
    self.user ||= Current.user
    self.memberships.where(user: Current.user).first_or_initialize
  end
end
