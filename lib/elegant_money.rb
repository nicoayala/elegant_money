# frozen_string_literal: true
class ElegantMoney
  include Comparable

  attr_reader :amount, :currency

  def self.configure
    yield configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def initialize(amount, currency = default_currency)
    @amount = BigDecimal.new(amount.to_s)
    @currency = currency
  end

  def inspect
    "%.2f %s" % [amount, currency]
  end
  alias :to_s :inspect

  def <=>(other)
    other_amount = amount_with_normalized_currency(other)
    amount.round(2) <=> other_amount.round(2)
  end

  def +(other)
    operate_with_normalized_currency(other) do |other_amount|
      amount + other_amount
    end
  end

  def -(other)
    operate_with_normalized_currency(other) do |other_amount|
      amount - other_amount
    end
  end

  def *(other)
    operate_with_normalized_currency(other) do |other_amount|
      amount * other_amount
    end
  end

  def /(other)
    operate_with_normalized_currency(other) do |other_amount|
      amount / other_amount
    end
  end

  def convert_to(new_currency)
    return build(amount, currency) if currency == new_currency

    conversion = conversion_for(new_currency)
    conversion_amount = amount
    conversion_amount /= conversion_for(currency) unless currency == default_currency

    build(conversion_amount * conversion, new_currency)
  end

  def infinite?
    amount.infinite?
  end

  private

  def operate_with_normalized_currency(other)
    result = yield amount_with_normalized_currency(other)
    build(result, currency)
  end

  def amount_with_normalized_currency(other)
    return other.convert_to(currency).amount if other.is_a?(ElegantMoney)
    return BigDecimal.new(other.to_s) if other.is_a?(Float)
    other
  end

  def build(amount, currency)
    ElegantMoney.new(amount, currency)
  end

  def conversion_for(key)
    return 1 if key == default_currency
    configuration.conversions.fetch(key)
  end

  def default_currency
    configuration.default_currency
  end

  def configuration
    ElegantMoney.configuration
  end
end

require "bigdecimal"
require "elegant_money/configuration"
