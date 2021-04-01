Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01BC3351E2E
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 20:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbhDASgC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 14:36:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:38549 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237776AbhDAS2B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Apr 2021 14:28:01 -0400
IronPort-SDR: 4rlJk1Ud7zx+r0Vl5Egt8TW/D6/M40JraZao7/Jxxwam5JLpJy9BhL8LJtZdYdKDkWGwS7NOSG
 m5kMfn723F8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="179789274"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="179789274"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 07:30:42 -0700
IronPort-SDR: H4pYbCLD2Atj4lnbzqm5H7RXdoGnmMB7d/Rc5Vxxar939NDhA5VOqTICrXrQPbsiq2vXVxr6KM
 AQYMzMK+1kZw==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="596359205"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 07:30:42 -0700
Subject: [PATCH v2 0/8] CXL Port Enumeration
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, ben.widawsky@intel.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 01 Apr 2021 07:30:42 -0700
Message-ID: <161728744224.2474040.12854720917440712854.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes since v1 [1]:
- Add stronger rationale for the 'struct cxl_regs' arrangement that
  accommodates devices that compose register blocks mixing "component",
  "device", and "memory device" register sets. (Christoph)

- Reorganize root, address space, and port device creation into separate
  'alloc' and 'add' steps.

- Rename "upstream_port" to "port_host". This is the PCI or ACPI device
  that implements the CXL port capability.

- Rename @parent to @host in init routines to clarify the device that is
  the context for devm from the device-model parent of the device being
  created.

- Rename port.cxl_regs_phys to port.component_regs_phys

- Add initialization for
  cxl_root.port.{target_id,component_regs_phys,port_host}, where
  target_id and component_regs_phys are set to invalid values (do not
  apply to cxl_root as the first port under root is the first actual
  device in the system and port_host is the ACPI0017 device.


[1]: http://lore.kernel.org/r/161662142382.1723715.5934723983022398253.stgit@dwillia2-desk3.amr.corp.intel.com

---

This series is a preview of the proposed infrastructure for enabling
dynamic mapping of Host-managed Device Memory (HDM) Decoders. It
includes a not-for-upstream hack at the tail of the series to stand-in
for the in-flight ACPICA enabling. The goal is to get review of the
proposal in parallel with other in-flight dependencies. The next step
after this is to add dynamic enumeration and assignment of HDM Decoders
in coordination with per-cxl_port driver instances.

---

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
 drivers/cxl/core.c                              |  553 +++++++++++++++++++++++
 drivers/cxl/cxl.h                               |  146 ++++--
 drivers/cxl/mem.c                               |   97 +---
 drivers/cxl/mem.h                               |   82 +++
 9 files changed, 990 insertions(+), 160 deletions(-)
 create mode 100644 drivers/cxl/acpi.c
 delete mode 100644 drivers/cxl/bus.c
 create mode 100644 drivers/cxl/core.c
 create mode 100644 drivers/cxl/mem.h

base-commit: a38fd8748464831584a19438cbb3082b5a2dab15
