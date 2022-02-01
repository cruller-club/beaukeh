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

  def mint
    beaukeh = Beau.new

    @background_color = background_params
    
    if @background_color.nil?
      @sticky = false
    else
      @sticky = true
    end

    beaukeh.make_a_beaukeh(@background_color)

    if beaukeh.save
      puts "\n\n\n\n#{beaukeh.signature} saved!\n\n\n\n"
      redirect_to gimme_path(beaukeh.signature)
    else
      redirect_to root_path
    end
  end

  def meta
    beaukeh = Beau.find_by(signature: params[:signature])
    
    if beaukeh.nil?
      redirect_to root_path
    else
      meta_beaukeh = { }

      meta_beaukeh[:token_id] = beaukeh.signature
      meta_beaukeh[:image_url] = "https://beaukeh.cruller.club/gimme/#{beaukeh.signature}"
      meta_beaukeh[:background_color] = beaukeh.background_color
      meta_beaukeh[:name] = beaukeh.signature
      meta_beaukeh[:external_link] = "https://beaukeh.cruller.club/show/#{beaukeh.signature}"
      meta_beaukeh[:asset_contract] = "asset_contract"
      meta_beaukeh[:owner] = "owner"
      meta_beaukeh[:metadata] = {
        image: "https://beaukeh.cruller.club/gimme/#{beaukeh.signature}",
        external_url: "https://beaukeh.cruller.club/show/#{beaukeh.signature}",
        description: "Beaukeh #{ beaukeh.id } / #{ Beau.count }: #{ beaukeh.signature }",
        name: beaukeh.signature,
        background_color: beaukeh.background_color,
        attributes: [
          { trait_type: "density", value: beaukeh.density },
          { trait_type: "aura", value: beaukeh.aura },
          { trait_type: "energy", value: beaukeh.energy }
        ]
      }

      render json: JSON.pretty_generate(meta_beaukeh[:metadata].as_json)
    end
  end

  def show
    beaukeh = Beau.find_by(signature: params[:signature])
    
    if beaukeh.nil?
      redirect_to root_path
    else
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
  end

  def gimme
    beaukeh = Beau.find_by(signature: params[:signature])

    if beaukeh.nil?
      redirect_to root_path
    else
      send_data beaukeh.svg, filename: "#{beaukeh.signature}.svg"
    end
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
