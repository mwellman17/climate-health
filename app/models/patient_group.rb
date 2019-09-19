class PatientGroup < ApplicationRecord
  belongs_to :node
  belongs_to :patient
end
