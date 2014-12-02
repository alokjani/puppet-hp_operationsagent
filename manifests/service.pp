# Author    :: Alok Jani (mailto: Alok.Jani@ril.com)
# Copyright :: Copyright (c) 2014 Reliance Jio Infocomm, Ltd
# License   :: Apache 2.0
#
# === Class: hp_operationsagent::service
#
# This private class is meant to be called from `hp_operationsagent`.
# It maintains the service state.
#

class hp_operationsagent::service {
  case $hp_operationsagent::ensure {
    'present': {
      service { 'HPOvTrcSvc': ensure => running, enable => manual, } ->
      service { 'OvCtrl':     ensure => running, enable => manual, }
    }

    'disable': {
      service { 'HPOvTrcSvc': ensure => stopped, enable => manual, } -> 
      service { 'OvCtrl':     ensure => stopped, enable => manual, } 
    }

    default : {}

  }
}
