require './lib/account'
require './lib/atm'

class Person

    attr_accessor :name, :cash, :account

    def initialize(attrs = {})
        @name = set_name(attrs[:name])
        @cash = 0
        @account = nil
    end

    def create_account
        @account = Account.new(owner: self)
    end

    def deposit(amount)
        @account == nil ? missing_account : deposit_funds(amount)
    end

    def withdraw(args = {})
        @account == nil ? missing_account : withdraw_funds(args)
    end
    
    def no_account_is_set
        raise 'No account present'
    end

    private
    
    def deposit_funds(amount)
        @cash -= amount
        @account.balance += amount
    end

    def withdraw_funds(args)
        args[:atm] == nil ? missing_atm : atm = args[:atm]
        account = @account
        amount = args[:amount]
        pin = args[:pin]
        response = atm.withdraw(amount, pin, account, atm)
        response[:status] == true ? increase_cash(response) : response
    end

    def increase_cash(response)
        @cash += response[:amount]
    end

    def set_name(name)
        name == nil ?  no_name_is_set : @name = name
    end

    def no_name_is_set
        raise ArgumentError, "A name is required"
    end

    def missing_account
        raise RuntimeError, 'No account present'
    end

    def missing_atm
        raise RuntimeError, 'An ATM is required'
    end
end