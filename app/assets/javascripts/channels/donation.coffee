$(document).on 'turbolinks:load', ->
  if $('#dashboard').length > 0
    App.donation = App.cable.subscriptions.create "DonationChannel",
      connected: ->
        console.log('connect')

      disconnected: ->
        console.log('disconnect')

      received: (data) ->
        totalAmount = parseFloat($('h1.header').data('amount'))
        newDonation = JSON.parse(data.donation)
        newDonation.amount = parseFloat(newDonation.amount)
        donationID = 'tr#donation-' + newDonation.id

        if data.action == 'create'
          totalAmount += newDonation.amount
          $('#dashboard table tbody').prepend(
            "<tr id=\"donation-#{newDonation.id}\">" +
              "<td>#{newDonation.name}</td>" +
              "<td class=\"right aligned collapsing\">Rp. #{newDonation.amount.toCurrencyString()}</td>" +
            "</tr>"
          )
          $(donationID).data('donation', newDonation)
        else if data.action == 'update'
          oldDonation = $(donationID).data('donation')
          oldDonation.amount = parseFloat(oldDonation.amount)

          diffAmount = (oldDonation.amount - newDonation.amount) * -1
          totalAmount += diffAmount

          $(donationID).find('td:eq(0)').text(newDonation.name)
          $(donationID).find('td:eq(1)').text('Rp. ' + newDonation.amount.toCurrencyString())
          $(donationID).data('donation', newDonation)
        else if data.action == 'destroy'
          totalAmount -= newDonation.amount
          $(donationID).remove()
        else
          return

        $('h1.header')
          .data('amount', totalAmount)
          .text('Rp. ' + totalAmount.toCurrencyString())
  else
    App.cable.subscriptions.remove(App.donation) if App.donation
