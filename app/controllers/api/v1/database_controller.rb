class Api::V1::DatabaseController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  before_action :authenticate_user!

  def sankey
    nodes = Node.all
    links = []
    Link.all.each do |link|
      source = nodes.map(&:name).index(link.upstream_node)
      target = nodes.map(&:name).index(link.downstream_node)
      value = link.value
      result = { source: source, target: target, value: value}
      links << result
    end
    render json: {
      nodes: ActiveModel::Serializer::CollectionSerializer.new(nodes, each_serializer: NodeSerializer),
      links: links
    }
  end
end
