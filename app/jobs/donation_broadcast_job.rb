class DonationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(donation, action_name)
    ActionCable.server.broadcast DonationChannel::CHANNEL_NAME,
      donation: donation.to_json(only: [:id, :name, :amount]),
      action: action_name
  end
end
