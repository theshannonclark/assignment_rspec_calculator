require 'calculator'

describe Calculator do

  let(:calc){Calculator.new}
  let(:stringify_calc){Calculator.new(true)}

  shared_examples 'it works with integers and floats' do |method_name, description, get_result|
    context 'given two integers' do
      it "#{description} two positive integers" do
        expect(calc.send(method_name,a=1,b=2)).to eq(get_result.call(a, b))
      end

      it "#{description} one negative integer and one positive integer" do
        expect(calc.send(method_name,a=-1,b=2)).to eq(get_result.call(a, b))
      end

      it "#{description} one positive integer and one negative integer" do
        expect(calc.send(method_name,a=1,b=-2)).to eq(get_result.call(a, b))
      end

      it "#{description} two negative integers" do
        expect(calc.send(method_name,a=-1,b=-2)).to eq(get_result.call(a, b))
      end
    end

    context 'given two floats' do 
      it "#{description} two positive floats" do
        expect(calc.send(method_name,a=1.2,b=2.3)).to be_within(0.01).of(get_result.call(a, b))
      end

      it "#{description} one negative float and one positive float" do
        expect(calc.send(method_name,a=-1.2,b=2.3)).to be_within(0.01).of(get_result.call(a, b))
      end

      it "#{description} one positive float and one negative float" do
        expect(calc.send(method_name,a=1.2,b=-2.3)).to be_within(0.01).of(get_result.call(a, b))
      end

      it "#{description} two negative floats" do
        expect(calc.send(method_name,a=-1.2,b=-2.3)).to be_within(0.01).of(get_result.call(a, b))
      end
    end

    context 'given @stringify is true' do
      it "returns a string" do
        expect(stringify_calc.send(method_name,a=1,b=2)).to eq(get_result.call(a, b).to_s)
      end
    end
  end

  describe '#add' do
    get_sum = Proc.new {|a, b| a + b}
    it_behaves_like 'it works with integers and floats', :add, "adds", get_sum
  end

  describe '#subtract' do
    get_difference = Proc.new {|a, b| a - b}
    it_behaves_like 'it works with integers and floats', :subtract, "subtracts", get_difference
  end

  describe '#multiply' do
    get_product = Proc.new {|a, b| a * b}
    it_behaves_like 'it works with integers and floats', :multiply, "multiplies", get_product
  end

  describe '#divide' do
    it 'raises an ArgumentError if the divisor is zero' do
      expect { calc.divide(1, 0) }.to raise_error(ArgumentError)
    end

    it 'works if if the dividend is zero instead of the divisor' do
      expect { calc.divide(0, 1) }.not_to raise_error
    end

    it 'returns an integer if there is no remainder' do
      expect(calc.divide(10, 2)).to be_an(Integer)
    end

    it 'returns a float if there is a remainder' do
      expect(calc.divide(5, 2)).to be_a(Float)
    end

    get_quotient = Proc.new do |a, b|
      result = a.to_f / b.to_f
      result.to_i == result ? result.to_i : result
    end
    it_behaves_like 'it works with integers and floats', :divide, "divides", get_quotient
  end

  describe '#pow' do
    it 'works with a positive exponent' do
      expect(calc.pow(2, 5)).to eq(32.0)
    end

    it 'works with a negative exponent' do
      expect(calc.pow(2, -5)).to be_within(0.00001).of(0.03125)
    end

    it 'works with a decimal exponent' do
      expect(calc.pow(2, 3.23)).to be_within(0.00000001).of(9.38267959)
    end

    it 'works with a negative base' do
      expect(calc.pow(-2, 5)).to eq(-32.0)
    end

    it "returns a string if @stringify is true" do
      expect(stringify_calc.pow(2, 5)).to eq("32.0")
    end
  end

  describe '#sqrt' do
    it 'works for positive integers' do
      expect(calc.sqrt(4)).to eq (2)
    end

    it 'returns integers for round roots' do
      expect(calc.sqrt(9)).to be_an(Integer)
    end

    it 'returns 2-digit floats for non-round roots' do
      expect(calc.sqrt(10)).to eq(3.16)
    end

    it 'raises an error if the argument is negative' do
      expect { calc.sqrt(-1) }.to raise_error(ArgumentError)
    end

    it "returns a string if @stringify is true" do
      expect(stringify_calc.sqrt(4)).to eq ("2")
    end
  end

  describe '#memory=' do
    it 'stores an object in memory' do
      calc.memory = 5
      expect(calc.memory).to eq(5)
    end

    it 'overwrites the previous object in memory' do
      calc.memory = 5
      calc.memory = 10
      expect(calc.memory).to eq(10)
    end
  end

  describe '#memory' do
    it 'starts as nil' do
      expect(calc.memory).to be_nil
    end

    it 'returns the object in memory' do
      calc.memory = 10
      expect(calc.memory).to eq(10)
    end

    it 'clears memory when returned' do
      calc.memory = 10
      calc.memory
      expect(calc.memory).to be_nil
    end

    it "returns a string if @stringify is true" do
      stringify_calc.memory = 5
      expect(stringify_calc.memory).to eq("5")
    end
  end
end
