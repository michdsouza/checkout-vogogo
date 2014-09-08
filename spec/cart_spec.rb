require 'cart.rb'
require 'product.rb'
require 'price_rule.rb'

describe Cart do
	let(:pricing_rules) {
		rules = []
		# (product_name, at_quantity, discount_type, price_factor)
		rules << PriceRule.new('apple', 2, 'percent', 0)
		rules << PriceRule.new('orange', 2, 'percent', 50)
		rules
	}
	let(:cart) { Cart.new(pricing_rules) }

	describe '#add_line_item' do
		it 'adds item' do
			item = Product.new('apple', 0.50)
			expect(cart.add_line_item(item).size).to eq(1)
		end
	end

	describe '#total_price_for' do
		let(:apple) { Product.new('apple', 0.50) }
		let(:apple_rules) { pricing_rules.select { |rule| rule.product_name ==  apple.name } }

		it 'returns price for product' do
			expect(cart.total_price_for(apple, 2, apple_rules)).to eq(0.50)
		end
	end

	describe '#print_itemized_list' do
		it 'returns formatted list' do
			cart.add_line_item(Product.new('apple', 0.50))
			expect(cart.print_itemized_list).to eq("1 apple: $0.50\n")
		end
	end

	describe '#print_total' do
		it 'returns total price' do
			cart.add_line_item(Product.new('apple', 0.50))
			cart.print_itemized_list
			expect(cart.print_total).to eq("Total: $0.50")
		end
	end



end