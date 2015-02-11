guard :rspec, cmd: 'bundle exec rspec' do
  # watch /lib/ files
  watch(%r{^lib/(.+).rb$}) do |m|
    "spec/#{m[1]}_spec.rb"
  end

  # watch /lib/admin_api/ files
  watch(%r{^lib/admin_api/(.+).rb$}) do |m|
    "spec/admin_api.#{m[1]}_spec.rb"
  end

  # watch /spec/ files
  watch(%r{^spec/(.+).rb$}) do |m|
    "spec/#{m[1]}.rb"
  end
end
