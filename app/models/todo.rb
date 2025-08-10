class Todo < ApplicationRecord
  belongs_to :project
  belongs_to :user, optional: true

  scope :complete, -> { where(completed: true) }
  scope :incomplete, -> { where(completed: false) }
  default_scope { order(position: :asc) }

  acts_as_list scope: :project
  broadcasts_refreshes_to :project

  after_create_commit do
    broadcast_action_later_to user, action: :prepend, partial: "todos/todo", locals: { inline: true }
  end

  after_update_commit do
    if user_id_previously_changed?
      if (previous_user = User.find_by(id: user_id_previously_was))
        broadcast_remove_to previous_user
      end
      broadcast_action_later_to user, action: :prepend, partial: "todos/todo", locals: { inline: true }
    else
      broadcast_replace_later_to user, partial: "todos/todo", locals: { inline: true }
    end
  end

  after_destroy_commit do
    broadcast_remove_to user
  end  

  validates :name, presence: true

  def self.search(query)
    return all if query.blank?

    where(arel_table[:name].matches("%#{sanitize_sql_like(query)}%"))
  end
end
