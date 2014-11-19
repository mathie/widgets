guard :bundler do
  watch('Gemfile')
end

guard :rspec, cmd: 'bin/rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^app/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }

  watch(%r{^spec/support/(.+)\.rb$})     { "spec" }
  watch(%r{spec/(rails|spec)_helper.rb}) { "spec" }

  watch('app/controllers/application_controller.rb')  { "spec/controllers" }
  watch(%r{^app/controllers/(.+)_controller\.rb$}) do |m|
    [
      "spec/routing/#{m[1]}_controller_routing_spec.rb",
      "spec/controllers/#{m[1]}_controller_spec.rb",
      "spec/features/#{m[1]}_spec.rb"
    ]
  end
  watch(%r{^app/views/(.+)/.*\.(erb|haml|slim)$}) { |m| "spec/features/#{m[1]}_spec.rb" }

  watch('config/routes.rb') { "spec/routing" }
end

