class StaticController < ApplicationController
  def index
    beaukeh = Beau.new
    beaukeh.make_a_beaukeh

    @svg = beaukeh.svg
    @signature = beaukeh.signature
    @background_color = beaukeh.background_color
  end

  def about
  end

  def background
    beaukeh = Beau.new
    beaukeh.make_a_beaukeh(background_params)

    @svg = beaukeh.svg
    @signature = beaukeh.signature
    @background_color = beaukeh.background_color
  end

  def gimme
    puts params["svg"]

    redirect_to index_path
  end

  private

  def background_params
    params.require(:background_color)
    return validate_background_color(params[:background_color].downcase)
  end

  def validate_background_color(background_color)
    unless background_color.match(/[a-f0-9]{6}/)
      return 'ffffff'
    else
      return background_color
    end 
  end
end
