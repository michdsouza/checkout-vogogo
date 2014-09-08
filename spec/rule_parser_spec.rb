require 'rule_parser.rb'

describe RuleParser do

	describe '#ingest' do

		it 'load pricing rules' do
			expect(RuleParser).to receive(:load_pricing_rule).thrice
			rules = RuleParser.ingest('./fixtures/pricing_rules.txt')
			expect(rules.size).to eq 3
		end
	end

	describe '#load_pricing_rule' do
		it 'should create bulk rule' do
			rule = RuleParser.load_pricing_rule('3 apples cost $1.30')
			expect(rule.discount_type).to eq 'bulk'
			expect(rule.price_factor).to eq 1.3
		end

		it 'should create free discount rule' do
			rule = RuleParser.load_pricing_rule('Buy 1 orange get 1 free')
			expect(rule.discount_type).to eq 'percent'
			expect(rule.price_factor).to eq 0
		end

		it 'should create half price discount rule' do
			rule = RuleParser.load_pricing_rule('Buy 1 banana get 1 half off')
			expect(rule.discount_type).to eq 'percent'
			expect(rule.price_factor).to eq 50
		end
	end
end