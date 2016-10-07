class Period < ApplicationRecord
  as_enum :status, { active: 1, inactive: 0 }

  has_many :donations

  validates :name, presence: true
  validate :only_one_active_period, if: :active?

  after_initialize :set_defaults

  def toggle_status
    active? ? inactive! : active!

    if save
      { notice: "#{name} period was successfully updated to #{status}" }
    else
      { alert: "Error occurred: #{errors.full_messages.join(', ')}" }
    end
  end

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
