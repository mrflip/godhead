module God
  def self.setup_email options, &block
    God::Contacts::Email.message_settings = {
      :from           => options[:from], }
    God.contact(:email) do |c|
      c.email         = options[:to]
      c.group         = options[:group] || 'default'
      block.call(c) if block
    end
  end

  #
  # GMail
  #
  # http://millarian.com/programming/ruby-on-rails/monitoring-thin-using-god-with-google-apps-notifications/
  def self.notify_by_gmail options, &block
    require 'tlsmail'
    setup_email options, &block
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
    God::Contacts::Email.server_settings = {
      :address        => options[:smtp_address],
      :port           => 25,
      :user_name      => options[:from],
      :password       => options[:password],
      :domain         => options[:domain],
      :authentication => :plain
    }
  end
end
