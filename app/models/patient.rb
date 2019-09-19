class Patient < ApplicationRecord
  validates :name, presence: true

  has_many :patient_groups
  has_many :nodes, through: :patient_groups
end
