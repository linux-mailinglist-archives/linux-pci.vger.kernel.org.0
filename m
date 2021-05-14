Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2420F38033B
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 07:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbhENFW4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 01:22:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:33955 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229477AbhENFW4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 May 2021 01:22:56 -0400
IronPort-SDR: NtRuEKUFppOSMwQAtyF4PCcIfGNFZ1Mvwoa5ueZEFVFIFAqtrLH7EwpeiSozSA6TZDI7TcdNfe
 YepCIbA+G4KQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="264039909"
X-IronPort-AV: E=Sophos;i="5.82,299,1613462400"; 
   d="scan'208";a="264039909"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 22:21:44 -0700
IronPort-SDR: f7Fxsio2P7V0Ar0lhxMBwmcsZ/Ixp2Eb3Vy+anagkjsAXzowoC8vkJr3+8VitvtA1hsl3h0eZb
 /m6ykdOphP9Q==
X-IronPort-AV: E=Sophos;i="5.82,299,1613462400"; 
   d="scan'208";a="456984554"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 22:21:43 -0700
Subject: [PATCH v4 0/8] CXL Port Enumeration and Plans for v5.14
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        kernel test robot <lkp@intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 13 May 2021 22:21:43 -0700
Message-ID: <162096970332.1865304.10280028741091576940.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes since v3 [1]:
- Rebase to v5.13-rc1

- Fix some compile warnings (0day robot)

- Clarify that the address_spaceX/support* attributes either return
  "0\n" on read when not supported, or the attribute is not published /
  visible to indicate the same. (Jonathan)

- Add ABI documentation for address_spaceX and portX objects (Jonathan)

- Collect some reviewed-by tags, thanks Jonathan!

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


 Documentation/ABI/testing/sysfs-bus-cxl         |   89 ++++
 Documentation/driver-api/cxl/memory-devices.rst |    6
 drivers/cxl/Kconfig                             |   16 +
 drivers/cxl/Makefile                            |    6
 drivers/cxl/acpi.c                              |  215 +++++++++
 drivers/cxl/bus.c                               |   29 -
 drivers/cxl/core.c                              |  566 +++++++++++++++++++++++
 drivers/cxl/cxl.h                               |  148 ++++--
 drivers/cxl/mem.c                               |   93 +---
 drivers/cxl/mem.h                               |   78 +++
 10 files changed, 1089 insertions(+), 157 deletions(-)
 create mode 100644 drivers/cxl/acpi.c
 delete mode 100644 drivers/cxl/bus.c
 create mode 100644 drivers/cxl/core.c
 create mode 100644 drivers/cxl/mem.h

base-commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5
