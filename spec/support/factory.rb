class Factory

  def self.build(name, *args, &block)
    self.new.send(name, *args, &block)
  end

  private

  def vidyo_admin_client
    Vidyo::Admin::VidyoAdminClient.new(
    instance_url: '',
    admin_username: '',
    admin_password: '',
    extension_base: '',
    app_user_name: ''
  )
  end
end
