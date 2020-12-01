# typed: true
# frozen_string_literal: true

class Formula
  undef on_intel

  def on_intel(&block)
    raise "No block content defined for on_intel block" unless block

    yield
  end

  class << self
    undef on_intel

    def on_intel(&block)
      raise "No block content defined for on_intel block" unless block

      yield
    end
  end
end
