# encoding: utf-8
# copyright: 2018, The Authors

title 'System Controls'

control 'asterisk-01' do
  impact 1
  title 'Asterisk Process Owner'
  desc 'Asterisk should not be running as root'
  # only if asterisk is running
  describe processes('asterisk') do
    its('users') { should_not eq ['root'] }
  end
end
