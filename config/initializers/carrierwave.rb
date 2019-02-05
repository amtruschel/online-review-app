CarrierWave.configure do |config|
  if !Rails.env.test?
    config.fog_provider = 'fog/aws'                        # required
    config.fog_credentials = {
      provider:              'AWS',                        # required
      aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],     # required unless using use_iam_profile
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']  # required unless using use_iam_profile
    }
    if Rails.env.production?
      config.fog_directory  = ENV['S3_PROD_BUCKET']                                    # required
    else
      config.fog_directory = ENV['S3_DEV_BUCKET']
    end
    config.fog_public = false                                                 # optional, defaults to true
    config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" } # optional, defaults to {}
  end
end
