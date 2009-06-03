# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_carousel_session',
  :secret      => '6d6c592db57dd76b0696a9880a0bb843c7e88f422aaa414fa0dd223fffee4355e63dfc6f84766708881b7423dad4dd7a56a356676dd47075b0ab4c27db8ffa38'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
