# typed: strict
# frozen_string_literal: true

if Hardware::CPU.arm?
  require "extend/arch/arm/formula"
elsif Hardware::CPU.intel?
  require "extend/arch/intel/formula"
elsif Hardware::CPU.ppc?
  require "extend/arch/ppc/formula"
end
