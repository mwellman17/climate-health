class Link < ApplicationRecord
  validates :upstream_node, presence: true
  validates :downstream_node, presence: true

  def source
    node = Node.find_by(:name => self.upstream_node)
    node.id
  end

  def target
    node = Node.find_by(:name => self.downstream_node)
    node.id
  end
end
