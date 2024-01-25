class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  process resize_to_fit: [300, 200]

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_allowlist
    %w(jpg jpeg gif png)
  end
end
