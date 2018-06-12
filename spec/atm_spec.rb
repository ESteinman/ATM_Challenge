require './lib/atm.rb'
require 'date'

 describe ATM do
 let(:account) { instance_double('Account', pin_code: '1234') }

before do
    allow(account).to receive(:balance).and_return(100)
    allow(account).to receive(:balance=)
end
    
    it 'has $1000 on initalize' do
        expect(subject.funds).to eq 1000
    end

    it 'funds are reduced at withdraw' do
        subject.withdraw(50, '1234', account) 
        expect(subject.funds).to eq 950
    end

    it 'allow withdraw if account has enough balance.' do
        expected_output = { status: true, message: 'success', date: Date.today, amount: 45 }
        expect(subject.withdraw(45, '1234', account)).to eq expected_output
    end

    it 'rejects withdraw if account has insufficent funds' do
        expected_output = { status: false, message: 'insufficent funds', date: Date.today }
        expect(subject.withdraw(105, '1234', account)).to eq expected_output
    end

    it 'reject withdraw if ATM has insufficent funds' do
        subject.funds = 50
        expected_output = { status: false, message: 'insufficent funds in ATM', date: Date.today }
        expect(subject.withdraw(100, '1234', account)).to eq expected_output    
    end

    it 'reject withdraw if pin is wrong' do
        expected_output = { status: false, message: 'wrong pin', date: Date.today}
        expect(subject.withdraw(50, 9999, account)).to eq expected_output
    end
end
