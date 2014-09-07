class PriceRule

	attr_reader :product_name, :at_quantity, :discount_type, :price_factor

	def initialize(product_name, at_quantity, discount_type, price_factor)
		@product_name = product_name
		@at_quantity = at_quantity
		@discount_type = discount_type
		@price_factor = price_factor
	end

	def apply(number_of_items, price)
		times_to_apply, items_left = number_of_items.divmod(@at_quantity)
		return {net_price: (times_to_apply * @price_factor).round(2), items_left: items_left} if @discount_type == 'bulk'
		return {net_price: (times_to_apply * (1 + @price_factor/100.0) * price).round(2), items_left: items_left} if @discount_type == 'percent'
	end

end