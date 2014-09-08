require 'active_support/inflector'

class PriceRule

	attr_reader :product_name, :at_quantity, :discount_type, :price_factor

	def initialize(pricing_scheme)
		load_pricing_rule(pricing_scheme)
	end

	def load_pricing_rule(pricing_scheme)
		search_terms = ['cost', 'free', 'half']
		@pricing_scheme_parts = pricing_scheme.split
		matching_term = @pricing_scheme_parts.select { |term| search_terms.include?(term) }.first
		self.send("parse_for_#{matching_term}")
	end

	def parse_for_cost
		@product_name = @pricing_scheme_parts[1].singularize
		@at_quantity = @pricing_scheme_parts[0].to_i
		@discount_type = 'bulk'
		@price_factor = @pricing_scheme_parts[3].split('$')[1].to_f
	end

	def parse_for_free
		@product_name = @pricing_scheme_parts[2].singularize
		@at_quantity = @pricing_scheme_parts[1].to_i + 1
		@discount_type = 'percent'
		@price_factor = 0
	end

	def parse_for_half
		@product_name = @pricing_scheme_parts[2].singularize
		@at_quantity = @pricing_scheme_parts[1].to_i + 1
		@discount_type = 'percent'
		@price_factor = 50	
	end

	def apply(number_of_items, price)
		times_to_apply, items_left = number_of_items.divmod(@at_quantity)
		return {net_price: bulk_net_price(times_to_apply), items_left: items_left} if @discount_type == 'bulk'
		return {net_price: percent_net_price(times_to_apply, price), items_left: items_left} if @discount_type == 'percent'
	end

	def percent_net_price(times_to_apply, price)
		full_price_items = times_to_apply * price
		discounted_items = times_to_apply * (price * @price_factor/100.0).round(2)
		(full_price_items + discounted_items).round(2)		
	end

	def bulk_net_price(times_to_apply)
		(times_to_apply * @price_factor).round(2)
	end
end