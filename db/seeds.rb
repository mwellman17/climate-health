require 'csv'

def import_file (dag_file, type)
  text = File.read(Rails.root.join('lib', 'seeds', dag_file))
  dag = CSV.parse(text, :headers => true, :encoding => 'ISO-8859-1')
  type == 'nodes' ? read_nodes(dag) : read_links(dag)
end

def read_nodes (nodes)
  current_nodes = Node.all
  current_topics = Topic.all
  nodes.each do |row|
    if !current_nodes.exists?(:name => row['node_name'])
      node = Node.new
      node.name = row['node_name']
      node.label = row['label']
      category_name = row['node_category']
      if Category.exists?(:name => category_name)
        category = Category.find_by(:name => category_name)
      else
        category = Category.new
        category.name = category_name
        category.save
      end
      node.category = category
      node.save

      topic_name = row['node_topic']
      disease_name = row['node_disease']
      patient_name = row['node_patient']

      if topic_name
        create_topic(node, topic_name)
      end

      if disease_name
        if Disease.exists?(:name => disease_name)
          disease = Disease.find_by(:name => disease_name)
        else
          disease = Disease.new
          disease.name = disease_name
          disease.save
        end
        disease_group = DiseaseGroup.new
        disease_group.node = node
        disease_group.disease = disease
        disease_group.save
      end

      if patient_name
        patients = patient_name.split(',')
        patients.each do |text|
          if Patient.exists?(:name => text)
            patient = Patient.find_by(:name => text)
          else
            patient = Patient.new
            patient.name = text
            patient.save
          end
          patient_group = PatientGroup.new
          patient_group.node = node
          patient_group.patient = patient
          patient_group.save
        end
      end
    else
      node = current_nodes.find_by(:name => row['node_name'])
      topic_name = row['node_topic']
      create_topic(node, topic_name)
    end
  end
end

def create_topic (node, topic_name)
  if Topic.exists?(:name => topic_name)
    topic = Topic.find_by(:name => topic_name)
  else
    topic = Topic.new
    topic.name = topic_name
    topic.save
  end
  node_topic = NodeTopic.new
  node_topic.node = node
  node_topic.topic = topic
  node_topic.save
end

def read_links (links)
  links.each do |row|
    link = Link.new
    link.upstream_node = row['upstream_node']
    link.downstream_node = row['downstream_node']
    link.value = row['betavalue']
    link.save
  end
end

NodeTopic.destroy_all
PatientGroup.destroy_all
DiseaseGroup.destroy_all
Node.destroy_all
Category.destroy_all
Disease.destroy_all
Patient.destroy_all
Topic.destroy_all
Link.destroy_all

import_file('DAG-nodes-cyclones.csv', 'nodes')
import_file('DAG-links-cyclones.csv', 'links')
import_file('DAG-nodes-rainfall.csv', 'nodes')
import_file('DAG-links-rainfall.csv', 'links')
