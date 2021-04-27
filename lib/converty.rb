# frozen_string_literal: true

require_relative "converty/version"

# Easily convert amounts between different units
module Converty
  class Error < StandardError; end

  # Error thrown when trying to convert between two different types of units,
  # e.g. distance to weight.
  class CantConvertError < Error
    def initialize(from, to)
      from_unit = UNITS.fetch(from)
      to_unit = UNITS.fetch(to)
      message = "can't convert #{from_unit.fetch(:type)} (#{from}) to #{to_unit.fetch(:type)} (#{to})"
      super(message)
    end
  end

  # Thrown when a non-existant unit type is passed into the +from+ and/or +to+
  # param when converting.
  class UnitError < Error
    def initialize(units)
      message = units.map { |u| "#{u} is an invalid unit" }.join(", ")
      super(message)
    end
  end

  DISTANCE_TYPE = :distance
  WEIGHT_TYPE = :weight

  UNITS = {
    ft: {
      base_per: 1.0,
      type: DISTANCE_TYPE
    },
    in: {
      base_per: 1 / 12.0,
      type: DISTANCE_TYPE
    },
    mi: {
      base_per: 5280.0,
      type: DISTANCE_TYPE
    },
    km: {
      base_per: 3280.84,
      type: DISTANCE_TYPE
    },
    oz: {
      base_per: 1.0,
      type: WEIGHT_TYPE
    },
    lb: {
      base_per: 16.0,
      type: WEIGHT_TYPE
    }
  }.freeze

  # Convert the specified amount in the +from+ unit to the to the +to+ unit
  #
  # It does not handle rounding the returned conversion.
  #
  # Currently supports some distance and weight unit types.
  #
  # Examples:
  #
  #  Converty.convert(5, from: :km, to: :mi).round(1) => 3.1
  #  Converty.convert(16, from: :oz, to: :lb) => 1.0
  def self.convert(amount, from:, to:)
    to_unit = UNITS[to]
    from_unit = UNITS[from]

    if to_unit.nil? || from_unit.nil?
      invalid_units = []
      invalid_units.push(from) if from_unit.nil?
      invalid_units.push(to) if to_unit.nil?
      raise UnitError.new(invalid_units)
    end

    if to_unit.fetch(:type) != from_unit.fetch(:type)
      raise CantConvertError.new(from, to)
    end

    in_base = from_unit[:base_per] * amount
    in_base / to_unit[:base_per]
  end
end
