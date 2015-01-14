ENV['GITHUB_KEY'] ||= 'cbee726022796a360628'
ENV['GITHUB_SECRET'] ||= 'f9f4b293ca7c55f6ce3ab04ee789fa02f0569e60'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
end