module Marketo
  class Middleware::Caching < FaradayMiddleware::Caching
    def call(env)
      expire(cache_key(env)) unless use_cache?
      super
    end

    def expire(key)
      cache.delete(key) if cache
    end

    # We don't want to cache requests for different clients, so append the
    # oauth token to the cache key.
    def cache_key(env)
      super(env) + hashed_auth_header(env)
    end

    def use_cache?
      @options.fetch(:use_cache, true)
    end

    def hashed_auth_header(env)
      Digest::SHA1.hexdigest(
        env[:request_headers][Marketo::Middleware::Authorization::AUTH_HEADER]
      )
    end
  end
end
