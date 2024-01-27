apt_update

package 'git'
package 'build-essential'
package 'libssl-dev'
package 'libreadline-dev'
package 'libyaml-dev'
package 'zlib1g-dev'
package 'nodejs'

unless File.exists?('/usr/local/bin/ruby')
  remote_file '/ruby-3.3.0.tar.gz' do
    source 'https://cache.ruby-lang.org/pub/ruby/3.3/ruby-3.3.0.tar.gz'
    action :create
  end

  archive_file '/ruby-3.3.0.tar.gz' do
    destination '/ruby'
  end

  execute './configure' do
    cwd '/ruby/ruby-3.3.0'
  end

  execute 'make' do
    cwd '/ruby/ruby-3.3.0'
  end

  execute 'make install' do
    cwd '/ruby/ruby-3.3.0'
  end
end