class Todo < ApplicationRecord
  belongs_to :project
  belongs_to :user, optional: true

  scope :complete, -> { where(completed: true) }
  scope :incomplete, -> { where(completed: false) }
  default_scope { order(position: :asc) }

  acts_as_list scope: :project
  # broadcasts_to :project
  broadcasts_refreshes_to :project

  validates :name, presence: true

  def self.search(query)
    return all if query.blank?

    where(arel_table[:name].matches("%#{sanitize_sql_like(query)}%"))
  end
end
