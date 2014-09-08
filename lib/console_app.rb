require_relative 'cart'
require_relative 'price_rule'
require_relative 'product'
require 'readline'
require 'yaml'

# Load product prices
prices = YAML.load_file('prices.yml')

# Load pricing rules from a file
pricing_schemes = File.read('pricing_rules.txt')
pricing_rules = []
pricing_schemes.split("\n").each { |pricing_scheme| pricing_rules << PriceRule.new(pricing_scheme) }

cart = Cart.new(pricing_rules)

# Start adding items to shopping cart
puts "Add one item at a time to the cart. Type 'quit' to complete"

loop do
  line = Readline::readline('> ')
  break if line.nil? || line == 'quit'
  if prices[line].nil?
		puts "We don't have this item. Try again."
	else
		cart.add_line_item(Product.new(line, prices[line]))
	end
end

# Calculate and print itemized list of cart items
puts cart.print_itemized_list

# Calculate and print cart total
puts cart.print_total
