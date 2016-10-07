# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class DonationChannel < ApplicationCable::Channel
  CHANNEL_NAME = name.underscore.freeze

  def subscribed
    stream_from CHANNEL_NAME
  end

  def unsubscribed

  end
end
