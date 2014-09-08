## Checkout System

### This programning problem:

- Is written in Ruby
- Has a console interface to add products to a shopping cart and get an itemized printed receipt, along with the total
- Has tests written in rspec
- Reads human-readable pricing rules from a file 
- Reads the prices of products from a YAML file

### How to set up the app:
> bundle install

### How to run the app:
```bash
> ruby console_app.rb
Add one item at a time to the cart. Type 'quit' to complete
> apple
> apple
> orange
> mango
We don't have this item. Try again.
> quit
2 apples: $1.00
1 orange: $0.75
Total: $1.75
```bash

All products must be in lower case and are assumed to be added to the shopping cart one at a time. For example, 'apples' is not a valid product whereas 'apple' is acceptable. If a product that does not exist in the pricing file, then it is not considered valid. Type 'quit' to run the itemized receipt. 

### How to run tests:
```bash
rspec
```bash

### Gems used to help build this app
- Readline (For reading products entered via the console)
- Rspec (For good ol' tests)
- Pry (For debugging)
- Require all (For loading all the files, that the console app depends on, once)

### Assumptions made:
- Items are scanned one at a time but they are priced at the very end of the checkout process (unlike traditional systems that calculate price and running total as items are being scanned)
- The app is not smart enough to handle contradictory pricing schemes. For example, "Buy 3 apples for $1.30" may contradict "Buy 1 apple, get 1 free" for a cart filled with 3 apples. In this case, whichever rule is entered in the pricing rules file first is the one that is used first.

### If I had more time:
- Would've listed out the discounts applied on the receipt instead of just the itemized prices
- Would've refactored the 'rules_parser.rb' to use the strategy pattern so that all the translation of the rules do not happen in a single file, which may expand as more rule types are added
- Would've embraced Parkinson's law: "work expands so as to fill the time available for its completion" :)

### Disclaimer: 
No animals were harmed in the making of this app.

