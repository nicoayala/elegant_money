RSpec.describe ElegantMoney do
  describe "#inspect" do
    it "returns a string representation" do
      money = eur(9.98)
      expect(money.inspect).to eql("9.98 EUR")
    end

    it "returns a string representation when amount is not a number" do
      money = eur("asd")
      expect(money.inspect).to eql("0.00 EUR")

      money = eur(nil)
      expect(money.inspect).to eql("0.00 EUR")
    end
  end

  describe "#+" do
    it "returns the sum of two amounts" do
      ten = eur(10)
      expect(ten + ten).to eq eur(20)
    end
  end

  describe "#-" do
    it "returns the difference between two amounts" do
      ten = eur(10)
      expect(ten - ten).to eq eur(0)
    end
  end

  describe "#*" do
    it "returns the multiplication of two amounts" do
      ten = eur(10)
      expect(ten * ten).to eq eur(100)
    end
  end

  describe "#/" do
    it "returns the division of two amounts" do
      expect(eur(10) / eur(2)).to eq eur(5)
    end

    it "returns infinity when the divider is zero" do
      expect(eur(10) / eur(0)).to be_infinite
    end
  end

  describe "#convert_to" do
    it "returns the amount in the new currency" do
      expect(eur(10).convert_to("USD")).to eq usd(12.20)
    end

    it "returns the amount in the new currency when the currency is not the default one" do
      expect(usd(10).convert_to("ARS")).to eq ars(186.64)
    end

    it "returns the same amount when converting to the same currency" do
      expect(eur(10).convert_to("EUR")).to eq eur(10)
    end
  end

  def eur(amount)
    described_class.new(amount, "EUR")
  end

  def usd(amount)
    described_class.new(amount, "USD")
  end

  def ars(amount)
    described_class.new(amount, "ARS")
  end
end
