require './lib/account.rb'
require 'date'

describe Account do

    xit 'check length of a number' do
        number = 1234
        number_length = Math.log10(number).to_i + 1
        expect(number_length).to eq 4
    end

    it 'is expected to have an expiry date on initalize' do
        expected_date = Date.today.next_year(5).strftime("%m/%y")
        expect(subject.exp_date).to eq expected_date
    end

    xit 'is expected to have :active status on initalize' do
        expect(subject.account_status).to eq :active
    end
end






