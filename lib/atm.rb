require 'date'

class ATM
    attr_accessor :funds
    
    def initialize
        @funds = 1000
    end

    def withdraw(amount, account)
        case
        when insufficent_funds_in_account?(amount, account)
            { status: false, message: 'insufficent funds', date: Date.today}
        when insufficent_funds_in_atm?(amount)
    { status: false, message: 'insufficent funds in ATM', date: Date.today}
        else
         perform_transaction(amount, account)
        end 
    end

    private

    def insufficent_funds_in_account?(amount, account)
        amount > account.balance
    end

    def insufficent_funds_in_atm?(amount)
        @funds < amount
    end

    def perform_transaction(amount, account)
        @funds -= amount
        account.balance = account.balance - amount
        { status: true, message: 'success', date: Date.today, amount: amount }
    end
end