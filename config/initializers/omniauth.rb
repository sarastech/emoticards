OmniAuth.config.full_host = "http://localhost:3000"
 
Rails.application.config.middleware.use OmniAuth::Builder do
 provider :facebook, '447548698625973', 'c572e9fb7455498548efe7aa139bc8cd'
 #provider :twitter, 'ZzLUs4Xtxne4vxOXjx76sA', 'dIsagQ3lVNZ8uV6ujbitpzfgwGtqWN5jCk6RtvqAYQ'
 #provider :yahoo, 'dj0yJmk9UE55NGxHak9iVERWJmQ9WVdrOVpsbEtSbTVwTmpRbWNHbzlOell6TkRnMU1EWXkmcz1jb25zdW1lcnNlY3JldCZ4PTdk', '6b89029871231f564d39554e9bcfec58ffd4bb91' 
 provider :google_oauth2, '456377260159.apps.googleusercontent.com', 'TguUz7fIqfa1BslEbEHRYKhp', {:access_type => 'offline',:approval_prompt => '',:scope => 'https://www.googleapis.com/auth/userinfo.profile,https://www.google.com/m8/feeds'}
end
