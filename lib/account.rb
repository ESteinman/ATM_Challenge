require 'date'
class Account
    STANDARD_VALIDITY_YRS = 5
    attr_accessor :pin_code, :balance, :exp_date, :account_status
  
    def initialize(attr = {})
     @account_status = :active
     @exp_date = set_expire_date
     @pin_code = generate_pin
     @balance = 0
    end

    def set_expire_date
       Date.today.next_year(STANDARD_VALIDITY_YRS).strftime('%m/%y')
    end

    def generate_pin
        rand(1000..9999)
    end

    def deactivate
        @account_status = :deactivated
    end
end