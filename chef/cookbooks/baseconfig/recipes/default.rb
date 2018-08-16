# Make sure the Apt package lists are up to date, so we're downloading versions that exist.
cookbook_file "apt-sources.list" do
  path "/etc/apt/sources.list"
end
execute 'apt_update' do
  command 'apt-get update'
end

# Base configuration recipe in Chef.
package "wget"
package "ntp"
cookbook_file "ntp.conf" do
  path "/etc/ntp.conf"
end

execute 'ntp_restart' do
  command 'service ntp restart'
end

#Rails setup
package "ruby-dev"
package "sqlite3"
package "libsqlite3-dev"
package "zlib1g-dev"
package "liblzma-dev"
package "nodejs"

execute 'bundler install' do
	command 'gem install bundler --conservative'
end

execute 'patch' do
	command 'sudo apt-get -y install build-essential patch ruby-dev zlib1g-dev liblzma-dev'
end

execute 'install nokogiri' do
	command "gem install nokogiri -v '1.6.7.1' --conservative"
end

execute 'bundle' do
	command "bundle install"
	cwd '/home/vagrant/project'
	user 'vagrant'
end

execute 'db migrate' do
	command "rails db:migrate RAILS_ENV=development"
	cwd '/home/vagrant/project'
	user 'vagrant'
end

execute 'db seed' do
	command "rails db:seed RAILS_ENV=development"
	cwd '/home/vagrant/project'
	user 'vagrant'
end

execute 'run scheduled jobs' do
	command "whenever --update-crontab --set environment='development'"
	cwd '/home/vagrant/project'
	user 'vagrant'
end

execute 'start server' do
	command 'rails server -d -b 0.0.0.0'
	cwd '/home/vagrant/project'
	user 'vagrant'
end
