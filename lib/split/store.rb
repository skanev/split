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
  end
end
