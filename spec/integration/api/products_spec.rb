require 'rails_helper'

RSpec.describe 'Products Controller' do

  before do
    host! 'localhost:3000'
  end

  describe 'GET#index' do
    before do
      @product_1 = create(:product, price: 900, category: 'makeup')
      @product_2 = create(:product, price: 700, category: 'makeup')
      @product_3 = create(:product, price: 1500, category: 'tools')
      @product_4 = create(:product, price: 400, category: 'makeup')
      @product_5 = create(:product, price: 2000, category: 'brushes')
      @product_6 = create(:product, price: 400, category: 'brushes')
    end

    context 'without filters' do
      before do
        get '/api/products'
      end

      it 'responds with success' do
        expect(response.status).to eq(200)
      end

      it 'renders products list' do
        products = [@product_4, @product_6, @product_2, @product_1, @product_3, @product_5]

        products_json = products.map do |product|
          {
            id: product.id,
            name: product.name,
            sold_out: product.sold_out,
            category: product.category,
            under_sale: product.under_sale,
            price: product.price,
            sale_price: product.sale_price
          }
        end

        expected_json = { products: products_json, meta: { total_pages: 1, last_page: true } }

        expect(response.body).to match_json_expression(expected_json)
      end
    end

    context 'with filters' do
      
      context 'with price' do
        before do
          get '/api/products', params: {
            price: 400
          }
        end

        it 'responds with success' do
          expect(response.status).to eq(200)
        end

        it 'renders products list' do
          products_json = [@product_4, @product_6].map do |product|
            {
              id: product.id,
              name: product.name,
              sold_out: product.sold_out,
              category: product.category,
              under_sale: product.under_sale,
              price: product.price,
              sale_price: product.sale_price
            }
          end

          expected_json = { products: products_json, meta: { total_pages: 1, last_page: true } }

          expect(response.body).to match_json_expression(expected_json)
        end
      end

      context 'with category' do
        before do
          get '/api/products', params: {
            category: 'makeup'
          }
        end

        it 'responds with success' do
          expect(response.status).to eq(200)
        end

        it 'renders products list' do
          products_json = [@product_2, @product_1, @product_4].map do |product|
            {
              id: product.id,
              name: product.name,
              sold_out: product.sold_out,
              category: product.category,
              under_sale: product.under_sale,
              price: product.price,
              sale_price: product.sale_price
            }
          end

          expected_json = { products: products_json, meta: { total_pages: 1, last_page: true } }

          expect(response.body).to match_json_expression(expected_json)
        end
      end

      context 'with category and price' do
        before do
          get '/api/products', params: {
            category: 'makeup',
            price: 700
          }
        end

        it 'responds with success' do
          expect(response.status).to eq(200)
        end

        it 'renders products list' do
          products_json = [@product_2].map do |product|
            {
              id: product.id,
              name: product.name,
              sold_out: product.sold_out,
              category: product.category,
              under_sale: product.under_sale,
              price: product.price,
              sale_price: product.sale_price
            }
          end

          expected_json = { products: products_json, meta: { total_pages: 1, last_page: true } }

          expect(response.body).to match_json_expression(expected_json)
        end
      end

      context 'with sorting' do
        before do
          get '/api/products', params: {
            sort_order: 'desc'
          }
        end

        it 'responds with success' do
          expect(response.status).to eq(200)
        end

        it 'renders products list' do
          products = [@product_5, @product_3, @product_1, @product_2, @product_6, @product_4]
          products_json = products.map do |product|
            {
              id: product.id,
              name: product.name,
              sold_out: product.sold_out,
              category: product.category,
              under_sale: product.under_sale,
              price: product.price,
              sale_price: product.sale_price
            }
          end

          expected_json = { products: products_json, meta: { total_pages: 1, last_page: true } }

          expect(response.body).to match_json_expression(expected_json)
        end
      end

      context 'with pagination' do
        before do
          get '/api/products', params: {
            page: 1,
            per_page: 2
          }
        end

        it 'responds with success' do
          expect(response.status).to eq(200)
        end

        it 'renders products list' do
          products_json = [@product_6, @product_4].map do |product|
            {
              id: product.id,
              name: product.name,
              sold_out: product.sold_out,
              category: product.category,
              under_sale: product.under_sale,
              price: product.price,
              sale_price: product.sale_price
            }
          end

          expected_json = { products: products_json, meta: { total_pages: 3, last_page: false } }

          expect(response.body).to match_json_expression(expected_json)
        end
      end

    end
  end

  describe 'GET#show' do
    before do
      @product_1 = create(:product)
      @product_2 = create(:product)
    end

    context 'with valid product' do
      before do
        get "/api/products/#{@product_1.id}"
      end

      it 'responds with success' do
        expect(response.status).to eq(200)
      end

      it 'renders product' do
        expected_json = {
          product: {
            id: @product_1.id,
            name: @product_1.name,
            sold_out: @product_1.sold_out,
            category: @product_1.category,
            under_sale: @product_1.under_sale,
            price: @product_1.price,
            sale_price: @product_1.sale_price
          }
        }

        expect(response.body).to match_json_expression(expected_json)
      end
    end

    context 'with product does not exist' do
      before do
        get '/api/products/invalid'
      end

      it 'reponds with failure' do
        expect(response.status).to eq(404)
      end

      it 'renders error' do
        expected_json = {
          errors: [{
            message: 'Product not found'
          }]
        }
        
        expect(response.body).to match_json_expression(expected_json)
      end
    end
  end
end