require 'rails_helper'

RSpec.describe User, type: :model do
  # Association Test
  # User should have many todos
  it { should have_many(:todos) }

  # Validation Tests
  it { should validate_presence_of :name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password_digest }
end
