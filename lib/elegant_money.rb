class ElegantMoney
  include Comparable

  attr_reader :amount, :currency

  def initialize(amount, currency = 'EUR')
    @amount = BigDecimal.new(amount.to_s)
    @currency = currency
  end

  def inspect
    "%.2f %s" % [amount, currency]
  end
  alias :to_s :inspect

  def <=>(other)
    amount <=> build(other, currency).amount
  end

  def +(other)
    # TODO: check currency!
    # using_currency(other) do |money|
    #   amount + money.amount
    # end
    build(amount + build(other, currency).amount, currency)
  end

  def -(other)
    # TODO: check currency!
    build(amount - build(other, currency).amount, currency)
  end

  def *(other)
    # TODO: check currency!
    build(amount * build(other, currency).amount, currency)
  end

  def /(other)
    # TODO: check currency!
    build(amount / build(other, currency).amount, currency)
  end

  def convert_to(new_currency)
    return build(amount, currency) if currency == new_currency

    conversion = conversion_for(new_currency)
    new_amount = if currency == default_currency
      amount * conversion
    else
      default_amount = amount / conversion_for(currency)
      (default_amount * conversion).round(2)
    end

    build(new_amount, new_currency)
  end

  def infinite?
    amount.infinite?
  end

  private

  def build(amount, currency)
    ElegantMoney.new(amount, currency)
  end

  def using_currency(value)
    yield build(value, currency)
  end

  def conversion_for(key)
    return 1 if key == default_currency

    @conversions ||= {
      "USD" => BigDecimal("1.22"),
      "ARS" => BigDecimal("22.77")
    }
    @conversions.fetch(key)
  end

  def default_currency
    "EUR"
  end
end

require "bigdecimal"
