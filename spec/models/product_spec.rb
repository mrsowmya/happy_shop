require 'rails_helper'

RSpec.describe Product, type: :model do
  
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:category) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:sale_price) }

  it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }
  it { is_expected.to validate_numericality_of(:sale_price).is_greater_than(0) }
end
