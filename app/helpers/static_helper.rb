module StaticHelper
  def beaukeh_button_group(background_color)
    render(
      'static/shared/beaukeh_button_group',
      background_color: background_color,
      brightness: check_brightness(background_color))
  end

  def check_brightness(color)
    average = color.scan(/../).map { |v| v.hex }.sum / 3

    if average > (256 / 2)
      return 'light'
    else
      return 'dark'
    end
  end
end
