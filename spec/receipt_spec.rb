require 'receipt.rb'
require 'product.rb'

describe Receipt do

	let(:product1) { Product.new("apple", 0.50) }
	let(:product2) { Product.new("orange", 0.75) }
	let(:product3) { Product.new("apple", 0.50) }
	let!(:shopping_cart) { 
		shopping_cart = []
		shopping_cart << product1 << product2 << product3
	}

	it "should print itemized receipt" do
		expect(Receipt.new(shopping_cart).itemized).to eq "2 apples: 0.50\n1 orange: 0.75\n"
	end

	it "should print total price" do
		expect(Receipt.new(shopping_cart).total_price).to eq 1.75
	end

end