require "savon"
require 'nokogiri'

module Smsim
  class DeliveryNotificationsParser
    attr_reader :logger, :gateway

    # Create new sms sender with given +gateway+
    def initialize(gateway)
      @gateway = gateway
      @logger = Logging.logger[self.class]
    end

    # params will look something like the following:
    # { "SegmentsNumber"=>"1", "ProjectId"=>"3127", "Status"=>"2", "SenderNumber"=>"0545290862", "StatusDescription"=>"Delivered",
    #   "PhoneNumber"=>"0545290862", "RetriesNumber"=>"0", "OriginalMessage"=>"מה מצב?",
    #   "CustomerMessageId"=>"18825cc0-6a2d-11e1-903f-70cd60fffee5", "BillingCodeId"=>"1", "id"=>"", "Network"=>"054", "CustomerParam"=>"",
    #   "NotificationDate"=>"09/03/2012 23:16:04", "ActionType"=>"Content", "Price"=>"0.00"}
    def http_push(params)
      %w(PhoneNumber   Status   CustomerMessageId   SegmentsNumber   NotificationDate).each do |p|
        raise Smsim::GatewayError.new(301, "Missing http parameter #{p}. Parameters were: #{params.inspect}", :params => params) if params[p].blank?
      end
      logger.debug "Parsing http push delivery notification params: #{params.inspect}"

      values = {
        :gateway_status => params['Status'],
        :phone => params['PhoneNumber'],
        :message_id => params['CustomerMessageId'],
        :parts_count => params['SegmentsNumber'],
        :completed_at => params['NotificationDate'],
        :reply_to_phone => params['SenderNumber'],
        :reason_not_delivered => params['StatusDescription'],
      }

      parse_notification_values_hash(values)
    end

    # This method receives notification +values+ Hash and tries to type cast it's values and determine delivery status (add delivered?)
    # @raises Smsim::GatewayError when values hash is missing attributes or when one of the attributes fails to be parsed
    #
    # Method returns object with the following attributes:
    # * +gateway_status+ - gateway status (integer) value. see api pdf for more info about this value
    # * +delivery_status+ - :delivered or :failed
    # * +parts_count+ - how many parts the sms was
    # * +completed_at+ - when the sms was delivered (as reported by network operator)
    # * +phone+ - the phone to which sms was sent
    # * +reply_to_phone+ - the phone to sms reply will be sent when receiver replies to message
    # * +message_id+ - gateway message id of the sms that was sent
    def parse_notification_values_hash(values)
      logger.debug "Parsing delivery notification values hash: #{values.inspect}"
      Time.zone = @gateway.time_zone
      [:gateway_status, :phone, :message_id, :parts_count, :completed_at].each do |key|
        raise Smsim::GatewayError.new(301, "Missing notification values key #{key}. Values were: #{values.inspect}", :values => values) if values[key].blank?
      end

      values[:phone] = PhoneNumberUtils.ensure_country_code(values[:phone])
      values[:reply_to_phone] = PhoneNumberUtils.ensure_country_code(values[:reply_to_phone]) if values[:reply_to_phone].present?

      begin
        values[:gateway_status] = Integer(values[:gateway_status])
      rescue Exception => e
        logger.error "Status could not be converted to integer. Status was: #{values[:gateway_status]}. \n\t #{e.message}: \n\t #{e.backtrace.join("\n\t")}"
        raise Smsim::GatewayError.new(302, "Status could not be converted to integer. Status was: #{values[:gateway_status]}", :values => values)
      end

      values[:delivery_status] = self.class.gateway_delivery_status_to_delivery_status(values[:gateway_status])

      begin
        values[:parts_count] = Integer(values[:parts_count])
      rescue Exception => e
        logger.error "SegmentsNumber could not be converted to integer. SegmentsNumber was: #{values[:parts_count]}. \n\t #{e.message}: \n\t #{e.backtrace.join("\n\t")}"
        raise Smsim::GatewayError.new(302, "SegmentsNumber could not be converted to integer. SegmentsNumber was: #{values[:parts_count]}", :values => values)
      end

      begin
        values[:completed_at] = DateTime.strptime(values[:completed_at], '%d/%m/%Y %H:%M:%S')
        values[:completed_at] = Time.zone.parse(values[:completed_at].strftime('%Y-%m-%d %H:%M:%S')) #convert to ActiveSupport::TimeWithZone
      rescue Exception => e
        logger.error "NotificationDate could not be converted to integer. NotificationDate was: #{values[:completed_at]}. \n\t #{e.message}: \n\t #{e.backtrace.join("\n\t")}"
        raise Smsim::GatewayError.new(302, "NotificationDate could not be converted to date. NotificationDate was: #{values[:completed_at]}", :values => values)
      end

      OpenStruct.new(values)
    end

    def self.gateway_delivery_status_to_delivery_status(gateway_status)
      gateway_status == 2 ? :delivered : :failed
    end

  end
end
