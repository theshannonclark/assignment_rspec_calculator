require 'calculator'
require_relative 'support/calculator_shared_examples'

describe Calculator do

  let(:calc){Calculator.new}
  let(:stringify_calc){Calculator.new(true)}

  describe '#add' do
    context 'given two integers' do
      it 'adds two positive integers' do
        expect(calc.add(1, 2)).to eq(3)
      end

      it 'adds one negative integer to one positive integer' do
        expect(calc.add(-1, 2)).to eq(1)
      end

      it 'adds one positive integer to one negative integer' do
        expect(calc.add(1, -2)).to eq(-1)
      end

      it 'adds two negative integers' do
        expect(calc.add(-1, -2)).to eq(-3)
      end
    end

    context 'given two floats' do
      it 'adds two positive floats' do
        expect(calc.add(1.2, 2.3)).to be_within(0.01).of(3.5)
      end

      it 'adds one negative float to one positive float' do
        expect(calc.add(-1.2, 2.3)).to be_within(0.01).of(1.1)
      end

      it 'adds one positive float to one negative float' do
        expect(calc.add(1.2, -2.3)).to be_within(0.01).of(-1.1)
      end

      it 'adds two negative floats' do
        expect(calc.add(-1.2, -2.3)).to be_within(0.01).of(-3.5)
      end
    end

    context 'given @stringify is true' do
      it 'returns a string' do
        expect(stringify_calc.add(1, 2)).to eq("3")
      end
    end
  end

  describe '#subtract' do

  end

  describe '#multiply' do
    
  end

  describe '#divide' do
    
  end

  describe '#pow' do
    
  end

  describe '#sqrt' do
    
  end

  describe '#memory=' do
    
  end

  describe '#memory' do
    
  end
end