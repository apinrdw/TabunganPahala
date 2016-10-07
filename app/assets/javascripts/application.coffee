#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require _custom-semantic-ui
#= require_tree .

jQuery.extend(jQuery.expr[':'], {
  focusable: (el, index, selector) ->
    return $(el).is(':input:not([type=hidden])')
});

Number.prototype.toCurrencyString = ->
  return this.toFixed(2).replace(/(\d)(?=(\d{3})+\b)/g,'$1,')

$(document).on 'keypress', 'button[type=submit],input,select', (e) ->
  if (e.which == 13)
    canFocus = $(':focusable')
    index = canFocus.index(document.activeElement) + 1
    console.log([index, canFocus.length])
    if (canFocus.eq(index).is(':button[type=submit]'))
      return true
    else
      e.preventDefault()
      canFocus.eq(index).focus()

$(document).on 'click', '#push-menu', (e) ->
  $('#sidebar-menu').sidebar('toggle')

$(document).on 'confirm', (e) ->
  element = $(e.target)
  message = element.data('confirm')

  $('#confirmation-modal').modal({
    closable: false
    blurring: true
    onApprove: ->
      element.data("confirm", null)
      element.trigger("click.rails")
      element.data("confirm", message)
  }).modal('show')

  return false