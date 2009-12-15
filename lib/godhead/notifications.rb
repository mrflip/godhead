module God
  #
  # Adds a notification contact
  # pass in a group name and a valid email address.
  #
  def self.add_contact group, to_address
    God.contact(:email) do |c|
      c.group         = group
      c.email         = to_address
      c.name          = "God monitoring #{group} notification"
    end
  end

  #
  # GMail
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
  def self.notify_by_smtp options
    God::Contacts::Email.message_settings = {
      :from           => options[:username], }
    God::Contacts::Email.server_settings = {
      :address        => options[:address],
      :port           => options[:port] || 25,
      :domain         => options[:smtp_domain],
      :user_name      => options[:username],
      :password       => options[:password],
      :authentication => :plain,
    }
  end
end
