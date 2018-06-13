require './lib/account'
require './lib/atm'

    class Person

        attr_accessor :name, :cash, :account

        def initialize(attrs = {})
            set_name(attrs[:name])
            @cash = 0
            @account = nil
        end

        def create_account
            @account = Account.new(owner: self)
        end

        def deposit (amount)
            @account == nil ?  deposit_declined : @account = amount
        end

        def no_account_is_set
            raise 'No account present'
        end

        private
        def set_name(name)
            name == nil ?  no_name_is_set : @name = name
        end

        def no_name_is_set
            raise "A name is required"
        end

        def deposit_declined
            raise RuntimeError, 'No account present'
        end


    end