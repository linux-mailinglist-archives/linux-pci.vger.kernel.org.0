Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8594579DD
	for <lists+linux-pci@lfdr.de>; Sat, 20 Nov 2021 01:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhKTAGG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 19:06:06 -0500
Received: from mga12.intel.com ([192.55.52.136]:5719 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229523AbhKTAGF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 19:06:05 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="214542389"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="214542389"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:02:55 -0800
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="496088325"
Received: from jfaistl-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.139.58])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:02:54 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 00/23] Add drivers for CXL ports and mem devices
Date:   Fri, 19 Nov 2021 16:02:27 -0800
Message-Id: <20211120000250.1663391-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is the first set of patches from the RFC [1] for region creation. The
patches enable port enumeration for endpoint devices, and enumeration of decoder
resources for ports. In the RFC [1], I felt it necessary to post the consumer of
this work, the region driver, so that it was clear why these patches were
necessary. Because the region patches patches are less baked, and received no
review in the RFC, they are excluded here. If you find yourself unclear about
why these patches are interesting, go look at the RFC [1].

Each patch contains the list of changes from RFCv2. IMHO the following are the
high level most important changes:
1. Rework cxl_pci to fix mailbox handling and allow for wait media ready.
2. DVSEC range information is passed from cxl_pci and checked

linux-pci is on the Cc since CXL lives in a parallel universe to PCI and some
PCI mechanisms are reused here. Feedback from experts in that domain is very
welcome.

What was requested and not changed:
1. Dropping global list of root ports.
2. Improving find_parent_cxl_port()

---

Summary
=======

Two new drivers are introduced to support Compute Express Link 2.0 [2] HDM
decoder enumeration. While the existing cxl_acpi and cxl_pci drivers already
create some of the necessary devices, they did not do full enumeration of
decoders, and they did not do port enumeration for switches. Additionally, CXL
2.0 Root Port component registers are now handled as well.

cxl_port
========

The cxl_port driver is implemented within the cxl_port module. While loading of
this module is optional, the other new drivers depend, and cxl_acpi depend on it
for complete enumeration. The port driver is responsible for all activities
around HDM decoder enumeration and programming. Introduced earlier, the concept
of a port is an abstraction over CXL components with an upstream port, every
host bridge, switch, and endpoint.

cxl_mem
=======

The cxl_mem driver's main job is to walk up the hierarchy to make the
determination if it is CXL.mem routed, meaning, all components above it in the
hierarchy are participating in the CXL.mem protocol. It is implemented within
the cxl_mem module. As the host bridge ports are added by a platform specific
driver, such as cxl_acpi, the scope of the mem driver can be reduced to scan for
switches and ask cxl_core to work on enumerating them. With this done, the
determination as to whether a device is CXL.mem routed can be done simply by
checking if the struct device has a driver bound to it.

Results
=======

Running these patches should yield new devices and new drivers under
/sys/bus/cxl/devices and /sys/bus/cxl/drivers. For example, in a standard QEMU
run, using run_qemu [3]

/sys/bus/cxl/devices (new):
# The host bridge CHBS decoder
lrwxrwxrwx 1 root root 0 Nov 19 15:23 decoder1.0 -> ../../../devices/platform/ACPI0017:00/root0/port1/decoder1.0
# mem0's decoder
lrwxrwxrwx 1 root root 0 Nov 19 15:23 decoder2.0 -> ../../../devices/platform/ACPI0017:00/root0/port1/port2/decoder2.0
# mem1's decoder
lrwxrwxrwx 1 root root 0 Nov 19 15:23 decoder3.0 -> ../../../devices/platform/ACPI0017:00/root0/port1/port3/decoder3.0
# mem0's port
lrwxrwxrwx 1 root root 0 Nov 19 15:23 port2 -> ../../../devices/platform/ACPI0017:00/root0/port1/port2
# mem1's port
lrwxrwxrwx 1 root root 0 Nov 19 15:23 port3 -> ../../../devices/platform/ACPI0017:00/root0/port1/port3

/sys/bus/cxl/drivers:
drwxr-xr-x 2 root root 0 Nov 19 15:23 cxl_mem
drwxr-xr-x 2 root root 0 Nov 19 15:23 cxl_port

---

[1]: https://lore.kernel.org/linux-cxl/20211022183709.1199701-1-ben.widawsky@intel.com/T/#t
[2]: https://www.computeexpresslink.org/download-the-specification
[3]: https://github.com/pmem/run_qemu/

Ben Widawsky (23):
  cxl: Rename CXL_MEM to CXL_PCI
  cxl: Flesh out register names
  cxl/pci: Extract device status check
  cxl/pci: Implement Interface Ready Timeout
  cxl/pci: Don't poll doorbell for mailbox access
  cxl/pci: Don't check media status for mbox access
  cxl/pci: Add new DVSEC definitions
  cxl/acpi: Map component registers for Root Ports
  cxl: Introduce module_cxl_driver
  cxl/core: Convert decoder range to resource
  cxl/core: Document and tighten up decoder APIs
  cxl: Introduce endpoint decoders
  cxl/core: Move target population locking to caller
  cxl: Introduce topology host registration
  cxl/core: Store global list of root ports
  cxl/pci: Cache device DVSEC offset
  cxl: Cache and pass DVSEC ranges
  cxl/pci: Implement wait for media active
  cxl/pci: Store component register base in cxlds
  cxl/port: Introduce a port driver
  cxl: Unify port enumeration for decoders
  cxl/mem: Introduce cxl_mem driver
  cxl/mem: Disable switch hierarchies for now

 .../driver-api/cxl/memory-devices.rst         |  14 +
 drivers/cxl/Kconfig                           |  54 ++-
 drivers/cxl/Makefile                          |   6 +-
 drivers/cxl/acpi.c                            | 103 ++--
 drivers/cxl/core/Makefile                     |   1 +
 drivers/cxl/core/bus.c                        | 439 ++++++++++++++++--
 drivers/cxl/core/core.h                       |   3 +
 drivers/cxl/core/memdev.c                     |   2 +-
 drivers/cxl/core/pci.c                        | 119 +++++
 drivers/cxl/core/regs.c                       |  60 ++-
 drivers/cxl/cxl.h                             |  73 ++-
 drivers/cxl/cxlmem.h                          |  27 ++
 drivers/cxl/mem.c                             | 197 ++++++++
 drivers/cxl/pci.c                             | 341 ++++++++++----
 drivers/cxl/pci.h                             |  53 ++-
 drivers/cxl/port.c                            | 383 +++++++++++++++
 tools/testing/cxl/Kbuild                      |   1 +
 tools/testing/cxl/mock_acpi.c                 |   4 +-
 18 files changed, 1666 insertions(+), 214 deletions(-)
 create mode 100644 drivers/cxl/core/pci.c
 create mode 100644 drivers/cxl/mem.c
 create mode 100644 drivers/cxl/port.c


base-commit: 53989fad1286e652ea3655ae3367ba698da8d2ff
-- 
2.34.0

