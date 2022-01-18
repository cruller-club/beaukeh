class Beau < ApplicationRecord
  after_initialize :make_a_beaukeh

  def make_a_beaukeh
    self.background_color = gimme_a_color

    # Set up the main SVG container.
    beaukeh = Victor::SVG.new(
      viewBox: '0 0 235 100', # Cinemascope Aspect Ratio
      style: { background: "##{self.background_color}" },
      id: 'beaukeh')

    circles = []
    population = Rubystats::NormalDistribution.new(100, 50).rng.round(0)
    population.abs.times do
      cx = Rubystats::NormalDistribution.new(50, 25).rng.abs
      cy = Rubystats::NormalDistribution.new(50, 10).rng.abs
      r = Rubystats::NormalDistribution.new(10, 10).rng.abs
      fill = gimme_a_color

      circles.push({ cx: cx, cy: cy, r: r, fill: fill })
    end

    # Build some Beaukeh!
    beaukeh.build do
      css['circle'] = { opacity: 0.10 }
      circles.each do |c|
        circle(
          cx: "#{c[:cx]}%",
          cy: "#{c[:cy]}%",
          r: c[:r],
          fill: "##{c[:fill]}")
      end
    end

    self.svg = beaukeh.render
    self.signature = Digest::SHA256.hexdigest self.svg
  end

  private

  def gimme_a_color
    hue = Random.rand(0..360)
    saturation = Rubystats::NormalDistribution.new(50, 25).rng
    brightness = Rubystats::NormalDistribution.new(50, 25).rng

    color = Chroma.paint("hsl(#{hue}, #{saturation}, #{brightness})").to_hex.gsub('#', '')

    return color
  end
end
