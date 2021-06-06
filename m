Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0988339CD91
	for <lists+linux-pci@lfdr.de>; Sun,  6 Jun 2021 08:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhFFGGp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Jun 2021 02:06:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:45974 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229504AbhFFGGo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 6 Jun 2021 02:06:44 -0400
IronPort-SDR: 3o66JognwwV769u8l1aKT2bXSqOtzSYzs7es0G5ohSkdMdb6+RGnDapGbo7E1565OjkI9eYKc7
 ZaFF1foQl7zQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10006"; a="184852986"
X-IronPort-AV: E=Sophos;i="5.83,252,1616482800"; 
   d="scan'208";a="184852986"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2021 23:04:55 -0700
IronPort-SDR: 1LN/NvijEUDEsEzvi/DxSTtqgRrjVRYfKr0VuUkRWmLPWcfE0KcR5LEDYTSKYcO2g4mP/Pm9yO
 NbqDZxOcPH3A==
X-IronPort-AV: E=Sophos;i="5.83,252,1616482800"; 
   d="scan'208";a="439664652"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2021 23:04:53 -0700
Subject: [PATCH v5 0/6] CXL port and decoder enumeration
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Date:   Sat, 05 Jun 2021 23:04:53 -0700
Message-ID: <162295949351.1109360.10329014558746500142.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes since v4 [1]:
- Rework the object model to better account for downstream ports and
  enumerate decode capabilities.
- Include the definition of CFMWS
- Reference CFMWS in the changelogs and implementation
- Drop mention of pcie_portdriver for CXL switch enumeration. This will
  be handled by CXL path validation when an endpoint wants to contribute
  to a memory region.

[1]: http://lore.kernel.org/r/162096970332.1865304.10280028741091576940.stgit@dwillia2-desk3.amr.corp.intel.com

---

The recently published CXL Fixed Memory Window Structure (CFMWS)
extension to the CXL Early Discovery Table (CEDT) provides a platform
firmware mechanism to enumerate CXL memory resources. The table data
indicates which CXL memory ranges were configured by platform BIOS, and
which address ranges are available to support hot plug and dynamic
provisioning of CXL memory regions.

CXL Port Topology:

The enumeration starts with the ACPI0017 driver registering a 'struct
cxl_port' object to establish the top of a port topology. It then
scans the ACPI bus looking for CXL Host Bridges (ACPI0016 instances). A
cxl_port represents one or more decoder resources between a 'uport'
(upstream port) and one or more 'dport' (downstream port) instances.
System software must not assume that 'struct cxl_port' device names will
be static from one boot to the next. It will generally be the case that
the root cxl_port starts at id '0' and the host bridges are enumerated
in the same order starting at id '1', but that is not guaranteed.

A 'uport' is a device that implements a decode. It can either be a
platform firmware device like ACPI0017 where the decode is described by
an ACPI data-structure, or a PCIe switch where the upstream port of the
switch implements a CXL DVSEC pointing to component registers with the
HDM decoder capability (see CXL 2.0 section 8.2.5.12 CXL HDM Decoder
Capability Structure).

Once a uport and its corresponding dport instances are collected into a
cxl_port the actual decode resources are then modeled as cxl_decode
objects that are children of their parent cxl_port. The 'decode' object
has a 1:1 relationship with ether CFMWS entries at the root level, or
hardware HDM decoder register instances in a PCIe device's CXL component
register space at any level of a CXL switch hierarchy. In addition to
the interleave geometry and address range a decode object conveys the
target list (targeted dports) in interleave order. The dport id in a
target list is either its ACPI _UID for Host Bridge targets, or the
"port number" field from the link capabilities register in the PCIe
"Express" capability [2].

Here is a tree(1) topology of QEMU emulating a single-ported
host-bridge:

    /sys/bus/cxl/devices/root0
    ├── devtype
    ├── dport0 -> ../LNXSYSTM:00/LNXSYBUS:00/ACPI0016:00
    ├── port1
    │   ├── decoder1.0
    │   │   ├── devtype
    │   │   ├── end
    │   │   ├── locked
    │   │   ├── start
    │   │   ├── subsystem -> ../../../../bus/cxl
    │   │   ├── target_list
    │   │   ├── target_type
    │   │   └── uevent
    │   ├── devtype
    │   ├── dport0 -> ../../pci0000:34/0000:34:00.0
    │   ├── subsystem -> ../../../bus/cxl
    │   ├── uevent
    │   └── uport -> ../../LNXSYSTM:00/LNXSYBUS:00/ACPI0016:00
    ├── subsystem -> ../../bus/cxl
    ├── uevent
    └── uport -> ../platform/ACPI0017:00


* The root port is singleton only by convention. A given uport device
  like ACPI0017 could create a root level port per CFMWS entry. This
  patch set chooses to implement 1 port at the root level and list all
  CFMWS decode entries under that port regardless of which dport host
  bridges are targeted.

[2]: CXL 2.0 8.2.5.12.8 CXL HDM Decoder 0 Target List Low Register
     (Offset 24h) ...The Target Port Identifier for a given Downstream Port
     is reported via Port Number field in Link Capabilities Register. (See
     PCI Express Base Specification).

---

Dan Williams (6):
      cxl/acpi: Local definition of ACPICA infrastructure
      cxl/acpi: Introduce cxl_root, the root of a cxl_port topology
      cxl/Kconfig: Default drivers to CONFIG_CXL_BUS
      cxl/acpi: Add downstream port data to cxl_port instances
      cxl/acpi: Enumerate host bridge root ports
      cxl/acpi: Introduce cxl_decoder objects


 Documentation/ABI/testing/sysfs-bus-cxl |   94 ++++++
 drivers/cxl/Kconfig                     |   17 +
 drivers/cxl/Makefile                    |    2 
 drivers/cxl/acpi.c                      |  193 ++++++++++++
 drivers/cxl/acpi.h                      |   48 +++
 drivers/cxl/core.c                      |  514 +++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h                       |   92 ++++++
 7 files changed, 960 insertions(+)
 create mode 100644 drivers/cxl/acpi.c
 create mode 100644 drivers/cxl/acpi.h

base-commit: 605a5e41db7d8c930fb80115686991c4c1d08ee4
