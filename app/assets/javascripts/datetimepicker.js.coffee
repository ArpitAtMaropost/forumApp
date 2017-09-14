# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $.fn.datetimepicker.defaults =
    maskInput: true           # disables the text input mask
    pickDate: true            # disables the date picker
    pickTime: true            # disables de time picker
    pick12HourFormat: false   # enables the 12-hour format time picker
    pickSeconds: false        # disables seconds in the time picker
    startDate: -Infinity      # set a minimum date
    endDate: Infinity         # set a maximum date
