module Split
  module Store
    class Session
      def initialize(context)
        @session = context.send :session
      end

      def get(key)
        session_hash[key]
      end

      def choose(key, value)
        session_hash[key] = value
      end

      def delete(key)
        session_hash.delete key
      end

      private

      def session_hash
        @session[:split] ||= {}
      end
    end

    class Cookies
      def initialize(context)
        @cookies = context.send :cookies
      end

      def get(key)
        name = cookie_name(key)
        @cookies[name]
      end

      def choose(key, value)
        name = cookie_name(key)
        @cookies[name] = {:value => value, :expires => 6.months.from_now.utc}
      end

      def delete(key)
        name = cookie_name key
        @cookies.delete name
      end

      private

      def cookie_name(key)
        stripped = key.gsub(/\W+/, '_')
        "split_#{stripped}"
      end
    end

    class << self
      attr_accessor :kind
    end

    self.kind = ::Split::Store::Session
  end
end
