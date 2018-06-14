require './lib/person'
require './lib/atm'
require 'date'

describe Person do
let(:account) { instance_double('Account', pin_code: '1234', exp_date: '07/18', account_status: :active)}

    subject { described_class.new(name: 'Thomas') }

    it 'is expected to have a :name on initialize' do
        expect(subject.name).not_to be nil
    end

    it 'is expected to raise error if no name is set' do
        expect { described_class.new }.to raise_error 'A name is required'
    end

    it 'is expected to have a :cash attribute with value of 0 on initialize' do
        expect(subject.cash).to eq 0
    end

    it 'is expected to have a :account attribute' do
        expect(subject.account).to be nil
    end

    describe 'can create an Account' do
        before { subject.create_account }
        
        it 'of Account class' do
            expect(subject.account).to be_an_instance_of Account
        end
        
        it 'with himself as an owner' do
            expect(subject.account.owner).to be subject
        end
    end

    describe 'can manage funds if an account been created' do
        let(:atm) { ATM.new }
        before { subject.create_account }
        
        it 'can deposit funds' do
            expect(subject.deposit(100)).to be_truthy
        end
        
        it 'funds are added to the account balance - deducted from cash' do
            subject.cash =  100
            subject.deposit(100)
            expect(subject.account.balance).to eq 100
            expect(subject.cash).to eq 0
        end

        it 'can withdraw funds' do
            command = lambda { subject.withdraw(amount: 100, pin: subject.account.pin, account: subject.account, atm: atm)}
            expect(command.call).to be_truthy
        end

        it 'withdraw is expected to raise error if no ATM is passed in' do
            command = lambda { subject.withdraw(amount: 100, pin: subject.account.pin, account: subject.account) }
            expect { command.call }.to raise_error 'An ATM is required'
        end

        it 'funds are added to cash - deducted from account balance' do
            subject.cash = 100
            subject.deposit(100)
            subject.withdraw(amount: 100, pin: subject.account.pin, account: subject.account, atm: atm)
            expect(subject.account.balance).to eq 0
            expect(subject.cash).to eq 100
        end

        it 'funds are insufficent on account' do
            subject.account.balance = 0
            expected_output = { status: false, message: 'insufficent funds', date: Date.today }
            expect(subject.withdraw(amount: 100, pin: subject.account.pin, account: subject.account, atm: atm)).to eq expected_output
        end
    end
    
    describe 'can not manage funds if no account been created' do
        it 'can\'t deposit funds' do
        expect { subject.deposit(100) }.to raise_error(RuntimeError, 'No account present')
        end
    end
end

