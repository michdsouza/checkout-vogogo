require_relative 'price_rule'

class RuleParser
	def self.ingest(file_name)
		rules = []
		File.read(file_name).split("\n").each do |pricing_scheme|
			rules << load_pricing_rule(pricing_scheme)
		end
		rules
	end

	def self.load_pricing_rule(pricing_scheme)
		search_terms = ['cost', 'free', 'half']
		pricing_scheme_parts = pricing_scheme.split
		matching_term = pricing_scheme_parts.select { |term| search_terms.include?(term) }.first
		self.send("parse_for_#{matching_term}", pricing_scheme_parts)
	end

	private

	def self.parse_for_cost(pricing_scheme_parts)
		product_name = pricing_scheme_parts[1].singularize
		at_quantity = pricing_scheme_parts[0].to_i
		discount_type = 'bulk'
		price_factor = pricing_scheme_parts[3].split('$')[1].to_f

		PriceRule.new(product_name, at_quantity, discount_type, price_factor)
	end

	def self.parse_for_free(pricing_scheme_parts)
		product_name = pricing_scheme_parts[2].singularize
		at_quantity = pricing_scheme_parts[1].to_i + 1
		discount_type = 'percent'
		price_factor = 0

		PriceRule.new(product_name, at_quantity, discount_type, price_factor)
	end

	def self.parse_for_half(pricing_scheme_parts)
		product_name = pricing_scheme_parts[2].singularize
		at_quantity = pricing_scheme_parts[1].to_i + 1
		discount_type = 'percent'
		price_factor = 50

		PriceRule.new(product_name, at_quantity, discount_type, price_factor)
	end

end
