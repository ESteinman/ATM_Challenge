#require './lib/person'
require 'date'

class ATM
    attr_accessor :funds
    
    def initialize
        @funds = 1000
    end

    def withdraw(amount, pin, account, condition) 
        case
        when insufficent_funds_in_account?(amount, account)
            { status: false, message: 'insufficent funds', date: Date.today }
        when insufficent_funds_in_atm?(amount)
            { status: false, message: 'insufficent funds in ATM', date: Date.today}
        when incorrect_pin?(pin, account.pin)
            { status: false, message: 'wrong pin', date: Date.today}
        when card_expired?(account.exp_date)
            { status: false, message: 'card expired', date: Date.today}
        when account_disabled?(account)
            { status: false, message: 'card disabled', date: Date.today }
        else
         perform_transaction(amount, account, condition)
        end 
    end

    private

    def insufficent_funds_in_account?(amount, account)
        amount > account.balance
    end

    def insufficent_funds_in_atm?(amount)
        @funds < amount
    end

    def perform_transaction(amount, account, condition)
        @funds -= amount
        account.balance = account.balance - amount
        { status: true, message: 'success', date: Date.today, amount: amount, bills: add_bills(amount)}
    end

    def add_bills(amount)
        denominations = [20, 10, 5]
        bills = []
        denominations.each do |bill|
            while amount - bill >= 0
                amount -= bill
                bills << bill
            end
        end
        bills
    end


    def incorrect_pin?(pin, actual_pin)
        pin != actual_pin
    end

    def card_expired?(exp_date)
        Date.strptime(exp_date, '%m/%y') < Date.today
    end

    def account_disabled?(account)
        account.condition != :active
    end
end