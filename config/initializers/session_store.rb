# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_pf_session',
  :secret      => 'd0910f907b0a9617db194a9e87c63c1ddebf8a441202cae9ed5ed80ca2dc2a7d1acee80cd12798be0524285c691cf5967b312456f92026208755d9b1747ae4d3'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
