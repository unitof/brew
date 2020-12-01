# typed: true
# frozen_string_literal: true

class Formula
  undef on_ppc

  def on_ppc(&block)
    raise "No block content defined for on_ppc block" unless block

    yield
  end

  class << self
    undef on_ppc

    def on_ppc(&block)
      raise "No block content defined for on_ppc block" unless block

      yield
    end
  end
end
