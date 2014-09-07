require 'cart.rb'
require 'product.rb'
require 'price_rule.rb'
require 'pry'

describe Cart do

	context '#add_line_item' do
		let(:cart) { Cart.new }

		it 'adds item' do
			item = Product.new('apple', 0.50)
			expect(cart.add_line_item(item).size).to eq(1)
		end
	end

	context '#total' do
		let(:item1) { Product.new('apple', 0.50) }
		let(:item2) { Product.new('apple', 0.50) }
		let(:item3) { Product.new('orange', 1.00) }
		let(:cart) { 
			cart = Cart.new
			cart.add_line_item(item1)
			cart.add_line_item(item2)
			cart.add_line_item(item3)
			cart
		}
		let(:pricing_rules) {
			rules = []
			rules << PriceRule.new('Buy 1 apple get 1 free')
			rules << PriceRule.new('Buy 1 orange get 1 half off')
			rules
		}

		it 'returns cart total' do
			expect(cart.total(pricing_rules)).to eq(1.50)
		end
	end

end