require_relative 'cart'
require_relative 'price_rule'
require_relative 'product'
require 'yaml'

# Load product prices
prices = YAML.load_file('prices.yml')

# Load pricing rules from a file
pricing_schemes = File.read('pricing_rules.txt')
pricing_rules = []
pricing_schemes.split("\n").each { |pricing_scheme| pricing_rules << PriceRule.new(pricing_scheme) }

# Start adding items to shopping cart
cart = Cart.new
cart.add_line_item(Product.new('apple', prices['apple'] || 0))

# Calculate cart itemized list and total
cart.total(pricing_rules)
