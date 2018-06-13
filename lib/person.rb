require './lib/account'

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

        private
        def set_name(name)
            name == nil ?  no_name_is_set : @name = name
        end

        def no_name_is_set
            raise "A name is required"
        end


    end