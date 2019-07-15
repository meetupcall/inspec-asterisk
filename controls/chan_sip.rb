# encoding: utf-8
# copyright: 2018, The Authors

title 'chan_sip Configuration'

only_if do
  command("asterisk -rx 'module show like chan_sip.so'").stdout.include?('1 modules loaded')
end

sip_settings = command("asterisk -rx 'sip show settings'").stdout
sip_users_output = command("asterisk -rx 'sip show users'").stdout.split("\n").slice(1..-2)
sip_users = []

sip_users_output.each do |line|
  user = Hash.new
  user['username'] = line.unpack('A27A17A17A17A5A10')[0]
  user['secret'] = line.unpack('A27A17A17A17A5A10')[1]
  sip_users << user
end

control 'chan_sip-01' do
  impact 1.0
  title 'alwaysauthreject should bet set to "yes"'
  desc 'Setting this to "yes" will reject bad authentication requests on valid usernames with the same rejection information as with invalid usernames, denying remote attackers the ability to detect existing extensions with brute-force guessing attacks.'
  describe parse_config(sip_settings) do
    its('content') { should include('Always auth rejects:    Yes') }
  end
end

control 'chan_sip-02' do
  impact 1.0
  title 'allowguest should bet set to "no"'
  desc 'Reject guest calls'
  describe parse_config(sip_settings) do
    its('content') { should include('Allow unknown access:   No') }
  end
end

control 'chan_sip-03' do
  impact 1.0
  title "sip users' passwords should not be the same as their username"
  desc 'You should use strong passwords for sip authentication'
  sip_users.each do |user|
    next if user['secret'].empty?
    describe "User #{user['username']}'s password", :sensitive do # Doesn't take
      # a genius to realise that when this control fails the password is the username
      # so why :sensitive?
      it { should_not match(user['secret']) }
    end
  end
end

control 'chan_sip-04' do
  impact 0.7
  title "SIP Peers should have permit and deny lines"
  desc 'You should tell Asterisk where traffic is allowed to come from for a peer'
  sections = parse_config_file('/etc/asterisk/sip.conf').params.keys
  sections.each do |section|
    next if section == 'general'
    describe parse_config_file('/etc/asterisk/sip.conf') do
      its(section) { should include('deny') }
      its(section) { should include('permit') }
    end
  end
end

#TODO:
# Use strong passwords for SIP entities

# Config file paths are configurable and can include other files! Would be nice
# if Asterisk output an entire parsed config
