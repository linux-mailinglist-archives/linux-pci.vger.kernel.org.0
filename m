Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F9A29E0EE
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 02:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgJ2Bp3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 21:45:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:61002 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729122AbgJ2Bo0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Oct 2020 21:44:26 -0400
IronPort-SDR: nF+YEA6hZMPUus1FhYsTujHvVtx+GA3MnTotUadri4dR6fs2MCtxTjO54+VIAe+VkBn+UbIutm
 JAzR5zEP6wow==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="165774944"
X-IronPort-AV: E=Sophos;i="5.77,428,1596524400"; 
   d="scan'208";a="165774944"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 18:44:26 -0700
IronPort-SDR: d5JzbxCBue7FU8cHPNZG4mDxWfy7rcVWsd15+IxiTB4J90DssZLBz7rdHt9hINqs7qhi7jLgQT
 jVBPVEuG2r8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,428,1596524400"; 
   d="scan'208";a="304281319"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 28 Oct 2020 18:44:26 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 36677580718;
        Wed, 28 Oct 2020 18:44:26 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     lee.jones@linaro.org, david.e.box@linux.intel.com,
        hdegoede@redhat.com, mgross@linux.intel.com, bhelgaas@google.com,
        alexey.budankov@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V9 0/5] Intel Platform Monitoring Technology
Date:   Wed, 28 Oct 2020 18:44:44 -0700
Message-Id: <20201029014449.14955-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Intel Platform Monitoring Technology (PMT) is an architecture for
enumerating and accessing hardware monitoring capabilities on a device.
With customers increasingly asking for hardware telemetry, engineers not
only have to figure out how to measure and collect data, but also how to
deliver it and make it discoverable. The latter may be through some device
specific method requiring device specific tools to collect the data. This
in turn requires customers to manage a suite of different tools in order to
collect the differing assortment of monitoring data on their systems.  Even
when such information can be provided in kernel drivers, they may require
constant maintenance to update register mappings as they change with
firmware updates and new versions of hardware. PMT provides a solution for
discovering and reading telemetry from a device through a hardware agnostic
framework that allows for updates to systems without requiring patches to
the kernel or software tools.

PMT defines several capabilities to support collecting monitoring data from
hardware. All are discoverable as separate instances of the PCIE Designated
Vendor extended capability (DVSEC) with the Intel vendor code. The DVSEC ID
field uniquely identifies the capability. Each DVSEC also provides a BAR
offset to a header that defines capability-specific attributes, including
GUID, feature type, offset and length, as well as configuration settings
where applicable. The GUID uniquely identifies the register space of any
monitor data exposed by the capability. The GUID is associated with an XML
file from the vendor that describes the mapping of the register space along
with properties of the monitor data. This allows vendors to perform
firmware updates that can change the mapping (e.g. add new metrics) without
requiring any changes to drivers or software tools. The new mapping is
confirmed by an updated GUID, read from the hardware, which software uses
with a new XML.

The current capabilities defined by PMT are Telemetry, Watcher, and
Crashlog.  The Telemetry capability provides access to a continuous block
of read only data. The Watcher capability provides access to hardware
sampling and tracing features. Crashlog provides access to device crash
dumps.  While there is some relationship between capabilities (Watcher can
be configured to sample from the Telemetry data set) each exists as stand
alone features with no dependency on any other. The design therefore splits
them into individual, capability specific drivers. MFD is used to create
platform devices for each capability so that they may be managed by their
own driver. The PMT architecture is (for the most part) agnostic to the
type of device it can collect from. Software can determine which devices
support a PMT feature by searching through each device node entry in the
sysfs class folder. It can additionally determine if a particular device
supports a PMT feature by checking for a PMT class folder in the device
folder.

This patch set provides support for the PMT framework, along with support
for Telemetry on Tiger Lake.

Changes from V8:
 	- Rebase on 5.10-rc1
	- Add missing changes in MFD patch from V7 that were accidentally
	  dropped in V8
	- Remove error message when unsupported capability found. Avoids
	  unnecessary noise on some systems.

Changes from V7:
Link: https://lore.kernel.org/lkml/20201001014250.26987-1-david.e.box@linux.intel.com/

	- Refactor to minimize code duplication by putting more setup code 
	  in the common intel_pmt_dev_create(). 
	- Add and use a function pointer to handle capability specific
	  header decoding.
	- Add comment on usage of early_client_pci_ids list and add
	  Alder Lake PCI ID to the list.
	- Remove unneeded check on the count variable in intel_pmt_read().
	- Add missing header functions.
	- Specify module names in Kconfig.
	- Fix spelling errors across patch set.

