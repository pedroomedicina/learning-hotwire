class Todo < ApplicationRecord
  belongs_to :project
  belongs_to :user, optional: true

  scope :complete, -> { where(completed: true) }
  scope :incomplete, -> { where(completed: false) }
  default_scope { order(position: :asc) }

  acts_as_list scope: :project

  validates :name, presence: true
end
