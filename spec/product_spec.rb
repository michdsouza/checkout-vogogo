require 'product.rb'

describe Product do

	it "should create a new product" do
		product = Product.new("apple", 1)
		expect(product.name).to eq "apple"
		expect(product.price).to eq 1
	end	
end