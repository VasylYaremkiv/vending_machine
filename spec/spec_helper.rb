# frozen_string_literal: true

require "rspec"
require_relative "../vending_machine"
require_relative "../product"

RSpec.configure do |config|
  config.expect_with(:rspec) do |c|
    c.syntax = :expect
  end

  config.disable_monkey_patching!
end
