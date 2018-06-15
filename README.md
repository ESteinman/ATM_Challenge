# ATM_Challenge

### *How to use the ATM*

**Go to terminal:**

```terminal
irb
:001 > load './lib/atm.rb'
:002 > load './lib/person.rb'
:003 > erik = Person.new(name: 'Erik')
```
```ruby
# A Person is being setup
```
```terminal
:004 > bankomat = ATM.new
```
```ruby
# The ATM is being setup
```
```terminal
:005 > erik.create_account
```
```ruby
# An account is being created with expiration date, pin and balance
```
```terminal
:006 > erik.deposit(100)
:007 > bankomat.withdraw(sum, pin, konto)
:008 > konto
```