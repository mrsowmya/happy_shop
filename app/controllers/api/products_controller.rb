class Api::ProductsController < ApplicationController

  def index
    products = ProductList.new(product_params)
                          .list

    render json: products, root: 'products',
                           meta: { total_pages: products.total_pages, last_page: products.last_page? },
                           each_serializer: ProductSerializer
  end

  def show
    product = Product.find(params[:id])

    render json: product, root: 'product'
  end

  private

  def product_params
    {
      category: params[:category],
      price: params[:price],
      page: params[:page],
      per_page: params[:per_page],
      sort_order: params[:sort_order]
    }
  end
end
