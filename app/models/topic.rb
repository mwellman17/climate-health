class Topic < ApplicationRecord
  validates :name, presence: true

  has_many :node_topics
  has_many :nodes, through: :node_topics
end
