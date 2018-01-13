ElegantMoney.configure do |config|
  config.default_currency = "EUR"
  config.conversions = {
    "USD" => 1.11,
    "BTC" => 0.0047
  }
end

RSpec.describe ElegantMoney do
  describe "#inspect" do
    it "returns a string representation" do
      expect(eur(9.98).inspect).to eql("9.98 EUR")
    end

    it "returns a string representation when amount is not a number" do
      expect(eur("asd").inspect).to eql("0.00 EUR")
    end
  end

  describe "#+" do
    it "returns the sum of two amounts" do
      ten = eur(10)
      expect(ten + ten).to eq eur(20)
    end

    it "returns the sum of two amounts when they have different currencies" do
      expect(eur(50) + usd(20)).to eq eur(68.02)
    end
  end

  describe "#-" do
    it "returns the difference between two amounts" do
      ten = eur(10)
      expect(ten - ten).to eq eur(0)
    end

    it "returns the sum of two amounts when they have different currencies" do
      expect(eur(50) - usd(20)).to eq eur(31.98)
    end
  end

  describe "#*" do
    it "returns the result of multiplying of two amounts" do
      ten = eur(10)
      expect(ten * ten).to eq eur(100)
    end

    it "returns the result of multiplying an amount and a primitive value" do
      expect(eur(10) * 2).to eq eur(20)
      expect(eur(10) * 2.0).to eq eur(20)
    end
  end

  describe "#/" do
    it "returns the result of the division of two amounts" do
      expect(eur(10) / eur(2)).to eq eur(5)
    end

    it "returns infinity when the divider is zero" do
      expect(eur(10) / eur(0)).to be_infinite
      expect(eur(10) / 0).to be_infinite
    end

    it "returns the result of the division between an amount and a primitive value" do
      expect(eur(10) / 2).to eq eur(5)
      expect(eur(10) / 2.0).to eq eur(5)
    end
  end

  describe "#convert_to" do
    it "returns the amount in the new currency" do
      expect(eur(10).convert_to("USD")).to eq usd(11.10)
    end

    it "returns the amount of the new currency when it is different than the default one" do
      money = usd(10).convert_to("BTC")
      expect(money).to eq btc(0.04)
      expect(money.convert_to("USD")).to eq usd(10)
    end

    it "returns the same amount when converting to the same currency" do
      expect(eur(10).convert_to("EUR")).to eq eur(10)
    end
  end

  describe "comparision" do
    it "returns true when amounts are equal" do
      expect(eur(10) == eur(10)).to eq true
    end

    it "returns true when amounts are equal and currencies are different" do
      expect(eur(10) == usd(11.10)).to eq true
    end

    it "returns true when amount is greater than the second one" do
      expect(eur(10) > usd(10)).to eq true
      expect(usd(10) < eur(10)).to eq true
    end
  end

  def eur(amount)
    described_class.new(amount, "EUR")
  end

  def usd(amount)
    described_class.new(amount, "USD")
  end

  def btc(amount)
    described_class.new(amount, "BTC")
  end
end
