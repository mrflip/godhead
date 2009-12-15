module God
  #
  # Sets up
  #
  def self.add_simple_contact to_address, group=nil, &block
    God.contact(:email) do |c|
      c.email         = to_address
      c.group         = group || 'default'
      block.call(c) if block
    end
  end

  #
  # GMail
  #
  # Sends mail using a gmail or google apps account.
  #
  # http://millarian.com/programming/ruby-on-rails/monitoring-thin-using-god-with-google-apps-notifications/
  def self.notify_by_gmail options
    require 'tlsmail'
    Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
    notify_by_smtp options.reverse_merge({
        :address        => 'smtp.gmail.com',
        :tls            => 'true',
        :port           => 587,
      })
  end

  #
  # SMTP email
  #
  # Assumes that the 'from' account and the smtp server login name are identical.
  def self.notify_by_smtp options
    God::Contacts::Email.message_settings = {
      :from           => options[:username], }
    God::Contacts::Email.server_settings = {
      :address        => options[:address],
      :port           => options[:port] || 25,
      :user_name      => options[:username],
      :password       => options[:password],
      :domain         => options[:domain],
      :authentication => :plain
    }
  end
end
