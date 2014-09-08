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

	def total_price_for(product, quantity, price_rules)
		total_price = 0
		remaining_quantity = quantity

		price_rules.each do |rule|
			rule_outcome = rule.apply(remaining_quantity, product.price)
			total_price += rule_outcome[:net_price]
			remaining_quantity = rule_outcome[:items_left]
		end
		total_price += remaining_quantity * product.price
	end

	#############################
	## Print formatted outputs ##
	#############################

	def print_itemized_list
		list_items = ''

		grouped_line_items = @line_items.group_by(&:name)
		grouped_line_items.each do |name, products|
			product_total = total_price_for(products.first, products.size, rules_for(name))
			@total += product_total
			list_items += format(products, product_total)			
		end
		list_items
	end

	def print_total
		"Total: $" + "%.2f" % @total
	end

	#######
	private
	#######

	def rules_for(product_name)
		@pricing_rules.select {|rule| rule.product_name == product_name}
	end

	def format(products, product_total)
		"#{products.size} #{products.first.name.pluralize(products.size)}: $" + "%.2f" % product_total + "\n"
	end

end