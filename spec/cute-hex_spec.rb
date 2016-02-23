require 'spec_helper'

describe CuteHex do
  it 'has a version number' do
    expect(CuteHex::VERSION).not_to be nil
  end

  context 'class configuration' do
    it 'should have default of 32-bits word size' do
      expect(CuteHex.config.word_size).to eq(32)
    end

    it 'should be writeable' do
      CuteHex.config.word_size = 64
      expect(CuteHex.config.word_size).to eq(64)
    end
  end

  context 'basic printing' do
    before :each do
      CuteHex.config.word_size = 32
      CuteHex.config.pad_zeros = true
      CuteHex.config.debug_mode = true
      @a = 53
    end

    it 'should print correctly in address mode' do
      CuteHex.config.pad_zeros = false
      expect(CuteHex.x @a).to eq('[0000 0035]')
    end

    it 'should print correctly in data mode' do
      { byte: '00 00 00 35',
        nibble: '0000 0035',
        half_word: '0000 0035',
        word: '00000035' }.each do |k, v|
        CuteHex.config.slicer = k
        expect(CuteHex.x @a, style: :data, slice: k).to eq(v)
      end
    end

    context 'with array input' do
      it 'should list hex output correctly' do
        input = [9,10,11,12,13,14,15,16]
        expectation = ['[0000 0009]',
                       '[0000 000A]',
                       '[0000 000B]',
                       '[0000 000C]',
                       '[0000 000D]',
                       '[0000 000E]',
                       '[0000 000F]',
                       '[0000 0010]']

        expect(CuteHex.x input).to eq(expectation)
      end
    end

    context 'config override' do
      it ':word_size should be able to be overridden temporarily' do
        expect(CuteHex.x 0x80, word_size: 16).to eq('[0080]')
        expect(CuteHex.x 0x80).to eq('[0000 0080]')
      end

      it ':pad_zero should be able to be overridden temporarily' do
        CuteHex.config.slicer = :byte
        expect(CuteHex.x 0x80, word_size: 16, pad_zeros: false, style: :data, slicer: :byte).to eq('   80')
        expect(CuteHex.x 0x80, style: :data).to eq('00 00 00 80')
      end
    end
  end
end
