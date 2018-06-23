require 'rails_helper'

RSpec.describe Todo, type: :model do
  # Association Test
  # Ensure Todo model has 1:m relationship with Item
  it { should have_many(:items).dependent(:destroy) }

  # Validation Tests
  # Ensure columns title and created_by are present before saving
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:created_by) }
end
