module TopicsHelper
  VOTE_MULTIPLIER = 10

  def vote_count_style(topic)
    vote_count = topic.votes.count
    "background-color: #{weighted_color(vote_count)}; padding-right: #{vote_count > 50 ? '110px':"#{vote_count*2 + 10}px"}"
  end

  def topics_timeline(topics)
    html = '<div class="timeline">'
    html2 = ''
    topics.reverse!
    start_time = topics[0].scheduled_start
    end_time  = topics[-1].scheduled_start + topics[-1].duration.minutes
    span = (end_time - start_time)/60
    topics.each_with_index do |topic, idx|
      topic_start = (topic.scheduled_start - start_time)*100/(span*60)
      topic_width = (topic.duration/span)*100
      color = random_color
      html << "<div class=\"schedule\" style=\"background-color:#{color};left:#{topic_start}%;width: #{topic_width}%\"><span>#{topic.scheduled_start.in_time_zone.strftime('%l:%M%P')} - #{topic.duration}m</span>"
      html << "</div>"
      html2 << topic_description_box(topic, topic_start, topic_width, idx%2 == 0 ? :up : :down, color)
    end
    html << '<div style="clear:both"></div></div>'
    (html + html2).html_safe
  end

  def topic_description_box(topic, start, width, orientation, color)
    html = ''
    html << <<-HTML
      <div class="tipsy tipsy-#{orientation == :up ? 'n' : 's'}" style="left: #{start}%; visibility: visible; display: block; opacity: 0.6; box-shadow: 0 #{orientation == :up ? '' : '-'}15px 30px #{color}">
        <div class="tipsy-arrow"></div>
        <div class="tipsy-inner">#{ render :partial =>  'shared/topic_description', :locals => {:topic => topic}}</div>
      </div>
    HTML
  end

end
