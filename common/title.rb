
class TitleSketch < Processing::App

  def draw_bunting(x,y, width, height)
    bunting_colors = [[0,0,0],[255,255,255]]
    color = bunting_colors[rand(bunting_colors.length )]
    puts color.inspect
    fill(*color)
    stroke(255)
    x2 = x + width
    y2 = y
    x3 = x + (width.to_f / 2)
    y3 = y + height
    triangle(x,y,x2, y2, x3, y3)
  end

  def setup
    size 600, 800
    # color_mode RGB, 1.0
    smooth
    no_loop


    fill(63, 169, 155)
    noStroke()
    rect(0,0,width,height)
    fill(153)
    stroke(204,102,0)
    bunting_width = 20
    bunting_height = 30
    bunting_spacer = 10
    num_cols = width / (bunting_width + bunting_spacer )
    num_rows = height / (bunting_height + bunting_spacer)

    for i in (0..(num_rows - 1))

        y = (bunting_spacer / 2) + (i * (bunting_height + bunting_spacer))
      for i in (0..(num_cols - 1))
        x = (i * (bunting_width + bunting_spacer)) + (bunting_spacer / 2)
        draw_bunting(x,y,bunting_width, bunting_height)
      end
    end

    save('en/title.png')

    exit

  end

  def draw
  end

end


TitleSketch.new :title => "title", :width => 400, :height => 400

