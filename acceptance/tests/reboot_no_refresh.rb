test_name "Windows Reboot Module - No Refresh"
extend Puppet::Acceptance::Reboot

#Shutdown abort command.
shutdown_abort = "cmd /c shutdown /a"

reboot_manifest = <<-MANIFEST
reboot { 'now':
}
MANIFEST

confine :to, :platform => 'windows'

agents.each do |agent|
  step "Attempt to Reboot Computer without Refresh"

  #Apply the manifest.
  on agent, puppet('apply', '--debug'), :stdin => reboot_manifest

  #Verify that a shutdown has NOT been initiated because reboot
  #was not refreshed.
  ensure_shutdown_not_scheduled(agent)
end
