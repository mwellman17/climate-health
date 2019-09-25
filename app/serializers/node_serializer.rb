class NodeSerializer < ActiveModel::Serializer
  attributes :name, :full_name, :color, :category, :patient, :disease, :topic

  def name
    object.label
  end

  def full_name
    object.name
  end

  def color
    if object.category.name == "Earth System"
      return "blue"
    elsif object.category.name == "Health Impact"
      return "red"
    elsif object.category.name == "Human Impact"
      return "green"
    else
      return "grey"
    end
  end

  def category
    object.category.name
  end

  def patient
    if object.patients.length == 0
      return "None"
    end
    patients = []
    object.patients.each do |patient|
      patients << patient.name
    end
    return patients.join(', ')
  end

  def disease
    if object.diseases.length == 0
      return "None"
    end
    diseases = []
    object.diseases.each do |disease|
      diseases << disease.name
    end
    return diseases.join(', ')
  end

  def topic
    if object.topics.length == 0
      return "None"
    end
    topics = []
    object.topics.each do |topic|
      topics << topic.name
    end
    return topics.join(', ')
  end
end
