class ElegantMoney
  include Comparable

  attr_reader :amount, :currency

  def self.configure
    yield configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def initialize(amount, currency = 'EUR')
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
    other_amount = amount_with_normalized_currency(other)
    build(amount + other_amount, currency)
  end

  def -(other)
    other_amount = amount_with_normalized_currency(other)
    build(amount - other_amount, currency)
  end

  def *(other)
    other_amount = amount_with_normalized_currency(other)
    build(amount * other_amount, currency)
  end

  def /(other)
    other_amount = amount_with_normalized_currency(other)
    build(amount / other_amount, currency)
  end

  def convert_to(new_currency)
    return build(amount, currency) if currency == new_currency

    conversion = conversion_for(new_currency)
    new_amount = if currency == default_currency
      amount * conversion
    else
      default_amount = amount / conversion_for(currency)
      default_amount * conversion
    end

    build(new_amount, new_currency)
  end

  def infinite?
    amount.infinite?
  end

  private

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
    ElegantMoney.configuration.conversions.fetch(key)
  end

  def default_currency
    ElegantMoney.configuration.default_currency
  end
end

require "bigdecimal"
require "elegant_money/configuration"
