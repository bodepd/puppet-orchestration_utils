Puppet::Type.newtype(:consul_kv_release) do

  desc <<-'EOD'
  Release a lock help by the specified session name. This resource only
  suports a refresh-mode and does not perform regular resource management.
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

  newparam(:fail_if_not_held) do
    desc 'fail if the expected lock is not held'
  end

  def refresh
    provider.release_lock
  end

end
