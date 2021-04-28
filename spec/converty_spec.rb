# frozen_string_literal: true

RSpec.describe Converty do
  it "has a version number" do
    expect(Converty::VERSION).not_to be nil
  end

  describe ".convert" do
    it "supports coercing from and to params to symbols" do
      expect(Converty.convert(3.1, from: "mi", to: "km").round(1)).to eql(5.0)
    end

    it "supports coercing amount from a string" do
      expect(Converty.convert("3.1", from: "mi", to: "km").round(1)).to eql(5.0)
    end

    context "when converting distance" do
      it "supports miles to kilometers" do
        expect(Converty.convert(3.1, from: :mi, to: :km).round(1)).to eql(5.0)
      end

      it "supports kilometers to miles" do
        expect(Converty.convert(5, from: :km, to: :mi).round(1)).to eql(3.1)
      end

      it "supports feet to inches" do
        expect(Converty.convert(2, from: :ft, to: :in).round(1)).to eql(24.0)
      end

      it "supports miles to feet" do
        expect(Converty.convert(1, from: :mi, to: :ft).round(1)).to eql(5280.0)
        expect(Converty.convert(5, from: :mi, to: :ft).round(1)).to eql(26400.0)
      end

      it "supports feet to miles" do
        expect(Converty.convert(6000, from: :ft, to: :mi).round(3)).to eql(1.136)
      end
    end

    context "when converting weight" do
      it "supports ounces to pounds" do
        expect(Converty.convert(16, from: :oz, to: :lb).round(1)).to eql(1.0)

        expect(Converty.convert(42, from: :oz, to: :lb)).to eql(2.625)
      end

      it "supports pounds to ounces" do
        expect(Converty.convert(1, from: :lb, to: :oz)).to eql(16.0)

        expect(Converty.convert(4.2, from: :lb, to: :oz)).to eql(67.2)
      end
    end

    context "when there are errors" do
      it "throws an error when a unit doesn't exist" do
        expect do
          Converty.convert(5, from: :not_real, to: :km)
        end.to raise_error(Converty::UnitError, "not_real is an invalid unit")
      end

      it "throws an error when both units don't exist" do
        expect do
          Converty.convert(5, from: :not_real, to: :something_else)
        end.to raise_error(Converty::UnitError, "not_real is an invalid unit, something_else is an invalid unit")
      end

      it "throws an error when the units aren't compatible" do
        expect do
          Converty.convert(5, from: :mi, to: :oz)
        end.to raise_error(Converty::CantConvertError, "can't convert distance (mi) to weight (oz)")

        expect do
          Converty.convert(5, from: :lb, to: :km)
        end.to raise_error(Converty::CantConvertError, "can't convert weight (lb) to distance (km)")
      end
    end
  end
end
