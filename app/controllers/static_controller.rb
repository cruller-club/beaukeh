ActiveRecord::Base.include_root_in_json = true

class StaticController < ApplicationController
  def index
    beaukeh = Beau.new
    @background_color = background_params
    
    if @background_color.nil?
      @sticky = false
    else
      @sticky = true
    end

    beaukeh.make_a_beaukeh(@background_color)
    @background_color = beaukeh.background_color

    @svg = beaukeh.svg
    @signature = beaukeh.signature
    @population = beaukeh.population
    @density = beaukeh.density
    @aura = beaukeh.aura
    @energy = beaukeh.energy

    respond_to do |format|
      format.html {}
      format.json {
        render json: JSON.pretty_generate(beaukeh.as_json)
      }
    end
  end

  def about
  end

  def gimme
    puts params["svg"]

    redirect_to index_path
  end

  private

  def background_params
    params.permit(:background_color, :format)
    unless params[:background_color].nil?
      return validate_background_color(params[:background_color].downcase)
    else
      return nil
    end
  end

  def validate_background_color(background_color)
    unless background_color.match(/[a-f0-9]{6}/)
      return nil
    else
      return background_color
    end 
  end
end
