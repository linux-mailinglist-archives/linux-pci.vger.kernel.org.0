Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5702D37D0
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 01:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731777AbgLIAZK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 19:25:10 -0500
Received: from mga09.intel.com ([134.134.136.24]:16954 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730243AbgLIAZD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Dec 2020 19:25:03 -0500
IronPort-SDR: wXW1HU6WuvQHZJ6QGMSGDkdDvGDEj8sjyC6fLi3n9BS3L2+RAA4bWG5dC0XSI/cn49G7eQOUHW
 d6lJU0zIQ3DQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="174142057"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="174142057"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 16:24:20 -0800
IronPort-SDR: CLL/+IZ9KLow3OsQMundsaxJzvewW/UpLXBEZFitm/o+X1wTZ4kKGhf2/iaHxLnJ1LhtrvXzms
 bNVAA4a6QBOw==
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="407838443"
Received: from mlubyani-mobl2.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.137.9])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 16:24:20 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH v2 00/14] CXL 2.0 Support
Date:   Tue,  8 Dec 2020 16:24:04 -0800
Message-Id: <20201209002418.1976362-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes since v1 [1]

A few additions have been made:
 - IOCTL (UAPI) interface has been added with commands
 - Kernel docs have been created
 - A new debug macro is introduced and sprinkled throughout.

A deletion was made:
 - Removal of the non-standard _OSC UUID.

The detailed list of fixes is:
 - fix cxl_register() no previous prototype warning (0day robot)
 - s/REGLOG/REGLOC/ (Ben)
 - Wait for doorbell on cxl_mem_mbox_get() and add comment on why (Ben)
 - make "type-3" a proper adjective, add spec references, also did the same for
   the Kconfig (Bjorn)
 - align some defines (Bjorn)
 - s/bar/BAR (Bjorn)
 - rename cxl_bus_prepared() to cxl_bus_acquire() (Bjorn)
 - move definition of struct cxl_mem to "cxl/mem: Map memory device registers" (Bjorn)
 - use consistent hex/decimal (Bjorn)
 - use consistent upper/lower hex values (Bjorn)
 - get rid of READ_ONCE (Bjorn)
 - add offsets to debug messages (Bjorn)
 - cleanup SPDX comment style (Bjorn, Christoph)
 - change errors returned by case (Bjorn, Dan)
 - 80 character violation cleanups (Christoph)
 - cleanup CXL_BUS_PROVIDER dependencies (Christoph, Randy)
 - remove "raw" from mmio functions (Dan)
 - rename PCI_DVSEC_VENDOR_CXL to add _ID (Jonathan)
 - combine introduction of mbox infrastruct and cxl_mem_identify() (Jonathan)
 - add ABI documentation for sysfs attributes (Jonathan)
 - document scope of cxl_memdev_lock (Jonathan)
 - rework cxl_register() to have devm semantics (reaction to comments about
   cxl_mem_remove() and cxl_mem_add_memdev() semantics) (Jonathan)
 - fix cxl_mem_exit() ordering (Jonathan)
 - use GENMASK/GET_FIELD (Jonathan)
 - fix and add comments for cap ids (Jonathan)
 - use _OFFSET postfix in definitions (Jonathan)
 - save pci_set_drvdata for later (Jonathan)

[1]: https://lore.kernel.org/linux-cxl/20201111054356.793390-1-ben.widawsky@intel.com/

---

Introduce support for “type-3” memory devices defined in the recently released
Compute Express Link (CXL) 2.0 specification[2]. Specifically, these are the
memory devices defined by section 8.2.8.5 of the CXL 2.0 spec. A reference
implementation emulating these devices has been submitted to the QEMU mailing
list and is available on gitlab [3]. “Type-3” is a CXL device that acts as a
memory expander for RAM or PMEM.  It might be interleaved with other CXL devices
in a given physical address range.

These changes allow for foundational enumeration of CXL 2.0 memory devices as
well as basic userspace interaction. The functionality present is:
- Initial driver bring-up
- Device enumeration and an initial sysfs representation
- Submit a basic firmware command via ‘mailbox’ to an emulated memory device
  with non-volatile capacity.
- Provide an interface to send "raw" commands to the hardware.

Some of the functionality that is still missing includes:
- Memory interleaving at the host bridge, root port, or switch level
- CXL 1.1 Root Complex Integrated Endpoint Support
- CXL 2.0 Hot plug support
- A bevy of supported device commands

In addition to the core functionality of discovering the spec defined registers
and resources, introduce a CXL device model that will be the foundation for
translating CXL capabilities into existing Linux infrastructure for Persistent
Memory and other memory devices. For now, this only includes support for the
management command mailbox that type-3 devices surface. These control devices
fill the role of “DIMMs” / nmemX memory-devices in LIBNVDIMM terms.

