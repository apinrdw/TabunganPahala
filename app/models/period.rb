class Period < ApplicationRecord
  as_enum :status, { active: 1, inactive: 0 }

  validates :name, presence: true
  validate :only_one_active_period, if: :active?

  after_initialize :set_defaults

  private
    def set_defaults
      self.status ||= :inactive
    end

    def only_one_active_period
      if self.class.actives.size > 0
        errors.add(:status, 'only one active period')
      end
    end
end
