# typed: strict
# frozen_string_literal: true

require "requirement"

# A requirement on Xcode.
class XcodeRequirement < Requirement
  fatal true

  sig { returns(T.nilable(String)) }
  attr_reader :version

  satisfy(build_env: false) do
    T.bind(self, XcodeRequirement)
    xcode_installed_version!
  end

  sig { params(tags: T::Array[String]).void }
  def initialize(tags = [])
    version = tags.shift if tags.first.to_s.match?(/(\d\.)+\d/)
    @version = T.let(version, T.nilable(String))
    super
  end

  sig { returns(T::Boolean) }
  def xcode_installed_version!
    return false unless MacOS::Xcode.installed?
    return false unless MacOS::Xcode.macos_sdk_installed?
    return true unless @version

    MacOS::Xcode.version >= @version
  end

  sig { returns(String) }
  def message
    version = " #{@version}" if @version
    message = if MacOS::Xcode.installed? && !MacOS::Xcode.macos_sdk_installed?
      <<~EOS
        A full installation of Xcode.app#{version} with macOS framework support is required to compile
        this software. Xcode is installed but the macOS frameworks are missing.
        Please download and install the macOS framework from the Xcode Components tab in Preferences.
      EOS
    else
      <<~EOS
        A full installation of Xcode.app#{version} is required to compile
        this software. Installing just the Command Line Tools is not sufficient.
      EOS
    end
    if @version && Version.new(MacOS::Xcode.latest_version) < Version.new(@version)
      message + <<~EOS

        Xcode#{version} cannot be installed on macOS #{MacOS.version}.
        You must upgrade your version of macOS.
      EOS
    else
      message + <<~EOS

        Xcode can be installed from the App Store.
      EOS
    end
  end

  sig { returns(String) }
  def inspect
    "#<#{self.class.name}: version>=#{@version.inspect} #{tags.inspect}>"
  end

  sig { returns(String) }
  def display_s
    return "#{name.capitalize} (on macOS)" unless @version

    "#{name.capitalize} >= #{@version} (on macOS)"
  end
end

require "extend/os/requirements/xcode_requirement"
