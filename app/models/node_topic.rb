class NodeTopic < ApplicationRecord
  belongs_to :node
  belongs_to :topic
end
