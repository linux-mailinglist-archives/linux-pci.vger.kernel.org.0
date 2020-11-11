Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF822AE84C
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 06:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgKKFoH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 00:44:07 -0500
Received: from mga12.intel.com ([192.55.52.136]:54150 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgKKFoF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Nov 2020 00:44:05 -0500
IronPort-SDR: m4g6k+Hl9pizKrSHdTFng7sP87acTx2nAlOFwLgBpXfBEW/fa1gJU5H+K1XPgCoBx+sCirt4i5
 NizR6qDWBRLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="149372946"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="149372946"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 21:44:02 -0800
IronPort-SDR: gQzIQInEA5r3owPoX3X4seS8dnk1b29gobwVFwNWfq2rezXEKm4VwbkgJ8IL1AwMLJl9xwB0Mg
 n7lnMsH7/OPw==
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="360414721"
Received: from hccoutan-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.131.159])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 21:44:02 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Subject: [RFC PATCH 0/9] CXL 2.0 Support
Date:   Tue, 10 Nov 2020 21:43:47 -0800
Message-Id: <20201111054356.793390-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduce support for “type-3” memory devices defined in the recently released
Compute Express Link (CXL) 2.0 specification. Specifically, these are the memory
devices defined by section 8.2.8.5 of the CXL 2.0 spec. A reference
implementation emulating these devices is being submitted to the QEMU mailing
list. “Type-3” is a CXL device that acts as a memory expander for RAM or PMEM.
It might be interleaved with other CXL devices in a given physical address
range.

These changes allow for foundational enumeration of CXL 2.0 memory devices. The functionality present is:
- Initial driver bring-up
- Device enumeration and an initial sysfs representation
- Submit a basic firmware command via ‘mailbox’ to an emulated memory device
  with non-volatile capacity.

Some of the functionality that is still missing includes:
- Memory interleaving at the host bridge, root port, or switch level
- CXL 1.1 Root Complex Integrated Endpoint Support
- CXL 2.0 Hot plug support

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
3. _OSC UUID A4D1629D-FF52-4888-BE96-E5CADE548DB1

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


CXL Exclusive _OSC
-----------------
CXL 2.0 definition provides new fields to _OSC for host bridges to allow for new
services provided by CXL - error handling, hot plug, capabilities, etc. This is
built on top of PCIe _OSC via a new UUID. A CXL unaware OS will use the old UUID
to configure the PCIe host bridge. The expectation is that a CXL aware OS uses
the new UUID and to modify both CXL and PCIE capabilities in one shot. The issue
arises when trying to define a standalone CXL driver. The core OS will configure
the PCIe _OSC, but when the CXL driver attempts to set CXL _OSC the current
definition makes that driver re-specify PCIE capabilities. An isolated CXL-only
_OSC allows the PCIE core to be unchanged and let a CXL driver stack manage CXL
_OSC without the possibility of clobbering / colliding with PCIE core OSC
management.  The proposal moves the new _OSC dwords (SUPC and CTRC) to their own
_OSC UUID.

Next steps after this basic foundation is expanded command support and LIBNVDIMM
integration. This is the initial “release early / release often” version of the
Linux CXL enabling.


Ben Widawsky (5):
  cxl/mem: Map memory device registers
  cxl/mem: Find device capabilities
  cxl/mem: Initialize the mailbox interface
  cxl/mem: Implement polled mode mailbox
  MAINTAINERS: Add maintainers of the CXL driver

Dan Williams (2):
  cxl/mem: Add a driver for the type-3 mailbox
  cxl/mem: Register CXL memX devices

Vishal Verma (2):
  cxl/acpi: Add an acpi_cxl module for the CXL interconnect
  cxl/acpi: add OSC support

 MAINTAINERS           |   9 +
 drivers/Kconfig       |   1 +
 drivers/Makefile      |   1 +
 drivers/cxl/Kconfig   |  50 ++++
 drivers/cxl/Makefile  |   9 +
 drivers/cxl/acpi.c    | 325 ++++++++++++++++++++++
 drivers/cxl/acpi.h    |  33 +++
 drivers/cxl/bus.c     |  35 +++
 drivers/cxl/bus.h     |   8 +
 drivers/cxl/cxl.h     | 166 +++++++++++
 drivers/cxl/mem.c     | 631 ++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/pci.h     |  21 ++
 include/acpi/actbl1.h |  52 ++++
 13 files changed, 1341 insertions(+)
 create mode 100644 drivers/cxl/Kconfig
 create mode 100644 drivers/cxl/Makefile
 create mode 100644 drivers/cxl/acpi.c
 create mode 100644 drivers/cxl/acpi.h
 create mode 100644 drivers/cxl/bus.c
 create mode 100644 drivers/cxl/bus.h
 create mode 100644 drivers/cxl/cxl.h
 create mode 100644 drivers/cxl/mem.c
 create mode 100644 drivers/cxl/pci.h

-- 
2.29.2

