class ProductList

  def initialize(attributes = {})
    @category   = attributes[:category]
    @price      = attributes[:price]
    @page       = attributes[:page]
    @per_page   = attributes[:per_page]
    @sort_order = build_sort_order(attributes[:sort_order])
  end

  def list
    products.page(@page)
            .per(@per_page)
  end

  private

  SORT_ORDER = ['asc', 'desc'].freeze

  def products
    @products ||= begin
      _products = Product.order("price #{@sort_order}")

      _products = _products.where(category_filter) if @category.present?
      _products = _products.where(price_filter) if @price.present?

      _products
    end
  end

  def category_filter
    { category: @category }
  end

  def price_filter
    { price: @price }
  end

  def build_sort_order(sort_order)
    return sort_order if sort_order.present? && SORT_ORDER.include?(sort_order.downcase)

    SORT_ORDER.first
  end
  
end