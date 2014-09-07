require_relative 'product'
require_relative 'receipt'
require 'yaml'

prices = YAML.load_file('prices.yml')

shopping_cart = []
shopping_cart << Product.new("apple", prices["apple"] || 0)
shopping_cart << Product.new("orange", prices["orange"] || 0)

receipt = Receipt.new(shopping_cart)
puts receipt.itemized
puts receipt.total_price