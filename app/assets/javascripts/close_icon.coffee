ready = ->
  $('.message .close').on('click', 
    -> $(this).closest('.message').hide()
  )

$(document).ready(ready)
$(document).on('page:load', ready)

