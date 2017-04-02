require 'rails_helper'

RSpec.describe ProductSerializer do

  before do
    @product    = create(:product)
    @serializer = described_class.new(@product)
  end

  describe '#id' do
    it 'returns id' do
      expect(@serializer.id).to eq(@product.id)
    end
  end

  describe '#name' do
    it 'returns name' do
      expect(@serializer.name).to eq(@product.name)
    end
  end

  describe '#sold_out' do
    it 'returns sold_out' do
      expect(@serializer.sold_out).to eq(@product.sold_out)
    end
  end

  describe '#category' do
    it 'returns category' do
      expect(@serializer.category).to eq(@product.category)
    end
  end

  describe '#under_sale' do
    it 'returns under_sale' do
      expect(@serializer.under_sale).to eq(@product.under_sale)
    end
  end

  describe '#price' do
    it 'returns price' do
      expect(@serializer.price).to eq(@product.price)
    end
  end

  describe '#sale_price' do
    it 'returns sale_price' do
      expect(@serializer.sale_price).to eq(@product.sale_price)
    end
  end
end