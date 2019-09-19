class DiseaseGroup < ApplicationRecord
  belongs_to :node
  belongs_to :disease
end
