module CuteHex
  def self.hex_print _x, **opts
    slicer = opts[:style] == :data ? (opts[:slicer] || @@config.slicer) : :nibble

    if _x.is_a? Array
      return _x.collect{ |e| stylify(e, slicer, opts) }
    else
      return stylify(_x, slicer, opts)
    end
  end

  singleton_class.send(:alias_method, :x, :hex_print)

private
  def self.stylify _x, _slicer, _opts
    return (_opts[:style] == :data ? '' : '[')   \
         + to_hex_string(_x, _slicer, _opts)     \
         + (_opts[:style] == :data ? '' : ']')
  end

  def self.to_hex_string _x, _slicer, _opts
    word_size = _opts[:word_size] || @@config.word_size
    pad_zeros = _opts[:pad_zeros] == nil ? @@config.pad_zeros : _opts[:pad_zeros]

    format = '%'                                                      \
           + (_opts[:style] == :data ? (pad_zeros ? '0' : '') : '0')  \
           + (word_size / 4).to_s                                     \
           + 'X'

    slice_by = case _slicer
               when :byte then 2
               when :nibble then 4
               when :half_word then word_size / 2 / 4
               else word_size / 4
               end

    s = (_x ? sprintf(format, _x) : '?' * (word_size / 4)).split('')
    output = s.each_slice(slice_by).map{ |x| x.join }.join(' ')

    if @@config.debug_mode
      p "Format: #{format}"
      p "Sliced: #{s} (#{_slicer} | #{slice_by})"
      p "Output: #{output}"
    end

    return output
  end
end
