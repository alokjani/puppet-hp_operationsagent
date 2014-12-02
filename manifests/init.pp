# Author    :: Alok Jani (mailto: Alok.Jani@ril.com)
# Copyright :: Copyright (c) 2014 Reliance Jio Infocomm, Ltd
# License   :: Apache 2.0
#
# == Class: hp_operationsagent
#
# This module manages the install/uninstall of HP Operations Agent on Windows.
# This agent helps with the Event, Incident, and Problem Management processes of ITIL's "Service Operations" phase.
#
# === Parameters
#
# [*ensure*]
#   `present` activates the install and ensures the HP Operations Agent services are running
#   `absent` will remove the HP Operations Agent
#   `disable` will switch off OA services on the host
#
# [*setup_archive*]
#   The complete path to the Zip Archive containing the HP Operations Agent
#   See README.md for more details
#
# [*archive_extract_to*]
#   The directory path into which to extract the HP Operations Agent Zip Archive
#
# [*executable_7za*]
#   Full path to 7zip CLI binary (7za.exe)
#
# [*hpom_mgmt_server*]
#   The IP of the central HP Operations Manager server 
#
# [*hpom_cert_server*]
#   The IP of the certificate server used by HPOM. It is usually the same as the HPOM Management Server.
#
# === Examples
#
#  class { 'hp_operationsagent' :
#    ensure             => 'present',
#    setup_archive      => 'C:\installers\HPOM_Agent\OMWINAGNT.zip',
#    archive_extract_to => 'C:\temp\\',
#    executable_7za     => 'C:/installers/7za.exe',
#    hpom_mgmt_server   => 'hpom.prod.example.lan',
#    hpom_cert_server   => 'hpom.prod.example.lan',
#  }
#
#

class hp_operationsagent (
  $ensure             = $hp_operationsagent::params::ensure, 
  $setup_archive      = $hp_operationsagent::params::setup_archive, 
  $archive_extract_to = $hp_operationsagent::params::archive_extract_to,
  $executable_7za     = $hp_operationsagent::params::executable_7za, 
  $hpom_mgmt_server   = $hp_operationsagent::params::hpom_mgmt_server,
  $hpom_cert_server   = $hp_operationsagent::params::hpom_cert_server,
) inherits hp_operationsagent::params {
  
  if $::operatingsystem != 'windows' {
    fail ('This OS is not tested yet !')
  }

  case $ensure {
    /(present)/: {
      if $::hp_operationsagent != 'absent' {
        notify { 'HPOMAGENT': name => "HP Operations Agent version [$::hp_operationsagent] found." }
        class { 'hp_operationsagent::service' : }
      } else {
        notify { 'HPOMAGENT': name => "HP Operations Agent missing." }
        ->
        class { 'hp_operationsagent::install' : }
      }
    }

    /(absent)/: {
      package { 'HP Operations-agent':  ensure  => absent,  }
    }

    /(disable)/: {
      class { 'hp_operationsagent::service' : }
    }

    default: {
      fail ('ensure parameter must be `present`, `absent` or `disable`')
    }
  }
}

