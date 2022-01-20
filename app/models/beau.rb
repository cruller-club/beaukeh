class Beau < ApplicationRecord
  POPULATION_MEAN = 100 # Circle count
  POPULATION_STDV = 50
  X_MEAN = 50 # (%) Centered horizontally in the view plane.
  X_STDV = 25
  Y_MEAN = 50 # (%) Centered vertically in the view plane.
  Y_STDV = 10 # Tighter distribution than X coordinates, because aspect ratio.
  R_MEAN = 10 # Feels about right visually.
  R_STDV = 10
  SATURATION_MEAN = 50 # (%)
  SATURATION_STDV = 25
  BRIGHTNESS_MEAN = 50 # (%)
  BRIGHTNESS_STDV = 25

  def make_a_beaukeh(background_color = nil)
    @background_color

    if background_color.nil?
      @background_color = gimme_a_color
      self.background_color = @background_color.to_rgb.hex
    else
      @background_color = Color::RGB.by_hex(background_color)
      self.background_color = @background_color.to_rgb.hex
    end

    # Set up the main SVG container.
    beaukeh = Victor::SVG.new(
      viewBox: '0 0 235 100', # Cinemascope Aspect Ratio
      style: { background: "##{self.background_color}" },
      id: 'beaukeh')

    circles = []
    population = Rubystats::NormalDistribution.new(POPULATION_MEAN, POPULATION_STDV).rng.round(0)
    population.abs.times do
      cx = Rubystats::NormalDistribution.new(X_MEAN, X_STDV).rng.abs
      cy = Rubystats::NormalDistribution.new(Y_MEAN, Y_STDV).rng.abs
      r = Rubystats::NormalDistribution.new(R_MEAN, R_STDV).rng.abs
      fill = gimme_a_color

      circles.push({ cx: cx, cy: cy, r: r, fill: fill.to_rgb.hex })
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

    # Calculate stats!
    self.population = population.abs
    self.density = calculate_density(population.abs)
    self.aura = calculate_aura(@background_color.to_hsl.saturation)
    self.energy = calculate_energy(@background_color.to_hsl.lightness)

    self.svg = beaukeh.render
    self.signature = Digest::SHA256.hexdigest self.svg
  end

  private

  def gimme_a_color
    hue = Random.rand(0..360)
    saturation = Rubystats::NormalDistribution.new(SATURATION_MEAN, SATURATION_STDV).rng 
    brightness = Rubystats::NormalDistribution.new(BRIGHTNESS_MEAN, BRIGHTNESS_STDV).rng

    color = Color::HSL.new()
    color.hue = hue
    color.saturation = saturation
    color.lightness = brightness

    return color
  end

  def calculate_density(population)
    # Density: Voidesmic >> Araiosan >> Sparse >> Busy >> Frenetic >> Gravidrous

    dist = Rubystats::NormalDistribution.new(POPULATION_MEAN, POPULATION_STDV)
    cdf = dist.cdf(population)

    if cdf < 0.05
      return "Voidesmic"
    elsif cdf < 0.20
      return "Araiosan"
    elsif cdf < 0.50
      return "Sparse"
    elsif cdf < 0.80
      return "Busy"
    elsif cdf < 0.95
      return "Frenetic"
    else
      return "Gravidrous"
    end
  end

  def calculate_aura(saturation)
    # Aura: Achromic >> Apogeean >> Muted >> Sottoish >> Vivid >> Zoirostrous

    dist = Rubystats::NormalDistribution.new(SATURATION_MEAN, SATURATION_STDV)
    cdf = dist.cdf(saturation)

    if cdf < 0.05
      return "Achromic"
    elsif cdf < 0.20
      return "Apogeean"
    elsif cdf < 0.50
      return "Muted"
    elsif cdf < 0.80
      return "Sottoish"
    elsif cdf < 0.95
      return "Vivid"
    else
      return "Zoirostrous"
    end
  end

  def calculate_energy(brightness)
    # Energy: Vantallic >> Abyssian >> Shadowy >> Crepescular >> Luminescent >> Hyperphaedrous

    dist = Rubystats::NormalDistribution.new(BRIGHTNESS_MEAN, BRIGHTNESS_STDV)
    cdf = dist.cdf(brightness)

    if cdf < 0.05
      return "Vantallic"
    elsif cdf < 0.20
      return "Abyssian"
    elsif cdf < 0.50
      return "Shadowy"
    elsif cdf < 0.80
      return "Crepescular"
    elsif cdf < 0.95
      return "Luminescent"
    else
      return "Hyperphaedrous"
    end
  end
end
