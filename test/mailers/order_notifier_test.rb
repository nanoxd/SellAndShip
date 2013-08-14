require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    mail = OrderNotifier.received(order(:one))
    assert_equal "Sell&Ship Order Confirmation", mail.subject
    assert_equal ["me@example.com"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match /1 x Saw/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderNotifier.shipped(orders(:one))
    assert_equal "Sell%Ship Order has Shipped", mail.subject
    assert_equal ["me@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "/<td>1&times;<\/td>\s*<td>Saw<\/td>/", mail.body.encoded
  end

end
