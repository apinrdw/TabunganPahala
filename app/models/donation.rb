class Donation < ApplicationRecord
  validates :name, presence: true
  validates :amount, presence: true, numericality: true
end
