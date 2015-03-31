Puppet::Type.newtype(:consul_kv_lock) do

  desc <<-'EOD'
  Aquire a lock for the specified session name
  EOD

  newparam(:name, :namevar => true) do
    desc 'Consul Key name'
  end

  newparam(:url) do
    desc 'Consul url to use'
    defaultto 'http://localhost:8500/v1/kv'
  end

  newparam(:session_name) do
    desc 'name of the session to release'
  end

  newparam(:tries) do
    desc 'How many times to retry'
    defaultto 40
    munge do |v|
      Integer(v)
    end
  end

  newparam(:try_sleep) do
    desc 'how long to wait between retries'
    defaultto 3
    munge do |v|
      Integer(v)
    end
  end

  def refresh
    provider.acquire_lock
  end

  autorequire(:consul_session) do
    self[:session_name]
  end

end
