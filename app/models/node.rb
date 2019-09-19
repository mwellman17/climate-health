class Node < ApplicationRecord
  validates :name, presence: true

  has_many :links
  has_many :patient_groups
  has_many :disease_groups
  has_many :node_topics
  has_many :patients, through: :patient_groups
  has_many :diseases, through: :disease_groups
  has_many :topics, through: :node_topics
  belongs_to :category
end
