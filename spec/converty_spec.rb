# frozen_string_literal: true

RSpec.describe Converty do
  it "has a version number" do
    expect(Converty::VERSION).not_to be nil
  end

  describe ".convert" do
    it "supports miles to kilometers" do
      expect(Converty.convert(3.1, from: :mi, to: :km).round(1)).to eql(5.0)
    end

    it "supports kilometers to miles" do
      expect(Converty.convert(5, from: :km, to: :mi).round(1)).to eql(3.1)
    end

    it "throws an error when the units aren't compatible" do
      expect { Converty.convert(5, from: :mi, to: :g) }.to raise_error(Converty::CantConvertError)

      expect { Converty.convert(5, from: :km, to: :g) }.to raise_error(Converty::CantConvertError)
    end
  end
end
