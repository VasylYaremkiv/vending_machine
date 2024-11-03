require 'spec_helper'

RSpec.describe VendingMachine do
  describe '.change' do
    subject { described_class.new(coins, products) }

    let(:products) do
      [
        Product.new('Coca Cola', 2, 2),
        Product.new('Sprite', 2.5, 2),
        Product.new('Fanta', 2.7, 3),
        Product.new('Orange Juice', 3, 1),
        Product.new('Water', 3.25, 0)
      ]
    end
    let(:coins) do
      [
        [5] * 1,
        [3] * 1,
        [2] * 5,
        [1] * 0,
        [0.5] * 5,
        [0.25] * 5,
      ].flatten
    end

    it 'retruns minumum coins' do
      subject.insert_coins(11)
      subject.select_product('Coca Cola')
      expect(subject.change).to eq([5, 2, 2])
    end
  end
end
