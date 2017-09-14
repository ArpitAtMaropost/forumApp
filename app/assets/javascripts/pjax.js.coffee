class PJAX

  showLoading = ->
    $('.pjax-loading.animate').show()
    rainbow.show()

  hideLoading = ->
    $('.pjax-loading.animate').hide()
    $(window).scrollTop(0)
    rainbow.hide()

  highlightTopLinks = ->
    $('.nav.nav-pills a').each ->
      if window.location.href.match($(this).attr('href'))
        $(this).parent('li').addClass('active')
      else
        $(this).parent('li').removeClass('active')

  pjaxifyForms = ->
    $('#pjax-container form[data-pjax=true]').on 'submit', ->
      $.pjax.submit(event, '#pjax-container')

  interceptFormLinks = ->
    $(document).on 'link_form:submit', (event, form, link)->
      event.currentTarget = event.target = form;
      if $(link).attr('data-pjax')
        $.pjax.submit(event, '#pjax-container')

  chosenfySelectInputs = ->
    $("select").chosen()

  initializeDatetimepickers = ->
    $('.datetimepicker').datetimepicker()
    $('.datetimepicker').each ->
      dp = $(this).data('datetimepicker')
      date = undefined
      $(this).next('.unscheduled-container').find('input[type=checkbox]').each ->
        $(this).on 'change', ->
          $chkbox = $(this)
          if $chkbox.is(':checked')
            date = dp.getDate()
            $chkbox.closest('.datetimepicker-container').find('.datetimepicker input[type=text]').val('').attr('disabled', 'true')
          else
            dp.setDate(date) if date
            $chkbox.closest('.datetimepicker-container').find('.datetimepicker input[type=text]').removeAttr('disabled')

  hideFloatingAlerts = ->
    setTimeout ->
      $('.floating .alert.fade').fadeOut()
    , 2000

  @init = ->
    if $.support.pjax
      $.pjax.defaults.timeout = 20000
      interceptFormLinks()
      $(document).pjax('a[data-pjax=true]:not([data-method])', '#pjax-container')
      $(document).on 'pjax:send', showLoading
      $(document).on 'pjax:complete', hideLoading

      $(document).on 'pjax:complete', (xhr, status)->
        if status.status == 200
          pjaxifyForms()
          highlightTopLinks()
          hideFloatingAlerts()
          chosenfySelectInputs()
          initializeDatetimepickers()

      $(document).on 'pjax:error', (evt, xhr, status)->
        console.log "pjax:error triggered with status: #{status}"



      # Trigger once on document load
      $(document).trigger('pjax:complete', {status: 200})

$(PJAX.init)