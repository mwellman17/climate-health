class Disease < ApplicationRecord
  validates :name, presence: true

  has_many :disease_groups
  has_many :nodes, through: :disease_groups
end
