require 'aws-sdk'
require 'rubygems/s3'
require 'rubygems/remote_fetcher'

class Gem::RemoteFetcher
  alias_method :download_without_s3, :download
  def download(spec, source_uri, install_dir = Gem.dir)
    unless source_uri.is_a?(URI::Generic)
      begin
        source_uri = URI.parse(source_uri)
      rescue
        source_uri = URI.parse(URI.const_defined?(:DEFAULT_PARSER) ?
                               URI::DEFAULT_PARSER.escape(source_uri.to_s) :
                               URI.escape(source_uri.to_s))
      end
    end
    if source_uri.scheme == "s3"
      source_uri.scheme = "https"
      source_uri.path = "/hacky-s3-hack" + source_uri.path
    end
    download_without_s3(spec, source_uri, install_dir)
  end

  def fetch_s3(uri, mtime = nil, head = false)
    fetch_https Gem::S3.s3_to_https(uri), mtime, head
  end

  alias_method :fetch_path_without_s3, :fetch_path
  def fetch_path(uri, mtime = nil, head = false)
    uri = URI.parse uri unless URI::Generic === uri
    if uri.path.start_with?('/hacky-s3-hack')
      uri.path = uri.path.sub('/hacky-s3-hack', '')
      uri = Gem::S3.s3_to_https(uri)
    end
    fetch_path_without_s3(uri, mtime, head)
  end
end