Changes from V6:
	- Use NULL for OOBMSM driver data instead of an empty struct.
	  Rewrite the code to check for NULL driver_data.
	- Fix spelling and formatting in Kconfig.
	- Use MKDEV(0,0) to prevent unneeded device node from being
	  created.

Changes from V5:
	- Add Alder Lake and the "Out of Band Management Services
	  Module (OOBMSM)" ids to the MFD driver. Transferred to this
	  patch set.
	- Use a single class for all PMT capabilities as suggested by
	  Hans.
	- Add binary attribute for telemetry driver to allow read
	  syscall as suggested by Hans.
	- Use the class file to hold attributes and other common code
	  used by all PMT drivers.
	- Add the crashlog driver to the patch set and add a mutex to
	  protect access to the enable control and trigger files as
	  suggested by Hans.

Changes from V4:
	- Replace MFD with PMT in driver title
	- Fix commit tags in chronological order
	- Fix includes in alphabetical order
	- Use 'raw' string instead of defines for device names
	- Add an error message when returning an error code for
	  unrecognized capability id
	- Use dev_err instead of dev_warn for messages when returning
	  an error
	- Change while loop to call pci_find_next_ext_capability once
	- Add missing continue in while loop
	- Keep PCI platform defines using PCI_DEVICE_DATA magic tied to
	  the pci_device_id table
	- Comment and kernel message cleanup

Changes from V3:
	- Write out full acronym for DVSEC in PCI patch commit message and
	  add 'Designated' to comments
	- remove unused variable caught by kernel test robot <lkp@intel.com>
	- Add required Co-developed-by signoffs, noted by Andy
	- Allow access using new CAP_PERFMON capability as suggested by
	  Alexey Bundankov
	- Fix spacing in Kconfig, noted by Randy
	- Other style changes and fixups suggested by Andy

Changes from V2:
	- In order to handle certain HW bugs from the telemetry capability
	  driver, create a single platform device per capability instead of
	  a device per entry. Add the entry data as device resources and
	  let the capability driver manage them as a set allowing for
	  cleaner HW bug resolution.
	- Handle discovery table offset bug in intel_pmt.c
	- Handle overlapping regions in intel_pmt_telemetry.c
	- Add description of sysfs class to testing ABI.
	- Don't check size and count until confirming support for the PMT
	  capability to avoid bailing out when we need to skip it.
	- Remove unneeded header file. Move code to the intel_pmt.c, the
	  only place where it's needed.
	- Remove now unused platform data.
	- Add missing header files types.h, bits.h.
	- Rename file name and build options from telem to telemetry.
	- Code cleanup suggested by Andy S.
	- x86 mailing list added.

Changes from V1:
	- In the telemetry driver, set the device in device_create() to
	  the parent PCI device (the monitoring device) for clear
	  association in sysfs. Was set before to the platform device
	  created by the PCI parent.
	- Move telem struct into driver and delete unneeded header file.
	- Start telem device numbering from 0 instead of 1. 1 was used
	  due to anticipated changes, no longer needed.
	- Use helper macros suggested by Andy S.
	- Rename class to pmt_telemetry, spelling out full name
	- Move monitor device name defines to common header
	- Coding style, spelling, and Makefile/MAINTAINERS ordering fixes

Alexander Duyck (3):
  platform/x86: Intel PMT class driver
  platform/x86: Intel PMT Telemetry capability driver
  platform/x86: Intel PMT Crashlog capability driver

David E. Box (2):
  PCI: Add defines for Designated Vendor-Specific Extended Capability
  mfd: Intel Platform Monitoring Technology support

 .../ABI/testing/sysfs-class-intel_pmt         | 119 +++++++
 MAINTAINERS                                   |   6 +
 drivers/mfd/Kconfig                           |  10 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/intel_pmt.c                       | 223 ++++++++++++
 drivers/platform/x86/Kconfig                  |  34 ++
 drivers/platform/x86/Makefile                 |   3 +
 drivers/platform/x86/intel_pmt_class.c        | 297 ++++++++++++++++
 drivers/platform/x86/intel_pmt_class.h        |  52 +++
 drivers/platform/x86/intel_pmt_crashlog.c     | 328 ++++++++++++++++++
 drivers/platform/x86/intel_pmt_telemetry.c    | 160 +++++++++
 include/uapi/linux/pci_regs.h                 |   5 +
 12 files changed, 1238 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-intel_pmt
 create mode 100644 drivers/mfd/intel_pmt.c
 create mode 100644 drivers/platform/x86/intel_pmt_class.c
 create mode 100644 drivers/platform/x86/intel_pmt_class.h
 create mode 100644 drivers/platform/x86/intel_pmt_crashlog.c
 create mode 100644 drivers/platform/x86/intel_pmt_telemetry.c

-- 
2.20.1

