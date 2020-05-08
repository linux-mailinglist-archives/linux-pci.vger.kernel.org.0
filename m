Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8911CA0A7
	for <lists+linux-pci@lfdr.de>; Fri,  8 May 2020 04:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgEHCSx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 22:18:53 -0400
Received: from mga09.intel.com ([134.134.136.24]:50259 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbgEHCSu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 May 2020 22:18:50 -0400
IronPort-SDR: 8uERcg6LfnivA3pYdn4FZmOwlggl5H3Zn4PjNMfIZNdV036UVnDHQCquyeruqppBpROJxwGLdO
 AMVVQUUb3uaw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 19:18:49 -0700
IronPort-SDR: Cy7+22S/SEF2dF3qJxa+cWo2vPpPwemgW6iUxbNiPXmrlJaQT8kYgLCqj6rJB1xm4FCwdKDYMU
 MgUENEfMu7uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,366,1583222400"; 
   d="scan'208";a="462361497"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 07 May 2020 19:18:49 -0700
Received: from debox1-hc.jf.intel.com (debox1-hc.jf.intel.com [10.54.75.159])
        by linux.intel.com (Postfix) with ESMTP id 07097580378;
        Thu,  7 May 2020 19:18:49 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     bhelgaas@google.com, andy@infradead.org, lee.jones@linaro.org,
        alexander.h.duyck@linux.intel.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 0/3] Intel Platform Monitoring Technology
Date:   Thu,  7 May 2020 19:18:41 -0700
Message-Id: <20200508021844.6911-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200505013206.11223-1-david.e.box@linux.intel.com>
References: <20200505013206.11223-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
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
type of device it can collect from. Devices nodes are consequently generic
in naming, e.g. /dev/telem<n> and /dev/smplr<n>. Each capability driver
creates a class to manage the list of devices supporting it.  Software can
determine which devices support a PMT feature by searching through each
device node entry in the sysfs class folder. It can additionally determine
if a particular device supports a PMT feature by checking for a PMT class
folder in the device folder.

This patch set provides support for the PMT framework, along with support
for Telemetry on Tiger Lake.

Changes from V1:

	- In the telemetry driver, set the device in device_create() to
	  the parent pci device (the monitoring device) for clear
	  association in sysfs. Was set before to the platform device
	  created by the pci parent.
	- Move telem struct into driver and delete unneeded header file.
	- Start telem device numbering from 0 instead of 1. 1 was used
	  due to anticipated changes, no longer needed.
	- Use helper macros suggested by Andy S.
	- Rename class to pmt_telemetry, spelling out full name
	- Move monitor device name defines to common header
	- Coding style, spelling, and Makefile/MAINTAINERS ordering fixes

David E. Box (3):
  PCI: Add #defines for Designated Vendor-Specific Capability
  mfd: Intel Platform Monitoring Technology support
  platform/x86: Intel PMT Telemetry capability driver

 MAINTAINERS                            |   6 +
 drivers/mfd/Kconfig                    |  10 +
 drivers/mfd/Makefile                   |   1 +
 drivers/mfd/intel_pmt.c                | 170 ++++++++++++
 drivers/platform/x86/Kconfig           |  10 +
 drivers/platform/x86/Makefile          |   1 +
 drivers/platform/x86/intel_pmt_telem.c | 362 +++++++++++++++++++++++++
 include/linux/intel-dvsec.h            |  48 ++++
 include/uapi/linux/pci_regs.h          |   5 +
 9 files changed, 613 insertions(+)
 create mode 100644 drivers/mfd/intel_pmt.c
 create mode 100644 drivers/platform/x86/intel_pmt_telem.c
 create mode 100644 include/linux/intel-dvsec.h

-- 
2.20.1

