class StaticController < ApplicationController
  def index
    beaukeh = Beau.new

    @svg = beaukeh.svg
    @signature = beaukeh.signature
    @background_color = beaukeh.background_color
  end

  def about
  end

  def gimme
    puts params["svg"]

    redirect_to index_path
  end
end