Now, while implementing the driver some feedback for the specification was
generated to cover perceived gaps and address conflicts. The feedback is
presented as a reference implementation in the driver and QEMU emulation.
Specifically the following concepts are original to the Linux implementation and
feedback / collaboration is requested to develop these into specification
proposals:
1. Top level ACPI object (ACPI0017)
2. HW imposed address space and interleave constraints

ACPI0017
--------
Introduce a new ACPI namespace device with an _HID of ACPI0017. The purpose of
this object is twofold, support a legacy OS with a set of out-of-tree CXL
modules, and establish an attach point for a driver that knows about
interleaving. Both of these boil down to the same point, to centralize Operating
System support for resources described by the CXL Early Discovery Table (CEDT).

The legacy OS problem stems from the spec's description of a host bridge,
ACPI0016 is denoted as the _HID for host bridges, with a _CID of PNP0A08. In a
CXL unaware version of Linux, the core ACPI subsystem will bind a driver to
PNP0A08 and preclude a CXL-aware driver from binding to ACPI0016. An ACPI0017
device allows a standalone CXL-aware driver to register for handling /
coordinating CEDT and CXL-specific _OSC control.

Similarly when managing interleaving there needs to be some management layer
above the ACPI0016 device that is capable of assembling leaf nodes into
interleave sets. As is the case with ACPI0012 that does this central
coordination for NFIT defined resources, ACPI0017 does the same for CEDT
described resources.

Memory Windows
-------
For CXL.mem capable platforms, there is a need for a mechanism for platform
firmware to make the Operating System aware of any restrictions that hardware
might have in address space. For example, in a system with 4 host bridges all
participating in an interleave set, the firmware needs to provide some
description of this. That information is missing from the CXL 2.0 spec as of
today and it also is not implemented in the driver. A variety of ACPI based
mechanisms, for example _CRS fields on the ACPI0017 device, were considered.

Next steps after this basic foundation is expanded command support and LIBNVDIMM
integration. This is the initial “release early / release often” version of the
Linux CXL enabling.

[2]: https://www.computeexpresslink.org/
[3]: https://gitlab.com/bwidawsk/qemu/-/tree/cxl-2.0v2


Ben Widawsky (10):
  docs: cxl: Add basic documentation
  cxl/mem: Map memory device registers
  cxl/mem: Find device capabilities
  cxl/mem: Implement polled mode mailbox
  cxl/mem: Add basic IOCTL interface
  cxl/mem: Add send command
  cxl/mem: Add a "RAW" send command
  cxl: Add basic debugging
  MAINTAINERS: Add maintainers of the CXL driver
  WIP/cxl/mem: Add get firmware for testing

Dan Williams (2):
  cxl/mem: Introduce a driver for CXL-2.0-Type-3 endpoints
  cxl/mem: Register CXL memX devices

Vishal Verma (2):
  cxl/acpi: Add an acpi_cxl module for the CXL interconnect
  cxl/acpi: add OSC support

 Documentation/ABI/testing/sysfs-bus-cxl |   26 +
 Documentation/cxl/index.rst             |   12 +
 Documentation/cxl/memory-devices.rst    |   51 ++
 Documentation/index.rst                 |    1 +
 MAINTAINERS                             |   10 +
 drivers/Kconfig                         |    1 +
 drivers/Makefile                        |    1 +
 drivers/cxl/Kconfig                     |   58 ++
 drivers/cxl/Makefile                    |    9 +
 drivers/cxl/acpi.c                      |  352 ++++++++
 drivers/cxl/acpi.h                      |   35 +
 drivers/cxl/bus.c                       |   54 ++
 drivers/cxl/bus.h                       |    8 +
 drivers/cxl/cxl.h                       |  188 +++++
 drivers/cxl/mem.c                       | 1022 +++++++++++++++++++++++
 drivers/cxl/pci.h                       |   34 +
 include/acpi/actbl1.h                   |   51 ++
 include/uapi/linux/cxl_mem.h            |  148 ++++
 18 files changed, 2061 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-cxl
 create mode 100644 Documentation/cxl/index.rst
 create mode 100644 Documentation/cxl/memory-devices.rst
 create mode 100644 drivers/cxl/Kconfig
 create mode 100644 drivers/cxl/Makefile
 create mode 100644 drivers/cxl/acpi.c
 create mode 100644 drivers/cxl/acpi.h
 create mode 100644 drivers/cxl/bus.c
 create mode 100644 drivers/cxl/bus.h
 create mode 100644 drivers/cxl/cxl.h
 create mode 100644 drivers/cxl/mem.c
 create mode 100644 drivers/cxl/pci.h
 create mode 100644 include/uapi/linux/cxl_mem.h

-- 
2.29.2

