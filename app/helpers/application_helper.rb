module ApplicationHelper

  def boxed_form(title, &block)
    render :layout => '/shared/form_box', :locals => {:box_title => title}, &block
  end

  alias box boxed_form

  def more_box(&block)
    more_link = link_to_function "more..", "$(this).hide().siblings('a').show().end().siblings('.hidden_more').show()"
    more_link += link_to_function "less..", "$(this).hide().siblings('a').show().end().siblings('.hidden_more').hide()", :style => 'display:none'
    content_tag(:span) do
      more_link + content_tag(:span, :style => "display:none", :class => "hidden_more", &block)
    end
  end

  def flash_messages
    flash_messages = flash.collect { |type,message| [bootstrap_message_class(type),message] }
    render 'shared/flash_messages', :flash => flash_messages
  end

  def resource_error_messages
    flash_messages = resource.errors.full_messages.map { |msg| ['error', msg] }
    render 'shared/flash_messages', :flash => flash_messages
  end

  def bootstrap_message_class(type)
    case type
      when :alert
        'error'
      when :error
        'error'
      when :notice
        'info'
      when :success
        'success'
      else
        type.to_s
    end
  end

  def user_is_admin?
    user_signed_in? && current_user.admin?
  end

  def random_color
    "#{"#%06x" % (rand * 0x777777 + 0x333333 )}"
  end

  WEIGHT_MULTIPLIER = 10
  def weighted_color(weight)
    red, green, blue = 20, 150, 250
    blue -= weight*WEIGHT_MULTIPLIER
    green -= weight*WEIGHT_MULTIPLIER
    red += weight*WEIGHT_MULTIPLIER
    green = 50 if green < 50
    blue = 20 if blue < 20
    red = 200 if red > 200
    "##{red.to_s(16)}#{green.to_s(16)}#{blue.to_s(16)}"
  end
end
