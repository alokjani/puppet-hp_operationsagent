# Author    :: Alok Jani (mailto: Alok.Jani@ril.com)
# Copyright :: Copyright (c) 2014 Reliance Jio Infocomm, Ltd
# License   :: Apache 2.0
#
# === Class: hp_operationsagent::install
#
# This private class is meant to be called from `hp_operationsagent`
# It installs the HP Operations Agent
#

class hp_operationsagent::install {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }
  
  case $::osfamily {
    'windows': {
      $executable_7za   = $hp_operationsagent::executable_7za
      $local_archive    = $hp_operationsagent::setup_archive         # full path to zip file containing HPOM Agent
      $extract_location = $hp_operationsagent::archive_extract_to # full path to directory where to extract & install from
      $hpom_mgmt_server = $hp_operationsagent::hpom_mgmt_server
      $hpom_cert_server = $hp_operationsagent::hpom_cert_server

      $hpom_install     = "C:\Windows\System32\cscript.exe oainstall.vbs -i -a -srv ${hpom_mgmt_server} -cert_srv ${hpom_cert_server}"

      file { $extract_location :
        ensure => directory,
      }
      ->
      # Extract the archive containing the NetBackup Client
      exec { 'extract_installer':
        cwd     => "${extract_location}",
        command => "C:\Windows\System32\cmd.exe /C ${executable_7za} x -y ${local_archive} -o${extract_location}",
      }      
      ->
      exec { 'run_installer':
        cwd     => "${extract_location}/OMWINAGNT",
        command => "C:\Windows\System32\cmd.exe /C ${hpom_install}",
        timeout => 600,
      }
      ->
      notify { 'run_installer' : name => 'Installation run completed.' }

    }

    default: {}

  }
}
