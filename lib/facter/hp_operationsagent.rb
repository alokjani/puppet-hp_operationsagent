require 'facter'
pkg = Puppet::Type.type(:package).new(:name => "HP Operations-agent")
v = pkg.retrieve[pkg.property(:ensure)].to_s
Facter.add(:hp_operationsagent) do
	confine :osfamily => :windows
  setcode do
		v.chomp 
  end
end
