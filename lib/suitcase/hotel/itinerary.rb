module Suitcase
  class Hotel
    class Itinerary
      extend Helpers
      include Helpers

      attr_accessor :confirmations, :raw, :status, :itinerary_id

      def initialize(raw)
        self.raw = raw
        self.confirmations = Array.wrap(raw["HotelItineraryResponse"]['Itinerary']['HotelConfirmation'])
        self.itinerary_id = raw["HotelItineraryResponse"]["Itinerary"]["itineraryId"]

        self.status = self.confirmations.map{|x| x['status']}
      end

      def pending_supplier?
        status.any?{|status| status == "PS"}
      end

      def canceled?
        status.all?{|status| status == "CX"}
      end

      def confirmed?
        status.all?{|status| status == "CF"}
      end

      def unconfirmed?
        status.all?{|status| status == "UC"}
      end

      def agent_follow_up?
        status.any?{|status| status == "ER"}
      end

      def deleted?
        status.all?{|status| status == "DT"}
      end

      def self.find_by_affiliate_confirmation_id(affiliate_confirmation_id)
        parsed = Hotel.parse_response(Hotel.url(method: 'itin', params: {affiliateConfirmationId: affiliate_confirmation_id}))
        Hotel.handle_errors(parsed)
        Itinerary.new(parsed)
      end

      def self.find_by_id_and_email(itinerary_id, email)
        parsed = Hotel.parse_response(Hotel.url(method: 'itin', params: {itineraryId: itinerary_id, email: email}))
        Hotel.handle_errors(parsed)
        Itinerary.new(parsed)
      end
    end
  end
end
