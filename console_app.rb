require 'readline'
require 'require_all'
require 'yaml'
require_all 'lib'

# Load product prices
prices = YAML.load_file('./fixtures/prices.yml')

# Load pricing rules
pricing_rules = RuleParser.ingest('./fixtures/pricing_rules.txt')

# Start adding items to shopping cart
cart = Cart.new(pricing_rules)
puts "Add one item at a time to the cart. Type 'quit' to complete"

loop do
  line = Readline::readline('> ')
  break if line.nil? || line == 'quit'
  if prices[line].nil?
		puts "We do not have this item. Try again."
	else
		cart.add_line_item(Product.new(line, prices[line]))
	end
end

# Calculate and print itemized list of cart items
puts cart.print_itemized_list

# Calculate and print cart total
puts cart.print_total
