require 'price_rule'

describe PriceRule do

  describe '#apply' do
		
		context 'bulk discount' do
			let(:rule) { PriceRule.new('apple', 3, 'bulk', 1.30) }

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
			let(:rule) { PriceRule.new('orange', 2, 'percent', 50) }

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