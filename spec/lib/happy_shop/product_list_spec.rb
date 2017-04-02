require 'rails_helper'

RSpec.describe ProductList do

  describe '#initialize' do
    it 'sets attributes' do
      product_list = described_class.new(category: 'makeup', 
                                         price: 400,
                                         page: 1,
                                         per_page: 10,
                                         sort_order: 'desc')

      expect(product_list.instance_variable_get(:@category)).to eq('makeup')
      expect(product_list.instance_variable_get(:@price)).to eq(400)
      expect(product_list.instance_variable_get(:@page)).to eq(1)
      expect(product_list.instance_variable_get(:@per_page)).to eq(10)
      expect(product_list.instance_variable_get(:@sort_order)).to eq('desc')
    end
  end

  describe '#list' do
    before do
      @product_1 = create(:product, price: 900, category: 'makeup')
      @product_2 = create(:product, price: 700, category: 'makeup')
      @product_3 = create(:product, price: 1500, category: 'tools')
      @product_4 = create(:product, price: 400, category: 'makeup')
      @product_5 = create(:product, price: 2000, category: 'brushes')
      @product_6 = create(:product, price: 400, category: 'brushes')
    end

    context 'with category' do
      it 'returns products' do
        product_list = described_class.new(category: 'tools')

        expect(product_list.list).to eq([@product_3])       
      end
    end

    context 'with price' do
      it 'returns products' do
        product_list = described_class.new(price: 700)

        expect(product_list.list).to eq([@product_2])
      end
    end

    context 'with category and price' do
      it 'returns products' do
        product_list = described_class.new(category: 'makeup', price: 400)

        expect(product_list.list).to eq([@product_4])
      end
    end

    context 'with sort_order' do
      context 'with sort_order desc' do
        it 'returns products sorted based on order' do
          product_list = described_class.new(sort_order: 'desc')

          expect(product_list.list).to eq([@product_5, @product_3, @product_1, @product_2, @product_4, @product_6])
        end
      end

      context 'with sort_order asc' do
        it 'returns products sorted based on sort_order' do
          product_list = described_class.new(sort_order: 'asc')

          expect(product_list.list).to eq([@product_4, @product_6, @product_2, @product_1, @product_3, @product_5])
        end
      end
    end

    context 'with page and per_page' do
      it 'returns products' do
        product_list = described_class.new(page: 1, per_page: 2)

        expect(product_list.list).to eq([@product_6, @product_4])
      end
    end
  end
end