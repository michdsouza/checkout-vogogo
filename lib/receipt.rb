require 'active_support/inflector'

class Receipt

	def initialize(shopping_cart)
		@shopping_cart = shopping_cart
	end

	def itemized
		line_item = ""

		@shopping_cart.group_by(&:name).each do |name, items|
			line_item << "#{items.count} #{name.pluralize(items.count)}: " + "%.2f" % items.first.price
			line_item << "\n"
		end

		line_item
	end

	def total_price
		@shopping_cart.map(&:price).reduce(:+)	
	end

end