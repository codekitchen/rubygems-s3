# Rubygems::S3

This rubygems plugin allows you to add private S3 rubygems repos as
sources in your gemrc file.

## Installation

You'll need a recent version of rubygems.

    gem update --system
    gem install rubygems-s3

## Usage

    gem sources --add s3://key:secret@my-bucket/path-to-gems/

Then just `gem install my-private-gem`.

Alternatively you can omit the key and secret, but you'll need to get
AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY into your environment some
other way if you do that. It's strongly recommended that you create an
IAM user specifically for this purpose, with access only to the list and
get actions on the relevant s3 bucket.

Right now I'm publishing gems to our S3 bucket using s3fs and `gem
generate_index`, eventually I'd like to create better tooling.

## Implementation Notes

Currently this works by monkey patching the `Gem::RemoteFetcher` class,
as it's not yet fully plugin-able. I'm working to improve that, at which
time the implementation will become cleaner, but usage will remain the
same.

## Contributing

1. Fork it ( http://github.com/codekitchen/rubygems-s3/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
