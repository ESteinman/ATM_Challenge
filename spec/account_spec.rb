require './lib/account.rb'
require 'date'

describe Account do

    it  'is expected to have a 4 digit pin number on initalize' do
        pin_length = Math.log10(subject.pin_code).to_i + 1
        expect(pin_length).to eq 4
    end

    it 'is expected to have a balance of 0 on initalize' do
        expect(subject.balance).to eq 0
    end

    it 'check length of a number' do
        number = 1234
        number_length = Math.log10(number).to_i + 1
        expect(number_length).to eq 4
    end

    it 'is expected to have an expiry date on initalize' do
        expected_date = Date.today.next_year(5).strftime("%m/%y")
        expect(subject.exp_date).to eq expected_date
    end

    it 'is expected to have :active status on initalize' do
        expect(subject.account_status).to eq :active
    end

    it 'deactivates account using Instance method' do
        subject.deactivate
        expect(subject.account_status).to eq :deactivated
    end
end
