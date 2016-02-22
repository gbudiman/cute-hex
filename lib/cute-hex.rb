require "ap"
require "active_support/core_ext/hash/indifferent_access"
require "cute-hex/version"
require "cute-hex/core"

# Monkey-patch AS/HWIA
class HashWithIndifferentAccess
  def method_missing(method, *opts)
    case method
    when /\=$/
      m = method.to_s.gsub(/\=$/, '') # strip assignment operator
      self[m] = opts.first

      return self
    else
      return self[method]
    end
  end
end

module CuteHex
  @@config = HashWithIndifferentAccess.new({
    word_size:       32, # bits
    slicer:          :byte,
    pad_zeros:       true,
    debug_mode:      false,
  })

  def self.method_missing(method, *opts)
    case method
    when :config
      return @@config
    end
  end
end
