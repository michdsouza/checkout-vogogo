class Cart

	def initialize
		@line_items = []
	end

	def add_line_item(product)
		@line_items << product
	end

	def total(pricing_rules)
		grouped_hash = @line_items.group_by(&:name)
		total = 0
		grouped_hash.each do |k,v|
			rules_for_product = pricing_rules.select {|rule| rule.product_name == k}
			total += calculate_price_for(v.first, v.size, rules_for_product)
		end
		total
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