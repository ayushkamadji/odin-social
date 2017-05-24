class Friendship < ApplicationRecord
  # Relations
  belongs_to :first_user, class_name: 'User'
  belongs_to :second_user, class_name: 'User'

  # Callbacks
  before_validation :sort_user_ids

  # Validations
  validates_uniqueness_of :second_user_id, scope: :first_user_id
  validate :not_self_referential


  private


    def sort_user_ids
      if first_user_id > second_user_id
        first = first_user_id
        self.first_user_id = second_user_id
        self.second_user_id = first
      end
    end

    def not_self_referential
      errors.add(:base, "First user and second user cannot be the same") if first_user_id == second_user_id
    end
end
