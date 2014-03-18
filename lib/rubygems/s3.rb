require "rubygems/s3/version"

module Gem
  module S3
    def self.s3_to_https(uri)
      s3_opts = {}
      if uri.user && uri.password
        s3_opts.merge!({ :access_key_id => uri.user, :secret_access_key => uri.password })
      end

      s3 = AWS::S3.new(s3_opts)
      public_uri = s3.buckets[uri.host].objects[uri.path.sub(%r{^/}, '')].url_for(:get).to_s
      URI.parse(public_uri)
    end
  end
end
