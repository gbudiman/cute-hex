# cute-hex
Cute Hex

Prettify your hex dump

```
require 'cute-hex'

a = 0xbeef

# Basic usage
CuteHex.x a                                                  # [0000 BEEF]
CuteHex.x a, style: :data                                    # 00 00 BE EF

# Adjust word size
CuteHex.x a, word_size: 64                                   # [0000 0000 0000 BEEF]
CuteHex.x a, style: :data, word_size: 16                     # BE EF

# Adjust slicer, only work with :data style
CuteHex.x a, word_size: 64, slicer: :nibble, style: :data    # 0000 0000 0000 BEEF
CuteHex.x a, word_size: 64, slicer: :half_word, style: :data # 00000000 0000BEEF
CuteHex.x a, word_size: 64, slicer: :word, style: :data      # 000000000000BEEF

# Remove trailing zeros, only work with :data style
CuteHex.x a, style: :data, pad_zeros: false                  #       BE EF
```

Overriding default configuration
```
CuteHex.config.word_size=     # in bits, default is 32
CuteHex.config.pad_zeros=     # default is true
CuteHex.config.slicer=        # :byte (default), :nibble, :half_word, :word
```
