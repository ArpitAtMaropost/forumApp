class BootstrapDatetimeInput < SimpleForm::Inputs::Base
  def input

    <<-HTML.html_safe
<div class="datetimepicker-container">
<div class="datetimepicker input-append date">
  #{@builder.text_field attribute_name, {:'data-format' => "dd/MM/yyyy hh:mm"} }
  <span class="add-on #{ 'not-last' if input_options[:unschedule_button]}">
    <i data-time-icon="icon-time" data-date-icon="icon-calendar"></i>
  </span>
</div>
<div class="unscheduled-container">
#{ '<span class="unscheduled-add-on"><input type="checkbox"/><span class="checkbox-label">Unscheduled</span></span>' if input_options[:unschedule_button]}
</div>
<div style="clear:both"></div>
</div>
    HTML
  end
end