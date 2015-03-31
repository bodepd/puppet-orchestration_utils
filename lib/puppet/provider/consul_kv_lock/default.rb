require 'puppet/provider/blocker'
Puppet::Type.type(:consul_kv_lock).provide(
  :default,
  :parent => Puppet::Type.type(:consul_kv).provider(:default)
) do

  # should not fail if we current have the lock
  def acquire_lock(tries = resource[:tries], try_sleep = resource[:try_sleep])
    Puppet::Provider::Blocker.new.block_until_ready(tries, try_sleep) do
      return true if !(createKV(resource[:name], 'locked',
        {
          :acquire => resource[:session_name],
        }
      ) == 'false')
    end
    fail("Could not acquire lock")
  end

end
