require 'price_rule'

describe PriceRule do

	describe '#load_pricing_rule' do

		it 'creates a bulk discount rule' do
			price_rule = PriceRule.new('3 apples cost $1.30')
			expect(price_rule.product_name).to eq 'apple'
			expect(price_rule.at_quantity).to eq 3
			expect(price_rule.discount_type).to eq 'bulk'
			expect(price_rule.price_factor).to eq 1.30
		end

		it 'creates a buy one get one free discount rule' do
			price_rule = PriceRule.new('Buy 1 orange get 1 free')
			expect(price_rule.product_name).to eq 'orange'
			expect(price_rule.at_quantity).to eq 2
			expect(price_rule.discount_type).to eq 'percent'
			expect(price_rule.price_factor).to eq 0
		end

		it 'creates a buy one get one half off discount rule' do
			price_rule = PriceRule.new('Buy 1 banana get 1 half off')
			expect(price_rule.product_name).to eq 'banana'
			expect(price_rule.at_quantity).to eq 2
			expect(price_rule.discount_type).to eq 'percent'
			expect(price_rule.price_factor).to eq 50
		end

	end

	describe '#percent_net_price' do

		let(:rule) { PriceRule.new('Buy 1 orange get 1 half off') }
		
		it 'calculates for percent discount on nth item' do
			expect(rule.percent_net_price(1, 1.00)).to eq 1.50
			expect(rule.percent_net_price(5, 1.00)).to eq 7.5
		end
	end

  describe '#apply' do
		
		context 'bulk discount' do
			let(:rule) { PriceRule.new('3 apples cost $1.30') }

			it 'for single batch' do
				applied_rule = rule.apply(3, 0.50)
				expect(applied_rule[:net_price]).to eq 1.30
				expect(applied_rule[:items_left]).to eq 0
			end

			it 'for multiple batches' do
				applied_rule = rule.apply(10, 0.50)
				expect(applied_rule[:net_price]).to eq 3.90
				expect(applied_rule[:items_left]).to eq 1
			end

			it 'for zero batches' do
				applied_rule = rule.apply(2, 0.50)
				expect(applied_rule[:net_price]).to eq 0
				expect(applied_rule[:items_left]).to eq 2
			end
		end		

		context 'percentage discount' do
			let(:rule) { PriceRule.new('Buy 1 orange get 1 half off') }

			it 'for single batch' do
				applied_rule = rule.apply(2, 1.00)
				expect(applied_rule[:net_price]).to eq 1.50
				expect(applied_rule[:items_left]).to eq 0
			end

			it 'for multiple batches' do
				applied_rule = rule.apply(11, 1.00)
				expect(applied_rule[:net_price]).to eq 7.50
				expect(applied_rule[:items_left]).to eq 1
			end

			it 'for zero batches' do
				applied_rule = rule.apply(1, 1.00)
				expect(applied_rule[:net_price]).to eq 0
				expect(applied_rule[:items_left]).to eq 1
			end
		end

	end
end