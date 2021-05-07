Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88153376CF0
	for <lists+linux-pci@lfdr.de>; Sat,  8 May 2021 00:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhEGWwQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 May 2021 18:52:16 -0400
Received: from mga12.intel.com ([192.55.52.136]:16509 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229470AbhEGWwP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 May 2021 18:52:15 -0400
IronPort-SDR: /MFOtNCyBPYgjR2ceYfEGsVy7KEGMYcalLszX2/TutjV8Eh5PU+8YB7Lq2g7BTtdwIzmo9ZZ6h
 WpTsJmVzFxoA==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="178392082"
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="178392082"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 15:51:15 -0700
IronPort-SDR: n9ep2vMEGRmC5LbsCg5dQlQxozStu1spNE2X1sd6RdH4CfjVCYGH7I69mPn8JgsSD62xFs5ltI
 oogMEn5EAJ9A==
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="620367064"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 15:51:15 -0700
Subject: [PATCH v3 0/8] CXL Port Enumeration and Plans for v5.14
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Date:   Fri, 07 May 2021 15:51:14 -0700
Message-ID: <162042787450.1202325.5718541949681409566.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes since v2 [1]:
- Add some rationale for moving definitions out of mem.c into mem.h
  (Jonathan)

- Fixup CXL_DEVICE_REGS kernel doc and declare the fixup for the
  struct cxl_mem kernel-doc in the changelog (Jonathan)

- Fixup cxl_setup_device_regs() kernel-doc (Jonathan)

- Cleanup comment in cxl_root_alloc() (Jonathan)

- [not changed] refactor device creation into alloc_and_add()
  anti-pattern.

- Add kernel doc to cxl_address_space_dev_add() to clarify why @host is
  needed as an arg. (Jonathan)

- Describe what the port devices are representing in "cxl/port:
  Introduce cxl_port objects" (Jonathan)

- Explain the rationale for /sys/bus/cxl (Bjorn)

[1]: http://lore.kernel.org/r/161728744224.2474040.12854720917440712854.stgit@dwillia2-desk3.amr.corp.intel.com

---

Plans for v5.14:

This series is a starting point for the persistent memory and dynamic
HDM decoder manipulation support targeting the v5.14 kernel. Among the
tasks to complete in that timeframe are:

- Region creation including CXL label support
- LIBNVDIMM integration for surfacing /dev/pmemX and /dev/daxX.Y devices
  on CXL resources
- HDM decoder enumeration and programming for setting up PMEM mappings
  alongside any "System RAM" mappings established by platform firmware
- CDAT-DOE support in support of dynamically created NUMA nodes
- CXL PMEM Shutdown semantics (global persistence flush coordination)

Contributions to cxl.git targeting the next merge window require a
non-author Reviewed-by. A patch with a Reviewed-by, no outstanding
objections, and a 3-5 day quiet period on the list is subject to be
applied to a non-rebasing cxl.git branch and merged into cxl.git/next.
Contributions targeting a current -rc (fixes) may go in on an expedited
schedule with only an Acked-by.

---

CXL Port Topology:

The enumeration starts with the ACPI0017 driver registering a 'struct
cxl_root' object to establish the top of a cxl_port topology. It then
scans the ACPI bus looking for ACPI0016 instances. The cxl_root object
is a singleton* anchor to hang "address-space" objects and be a parent
device for the downstream 'struct cxl_port' instances. An address-space
has a 1:1 relationship with a platform defined memory resource range,
like _CRS for PCIE Host Bridges. Use module parameters to model a
root-level HDM decoder that all downstream ports further decode, to be
replaced with a Code First ECN to do the same.

Each address space is modeled as a sysfs object that also shows up in
/proc/iomem as "CXL Address Space". That iomem resource is functionally
equivalent to the root-level 'PCI Bus' resources for PCIE.mmio while
'CXL Address Space' indicates space for CXL.mem to be mapped. "System
RAM" and "Persistent Memory", when mapped by HDM decoders, will appear
as child CXL.mem resources.

Once a 'struct cxl_root' is established the host bridge is modeled as 1
upstream 'struct cxl_port' and N downstream 'struct cxl_port' instances
(one per Root Port), just like a PCIE switch. The host-bridge upstream
port optionally has the HDM decoder registers from the CHBCR if the
host-bridge has multiple PCIE/CXL root ports. Single-ported host bridges
will not have HDM decoders in the CHBCR space (see CHBCR note in
8.2.5.12 CXL HDM Decoder Capability Structure), but the 'struct
cxl_port' object is still needed to represent other CXL capabilities and
access port-specific component registers outside of HDM decoders.

Each 'struct cxl_port' has a 'target_id' attribute that answers the
question "what port am I in my upstream port's HDM decoder target
list?". For the host-bridge struct cxl_port, the first tier of ports
below cxl_root.port, the id is derived from the ordinal mapping of the
ACPI0016 id (instance id, _UID, or other handle TBD), for all other
ports the id is the PCIE Root Port ID from the Link Capabilities
register [1]. The mapping of ordinal port identifiers relative to their
parent may change once libcxl and cxl-cli prove out region creation, or
a better option is found to establish a static device path / persistent
naming scheme. System software must not assume that 'struct cxl_port'
device names will be static from one boot to the next.

See patch7 for a tree(1) topology picture of what QEMU is producing
today with this enabling.

* cxl_root is singleton only by convention. A given cxl_root could
  represent 1 to N address spaces, this patch set chooses to implement 1
  cxl_root for all address spaces.

[1]: CXL 2.0 8.2.5.12.8 CXL HDM Decoder 0 Target List Low Register
     (Offset 24h) ...The Target Port Identifier for a given Downstream Port
     is reported via Port Number field in Link Capabilities Register. (See
     PCI Express Base Specification).

---

Dan Williams (8):
      cxl/mem: Move some definitions to mem.h
      cxl/mem: Introduce 'struct cxl_regs' for "composable" CXL devices
      cxl/core: Rename bus.c to core.c
      cxl/core: Refactor CXL register lookup for bridge reuse
      cxl/acpi: Introduce ACPI0017 driver and cxl_root
      cxl/Kconfig: Default drivers to CONFIG_CXL_BUS
      cxl/port: Introduce cxl_port objects
      cxl/acpi: Add module parameters to stand in for ACPI tables


 Documentation/driver-api/cxl/memory-devices.rst |    6 
 drivers/cxl/Kconfig                             |   16 +
 drivers/cxl/Makefile                            |    6 
 drivers/cxl/acpi.c                              |  215 +++++++++
 drivers/cxl/bus.c                               |   29 -
 drivers/cxl/core.c                              |  561 +++++++++++++++++++++++
 drivers/cxl/cxl.h                               |  148 ++++--
 drivers/cxl/mem.c                               |   97 +---
 drivers/cxl/mem.h                               |   82 +++
 9 files changed, 999 insertions(+), 161 deletions(-)
 create mode 100644 drivers/cxl/acpi.c
 delete mode 100644 drivers/cxl/bus.c
 create mode 100644 drivers/cxl/core.c
 create mode 100644 drivers/cxl/mem.h

base-commit: a38fd8748464831584a19438cbb3082b5a2dab15
