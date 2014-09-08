class Cart

	attr_reader :total
	def initialize(pricing_rules)
		@line_items = []
		@total = 0
		@pricing_rules = pricing_rules
	end

	def add_line_item(product)
		@line_items << product
	end

	def print_itemized_list
		itemized_list = ''

		grouped_line_items = @line_items.group_by(&:name)
		grouped_line_items.each do |name, products|
			rules_for_product = @pricing_rules.select {|rule| rule.product_name == name}
			product_total = calculate_price_for(products.first, products.size, rules_for_product)
			itemized_list += "#{products.size} #{name.pluralize(products.size)}: $" + "%.2f" % product_total + "\n"
			@total += product_total
		end

		itemized_list
	end

	def print_total
		"Total: $" + "%.2f" % @total
	end

	def calculate_price_for(product, quantity, pricing_rules_for_product)
		total_price = 0
		remaining_quantity = quantity

		pricing_rules_for_product.each do |rule|
			rule_applied = rule.apply(remaining_quantity, product.price)
			total_price += rule_applied[:net_price]
			remaining_quantity = rule_applied[:items_left]
		end
		total_price += remaining_quantity * product.price
	end

end