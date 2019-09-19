require 'csv'

nodes_text = File.read(Rails.root.join('lib', 'seeds', 'DAG-nodes.csv'))
dag_nodes = CSV.parse(nodes_text, :headers => true, :encoding => 'ISO-8859-1')
links_text = File.read(Rails.root.join('lib', 'seeds', 'DAG-links.csv'))
dag_links = CSV.parse(links_text, :headers => true, :encoding => 'ISO-8859-1')

dag_nodes.each do |row|
  node = Node.new
  node.name = row['node_name']
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
end

dag_links.each do |row|
  link = Link.new
  link.upstream_node = row['upstream_node']
  link.downstream_node = row['downstream_node']
  link.value = row['betavalue']
  link.save
end
