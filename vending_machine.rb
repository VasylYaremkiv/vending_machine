# frozen_string_literal: true

class VendingMachine
  attr_reader :coins, :products, :inserted_coins_amount, :last_inserted_coins_amount, :selected_product

  def initialize(coins, products)
    @coins = coins.sort
    @products = products
    @inserted_coins_amount = 0
    @last_inserted_coins_amount = 0
  end

  def insert_coins(amount)
    @last_inserted_coins_amount += amount
    @inserted_coins_amount += amount
  end

  def select_product(name)
    @selected_product = products.find { |p| p.name == name }

    raise 'Product is not available' unless selected_product
    raise 'Product price is more than you inserted' if selected_product.price > last_inserted_coins_amount

    selected_product.quantity -= 1
    @products -= [selected_product] if selected_product.quantity.zero?

    true
  end

  def change
    change_amount = last_inserted_coins_amount - selected_product.price
    result = find_max_sum_of_coins(coins, change_amount)
    @coins = array_difference_with_duplicates(coins, result)
    result.reverse
  end

  private

  def find_max_sum_of_coins(available_coins, sum)
    return [] if available_coins.empty?
    return available_coins if available_coins.sum <= sum

    uniq_coins = available_coins.uniq

    results = uniq_coins.map do |coin|
      next if coin > sum

      available_coins_for_next_chunk = remove_item_from_array(available_coins, coin)
      [coin] + find_max_sum_of_coins(available_coins_for_next_chunk, sum - coin)
    end.compact

    return [] if results.empty?

    results.max_by { |result| [result.sum, -result.length] }
  end

  def remove_item_from_array(items, item)
    item_index = items.index(item)
    items.select.with_index { |_, i| item_index != i }
  end

  def array_difference_with_duplicates(array1, array2)
    counts = array2.tally

    array1.reject do |element|
      if counts[element].to_i > 0
        counts[element] -= 1
        true
      else
        false
      end
    end
  end
end
