
class TitleSketch < Processing::App

  def setup
    size 500, 800
    color_mode RGB, 1.0
    smooth
    no_loop

    triangle(rand(width), rand(height), rand(width), rand(height), rand(width), rand(height))

    save('en/title.png')

    exit

  end

  def draw
  end

end


TitleSketch.new :title => "title", :width => 400, :height => 400

