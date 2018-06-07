require 'chroma'

module NanoleafRuby
  class ColorUtils
    def self.get_color(value)
      color = Chroma.paint(value).to_hsv
      magic_regex = /hsv\((?<hue>\d+),\s(?<sat>\d+)%,\s(?<bright>\d+)%\)/i
      values = magic_regex.match(color)
      [values[:hue].to_i, values[:sat].to_i, values[:bright].to_i]
    end

    def self.hsv_to_rgb(h, s, v)
      color = Chroma.paint("hsv(#{h}, #{s}%, #{v}%)")
      color.to_rgb
    end
  end
end
