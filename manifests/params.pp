# Author    :: Alok Jani (mailto: Alok.Jani@ril.com)
# Copyright :: Copyright (c) 2014 Reliance Jio Infocomm, Ltd
# License   :: Apache 2.0
#
# === Class: hp_operationsagent::params
#
# This private class is meant to be called from `hp_operationsagent`
#

class hp_operationsagent::params {
  $ensure = 'present'
  $setup_archive = 'C:\installers\HPOM_Agent\OMWINAGNT.zip'
  $archive_extract_to = 'C:/temp/'
  $executable_7za = 'C:/installers/7za.exe'
  $hpom_mgmt_server = '127.0.0.1'
  $hpom_cert_server = '127.0.0.1'
} 
