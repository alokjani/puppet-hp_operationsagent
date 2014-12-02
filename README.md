# hp_operationsagent

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with hp_operationsagent](#setup)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - module internals](#reference)
6. [Limitations - OS compatibility, etc.](#limitations)
7. [Contributors - Those with commits](#contributors)


## Overview

The `hp_operationsagent` module allows you to manage the HP Operations Agent install on Windows.


## Module Description

The `hp_operationsagent` module installs the HP OA from a local copy of the archived installer.
Below is the sample list of contents of the packaged archive : 

```bash
# unzip -l HPOM_Agent/OMWINAGNT.zip 
Archive:  HPOM_Agent/OMWINAGNT.zip
  Length      Date    Time    Name
---------  ---------- -----   ----
      123  2013-06-06 15:58   OMWINAGNT/default_config
       66  2013-11-23 19:03   OMWINAGNT/hpom-install.bat
      246  2014-11-10 16:21   OMWINAGNT/HPOM-Install-command.bat.txt
        0  2014-11-10 16:18   OMWINAGNT/misc/
     2883  2013-06-06 15:58   OMWINAGNT/oainstall.sh
    15436  2013-06-06 15:58   OMWINAGNT/oainstall.vbs
        0  2014-11-10 16:18   OMWINAGNT/opensource/
        0  2014-11-10 16:18   OMWINAGNT/packages/
        0  2014-11-10 16:19   OMWINAGNT/paperdocs/
        0  2014-11-10 16:19   OMWINAGNT/patches/
        0  2014-11-10 16:20   OMWINAGNT/ReleaseNotes/
        0  2014-11-10 16:20   OMWINAGNT/scripts/
...
```

Configuration is done by seeding the `cscript` based installer `OMWINAGNT/oainstall.vbs`.

## Setup

This module has no external dependencies. It consists of a single class. Parameters need to be specified as such :

```puppet
  class { hp_operationsagent :
    ensure => 'present',
    setup_archive => 'C:\installers\HPOM_Agent\OMWINAGNT.zip',
    archive_extract_to => 'C:\temp\\',
    executable_7za => 'C:/installers/7za.exe',
    hpom_mgmt_server => 'hpom.prod.example.lan',
    hpom_cert_server => 'hpom.prod.example.lan',
  }
```

## Usage

### Classes and Defined Types

#### Class: `hp_operationsagent`
This module manages the install/uninstall of the HP Operations Agent for Windows.

**Parameters within `hp_operationsagent`:**
####`ensure`
Possible options are:
* `present` activates the install and ensures the HP Operations Agent services are running
* `absent` will remove the HP Operations Agent
* `disable` will switch off OA services on the host

####`setup_archive`
The complete path to the Zip Archive containing the HP Operations Agent
See README.md for more details

####`archive_extract_to
The directory path into which to extract the HP Operations Agent Zip Archive

####`executable_7za`
Full path to 7zip CLI binary (7za.exe)

####`hpom_mgmt_server`
The IP of the central HP Operations Manager server 

####`hpom_cert_server`
The IP of the certificate server used by HPOM. It is usually the same as the HPOM Management Server.


## Reference

### Classes

#### Public Classes
* [`hp_operationsagent`] : Installs the HP Operations package. Introduces fact `hp_operationsagent` on the system that returns current version if installed or `absent` is not present.

#### Private Classes
* [`hp_operationsagent::install`] : Manages the installation of HP OA.
* [`hp_operationsagent::service`] : Ensures the required HP Operations Agent Service state is maintained.

## Limitations

This module was tested with:

* HP Operations Agent 11.11.025
* Windows Server 2012 x64 Standard
* Puppet 3.7.2 (64-bit OSS version)

## Contributors

* https://github.com/JioCloud/puppet-hp_operationsagent/graphs/contributors

