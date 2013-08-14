require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products

  test "buying a product" do
    LineItem.delete_all
    Order.delete_all
    saw = products(:one)

    # Visit the homepage
    get '/'
    assert_response :success
    assert_template "index"

    # Select a product to add to cart
    xml_http_request :post, '/line_items', product_id: saw.id
    assert_response :success

    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal saw, cart.line_items[0].product

    # Checkout
    get '/orders/new'
    assert_response :success
    assert_template "new"

    # Enter payment information
    post_via_redirect "/orders",
                      order: { name: "Fernando Paredes",
                               address: "123 Test Rd",
                               email: "nano@example.com",
                               pay_type: "Check" }
    assert_response :success
    assert_template "index"
    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.size

    # Verify Order was created
    orders = Order.all
    assert_equal 1, orders.size
    order = orders[0]

    assert_equal "Fernando Paredes", order.name
    assert_equal "123 Test Rd", order.address
    assert_equal "nano@example.com", order.email
    assert_equal "Check", order.pay_type

    assert_equal 1, order.line_items.size
    line_items = order.line_items[0]
    assert_equal saw, line_items.product

    mail = ActionMailer::Base.deliveries.last
    assert_equal ["nano@example.com"], mail.to
    assert_equal 'Fernando Paredes <from@example.com>', mail[:from].value
    assert_equal "Sell&Ship Order Confirmation", mail.subject
  end


end
