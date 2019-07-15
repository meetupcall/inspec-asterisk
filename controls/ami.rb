# Check manager.conf for permit lines
# Check passwords here

control 'ami-01' do
  impact 0.7
  title "Manager sections should have permit and deny lines"
  desc 'You should tell Asterisk where AMI connections are allowed from'
  sections = parse_config_file('/etc/asterisk/manager.conf').params.keys
  sections.each do |section|
    next if section == 'general'
    describe parse_config_file('/etc/asterisk/manager.conf') do
      its(section) { should include('deny') }
      its(section) { should include('permit') }
    end
  end
end

# TODO:
# ami-01 Check the deny line excludes all addresses. Permits then explicitly allow CIDR blocks.
