# HappyShop

## API Endpoints and Sample Requests

---------------------------------------------------------------------------------------

###1. [GET] Products

---------------------------------------------------------------------------------------

`curl -v -H "Content-Type: application/json" -X GET https://happy-shop.herokuapp.com//api/products`

**Optional Fields**

1. `:page` (Integer)
2. `:per_page` (Integer) - (Default 10)
3. `:category` (String)
4. `:price` (Integer)
5. `:sort_order` (String) - Allowed Values - ['asc', 'desc']

###Sample Response
===============================================
```javascript
HTTP/1.1 200 OK

{
  "products":[
    {
      "id":6,
      "name":"Eye Lash Curler",
      "sold_out":false,
      "category":"tools",
      "under_sale":false,
      "price":400,
      "sale_price":350
    },
    {
      "id":3,
      "name":"White Super Fresh Compact",
      "sold_out":false,
      "category":"makeup",
      "under_sale":false,
      "price":400,
      "sale_price":400
    }
  ],
  "meta":{
    "total_pages":1,"
    last_page":true
  }
}
```

---------------------------------------------------------------------------------------

###2. [GET] Product

---------------------------------------------------------------------------------------

`curl -v -H "Content-Type: application/json" -X GET https://happy-shop.herokuapp.com//api/products/:product_id`

###Sample Response
===============================================
```javascript

HTTP/1.1 200 OK

{
  "product":{
    "id":6,
    "name":"Eye Lash Curler",
    "sold_out":false,
    "category":"tools",
    "under_sale":false,
    "price":400,
    "sale_price":350
  }
}
```

###Error Response
===============================================
```javascript
HTTP/1.1 404 Not Found

{
  "errors":[{
    "message":"Product not found"
  }]
}

```
---------------------------------------------------------------------------------------
