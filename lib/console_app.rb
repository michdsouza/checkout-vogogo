require_relative 'product'
require_relative 'price_rules'
require 'yaml'

prices = YAML.load_file('prices.yml')

pricing_rules = []
pricing_rules << PriceRule.new('apple', 3, 'fixed', 1.30)
pricing_rules << PriceRule.new('orange', 2, 'percent', 50)

cart = Cart.new

# Initialization complete. Add products to cart.

cart.add_line_item(Product.new('apple', prices['apple'] || 0)


# Item addition complete. Calculate cart total

cart.total(pricing_rules)
