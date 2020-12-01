# typed: true
# frozen_string_literal: true

class Formula
  undef on_arm

  def on_arm(&block)
    raise "No block content defined for on_arm block" unless block

    yield
  end

  class << self
    undef on_arm

    def on_arm(&block)
      raise "No block content defined for on_arm block" unless block

      yield
    end
  end
end
