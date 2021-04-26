# frozen_string_literal: true

require_relative "converty/version"

# Easily convert amounts between different units
module Converty
  class Error < StandardError; end

  class CantConvertError < Error; end

  KILOMETERS_PER_MILE = 1.609344

  # Convert the specified amount in the +from+ unit to the to the +to+ unit
  #
  # It does not handle rounding the returned conversion.
  #
  # Examples:
  #
  #  Converty.convert(5, from: :km, to: :mi).round(1) => 3.1
  def self.convert(amount, from:, to:)
    case from
    when :mi
      case to
      when :km
        amount * KILOMETERS_PER_MILE
      else
        raise CantConvertError
      end
    when :km
      case to
      when :mi
        amount / KILOMETERS_PER_MILE
      else
        raise CantConvertError
      end
    end
  end
end
