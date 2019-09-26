class Api::V1::DatabaseController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  before_action :authenticate_user!

  def sankey
    nodes = Node.all
    render_json(nodes)
  end

  def cyclones
    nodes = Node.all.joins(:topics).merge(Topic.where(:name => "Tropical Cyclones"))
    render_json(nodes)
  end

  def rainfall
    nodes = Node.all.joins(:topics).merge(Topic.where(:name => "Rainfall"))
    render_json(nodes)
  end

  def render_json (nodes)
    links = []
    Link.all.each do |link|
      source = nodes.map(&:name).index(link.upstream_node)
      target = nodes.map(&:name).index(link.downstream_node)
      if source && target
        value = link.value
        result = { source: source, target: target, value: value}
        links << result
      end
    end
    render json: {
      nodes: ActiveModel::Serializer::CollectionSerializer.new(nodes, each_serializer: NodeSerializer),
      links: links
    }
  end
end
