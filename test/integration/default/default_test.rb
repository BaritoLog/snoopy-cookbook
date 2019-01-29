# # encoding: utf-8

# Inspec test for recipe snoopy-cookbook::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

unless os.windows?
  # This is an example test, replace with your own test.
  describe user('root'), :skip do
    it { should exist }
  end

  describe directory('/opt/snoopy') do
    its('mode') { should cmp '0755' }
    its('owner') { should eq 'snoopy' }
    its('group') { should eq 'snoopy' }
  end

  describe file('/opt/snoopy/snoopy-install.sh') do
    its('mode') { should cmp '0755' }
    its('owner') { should eq 'snoopy' }
    its('group') { should eq 'snoopy' }
  end

  describe directory('/var/log/snoopy') do
    its('mode') { should cmp '0755' }
    its('owner') { should eq 'snoopy' }
    its('group') { should eq 'snoopy' }
  end
end
