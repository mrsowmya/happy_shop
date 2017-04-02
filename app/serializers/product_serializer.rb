class ProductSerializer < ActiveModel::Serializer

  attributes :id,
             :name,
             :sold_out,
             :category,
             :under_sale,
             :price,
             :sale_price
end