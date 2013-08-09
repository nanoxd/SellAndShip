require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  def new_product(image_url)
    Product.new(title: "Harry Potter and the Chamber of Secrets.",
                description: "A fantastic book on a wizard and his snake.",
                price: 1,
                image_url: image_url)
  end

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "price is positive" do
    product = Product.new(title: "Harry Potter and the Camber of Secrets",
                          description: "A fantastic book on a wizard and his snake.",
                          image_url: "hp.jpg")
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
      product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 1
    assert product.valid?, product.errors[:title]
  end


  test "image url should work" do
    good_images = %w{ harry.gif harry.jpg harry.png HARRY.JPG HARRY.Jpg http://google.com/i/harry.gif }

    good_images.each do |image|
      assert new_product(image).valid?, "#{image} should be valid."
    end
  end

  test "image url should not work" do
    bad_images = %w{ harry.doc harry.gif.html harry.svg }

    bad_images.each do |image|
      assert new_product(image).invalid?, "#{image} shoudn't be valid"
    end
    
  end

  test "product is not valid without a unique title" do
    product = Product.new(title: products(:one).title,
                          description: "This shouldn't work.",
                          price: 1,
                          image_url: "screws.gif")
    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]
  end

end
