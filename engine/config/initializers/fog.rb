if Rails.env == "development"
  # Fog supports mocking s3 calls in test environments, so let's leverage that in development mode too
  Fog.mock!
end