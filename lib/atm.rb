require 'date'

class ATM
    attr_accessor :funds
    
    def initialize
        @funds = 1000
    end

    def withdraw(amount, account)
        case
        when amount > account.balance
            return
        else
        @funds -= amount
        account.balance = account.balance - amount
        { status: true, message: 'success', date: DateTime.now, amount: amount }
        end 
    end
end