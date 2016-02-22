module CuteHex
  def self.hex_print _x, **opts
    slicer = opts[:style] == :data ? @@config.slicer : :nibble

    if _x.is_a? Array
      return _x.collect{ |e| stylify(e, slicer, opts[:style]) }
    else
      return stylify(_x, slicer, opts[:style])
    end
  end

  singleton_class.send(:alias_method, :x, :hex_print)

private
  def self.stylify _x, _slicer, _style
    return (_style == :data ? '' : '[')   \
         + to_hex_string(_x, _slicer)            \
         + (_style == :data ? '' : ']')
  end

  def self.to_hex_string _x, _slicer
    format = '%'                                                               \
           + (_slicer == :data ? (@@config.pad_zeros ? '0' : '') : '0')        \
           + (@@config.word_size / 4).to_s                                     \
           + 'X'

    slice_by = case _slicer
               when :byte then 2
               when :nibble then 4
               when :half_word then @@config.word_size / 2 / 4
               else @@config.word_size / 4
               end

    s = sprintf(format, _x).split('')
    output = s.each_slice(slice_by).map{ |x| x.join }.join(' ')

    if @@config.debug_mode
      p "Format: #{format}"
      p "Sliced: #{s}"
      p "Output: #{output}"
    end

    return output
  end
end
