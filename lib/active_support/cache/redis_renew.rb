# encoding: UTF-8
require 'redis-activesupport'
require 'redis-store'

module ActiveSupport
  module Cache
    class RedisRenew < RedisStore
      protected

      def read_entry(key, local_options)
        renew_expires_in = options[:renew_expires_in] || local_options[:expires_in] || nil
        return super unless renew_expires_in # bail if no renewal desired

        if connection_supports_multi?
          replies = @data.multi do |multi|
            multi.get(key, local_options)
            multi.expire(key, renew_expires_in)
          end

          entry = replies.first

          case
          when entry && entry.is_a?(ActiveSupport::Cache::Entry) then 
            entry
          when entry then
            ActiveSupport::Cache::Entry.new(entry)
          else
            nil
          end
        else
          entry = super # do nothing and manually reset expiry
          @data.expire(key, renew_expires_in)
          entry
        end
      rescue Errno::ECONNREFUSED, Redis::CannotConnectError
        nil
      end

      private

      def connection_supports_multi?
        false
        # redis-store changes the interface to a redis connection
        # so the `get` override kills multi
        # @data.respond_to?(:multi) 
      end
    end
  end
end
