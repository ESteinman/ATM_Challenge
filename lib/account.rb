require 'date'
class Account
    STANDARD_VALIDITY_YRS = 5
    attr_reader :exp_date
  
    def initalize
        @account_status = :active
        @exp_date = set_expire_date
    end

    def set_expire_date
        Date.today.next_year(STANDARD_VALIDITY_YRS).strftime('%m/%y')
    end


end