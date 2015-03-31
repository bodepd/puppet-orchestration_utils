require 'puppet/provider/blocker'
Puppet::Type.type(:consul_kv_release).provide(
  :default,
  :parent => Puppet::Type.type(:consul_kv).provider(:default)
) do

  # should not fail if we current have the lock
  def release_lock
    result = !(createKV(resource[:name], 'locked',
      {
        :release => resource[:session_name],
      }
    ) == 'false')
  end

end
