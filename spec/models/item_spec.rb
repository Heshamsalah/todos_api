require 'rails_helper'

RSpec.describe Item, type: :model do
    # Association Test
    # Ensure that Item model belongs to single todo record
    it { should belong_to(:todo) }
    # Validation Test
    # Ensure that Item has name before saving
    it { should validate_presence_of(:name) }
end
