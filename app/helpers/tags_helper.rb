module TagsHelper
  VOTE_MULTIPLIER = 10

  def tag_count_style(count)
    count = count
    red, green, blue = 20, 150, 250

    blue -= count*VOTE_MULTIPLIER
    green -= count*VOTE_MULTIPLIER
    red += count*VOTE_MULTIPLIER
    green = 50 if green < 50
    blue = 20 if blue < 20
    red = 200 if red > 200

    "background-color: ##{red.to_s(16)}#{green.to_s(16)}#{blue.to_s(16)}; padding-right: #{count > 50 ? '110px':"#{count*2 + 10}px"}"
  end
end
