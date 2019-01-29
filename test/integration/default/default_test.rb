# # encoding: utf-8

# Inspec test for recipe snoopy-cookbook::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

unless os.windows?
  describe group('snoopy') do
    it { should exist }
  end

  describe user('snoopy')  do
    it { should exist }
    its('groups') { should eq ['snoopy'] }
  end
end

describe directory('/opt/snoopy') do
  its('owner') { should eq 'snoopy' }
  its('group') { should eq 'snoopy' }
  its('mode') { should cmp '0755' }
end

describe file('/opt/snoopy/snoopy-install.sh') do
  its('owner') { should eq 'snoopy' }
  its('group') { should eq 'snoopy' }
  its('mode') { should cmp '0755' }
end

describe file('/usr/local/lib/libsnoopy.so') do
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('mode') { should cmp '0755' }
end

describe file('/etc/snoopy.ini') do
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('mode') { should cmp '0644' }
end

describe file('/var/log/auth.log') do
  it { should exist }
end
