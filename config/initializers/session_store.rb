# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_tipout_session',
  :secret      => '09a6928eb4f4218e8d8753657225eec724034412fe59469f352ecba73bfd565dc710df9ceb9cbe94ec4d079e9cb5f81f8dbe7dd0afe4b6dbecb71930999cd0ac'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
