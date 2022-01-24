Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69BF497670
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 01:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240548AbiAXA2k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jan 2022 19:28:40 -0500
Received: from mga04.intel.com ([192.55.52.120]:41947 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235008AbiAXA2j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Jan 2022 19:28:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642984119; x=1674520119;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O+MpZFnYgrZlyePty/+JLNKv2kOTRvJBvM66K63gDg8=;
  b=I1GOc6/Q0b2oG4LYqWwaK4gnGFxCwKU8pHGXUC+PCXzhbv1e0jbEcEIC
   n/JUnlktA7wpiv35FaisZEgj1sw2WGkthyHHCwqFlY7Mmb33BxDnBnI1X
   uNcWreNwtO+IZTe6qFecv81Z3Rx3frmYmQQdXyGWXhAz9g21tUYjqshiS
   xyr/PS7ITqQANt6fvgadXJpKLrI0h6hflX01wA9pbt8yI66nzAvN+8g37
   sILw0I++b6dWH2Mthr5S9siFtD3uSRzigpHYht6BlZgemmijEAEvJfeCN
   IKs6fEf4+y6usBpG4mALDHTbSb18J9qxL2eEd9PLbHQC39EK4st1GnV9o
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="244766434"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="244766434"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:28:39 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="476536323"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:28:39 -0800
Subject: [PATCH v3 00/40] CXL.mem Topology Discovery and Hotplug Support
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@huwei.com>,
        kernel test robot <lkp@intel.com>, linux-pci@vger.kernel.org,
        nvdimm@lists.linux.dev
Date:   Sun, 23 Jan 2022 16:28:38 -0800
Message-ID: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes since v2 [1]:
- Rework the series to clarify the role of 'struct cxl_port' objects and
  fix hotplug bugs.
  - Drop the cxl_topology_host() concept.
  - Fix endpoint unregistration relative to port ->remove() and
    switch-port unregistration relative to to endpoint ->remove().
- Add cxl_test infrastructure to validate switch enumeration and various
  hotplug scenarios (see upcoming updates to the 'cxl' tool for the
  userspace side of this testing).
- Add lockdep coverage of the CXL subsystem's use of the device_lock().
- Add a "Theory of Operation" section to
  Documentation/driver-api/cxl/memory-devices.rst describing the
  behavior and role of the 'struct bus_type cxl_bus_type' instance (see:
  [PATCH v3 24/40] cxl/port: Add a driver for 'struct cxl_port' objects).
- For timeout scenarios like mailbox ready time, memory valid, memory
  active, use a sleeping wait rather than a spin wait
- Add a 'serial' attribute to memory devices since CXL mandates device
  implement the PCIe Device Serial Number definition.
- Rename report_status() / report_cmd_status() cxl_err() / cxl_cmd_err()
  (Jonathan)

[1]: https://lore.kernel.org/r/20211202043750.3501494-1-ben.widawsky@intel.com

---

The CXL subsystem enabling story so far has been concerned with
enumerating the platform firmware described "root" level of a CXL
topology (CXL capable Host Bridges and CXL platform address ranges), and
the endpoint level (CXL Memory Expanders identified by PCIe class code).
The next phase is connecting endpoints to that root description by an
arbitrary number of intervening switch ports.

The driver for CXL Memory Expanders, 'cxl_pci', registers a 'struct
cxl_memdev' on the CXL bus. To date that device has only served as the
entry point for submitting CXL Memory Device control and management
commands. Now a new 'cxl_mem' driver takes that device and probes the
topology to validate it is capable of CXL.mem operations.

As 'cxl_mem' probes the topology it registers 'struct cxl_port'
instances at each Upstream Switch Port that it finds on the walk to the
CXL root. Each of those port device in turn attempt to attach to a
'cxl_port' driver. The 'cxl_port' probe process enumerates Downstream
Ports and CXL HDM Decoder Capability structures. If cxl_port_probe()
fails it unwinds all descendent ports that were previously registered
and ultimately fails cxl_mem_probe() as result.

This design lets CXL Port capabilities be enumerated late, and only in
the presence of attached Memory Expander endpoints.

- The first 16 patches are fixes and preparatory cleanups including
  support for validating usage of device_lock() in the subsystem.
- Patches 17-24 centralize Downstream Port and HDM Decoder Capability
  enumeration in the core and then introduces the cxl_port driver.
- Patches 25-33 validates the CXL.mem link came up in endpoints, adds
  core infrastructure to enumerate Swicht Ports, and adds the cxl_mem
  driver.
- Patches 34 and 35 add endpoint decoder enumeration.
- The last 5 patches add cxl_test infrastructure to validate all the
  mechanics of attaching and detaching cxl_port and cxl_memdev
  instances.

See the Documentation updates in patch 24 for more details.

---

Ben Widawsky (17):
      cxl: Rename CXL_MEM to CXL_PCI
      cxl/pci: Implement Interface Ready Timeout
      cxl: Flesh out register names
      cxl/pci: Add new DVSEC definitions
      cxl/acpi: Map component registers for Root Ports
      cxl: Introduce module_cxl_driver
      cxl/core: Convert decoder range to resource
      cxl/core/port: Clarify decoder creation
      cxl/core/port: Make passthrough decoder init implicit
      cxl/core: Track port depth
      cxl/port: Add a driver for 'struct cxl_port' objects
      cxl/pci: Store component register base in cxlds
      cxl/pci: Cache device DVSEC offset
      cxl/pci: Retrieve CXL DVSEC memory info
      cxl/pci: Implement wait for media active
      cxl/mem: Add the cxl_mem driver
      cxl/core/port: Add endpoint decoders

Dan Williams (23):
      cxl/pci: Defer mailbox status checks to command timeouts
      cxl/core/port: Rename bus.c to port.c
      cxl/decoder: Hide physical address information from non-root
      cxl/core: Fix cxl_probe_component_regs() error message
      cxl: Prove CXL locking
      cxl/core/port: Use dedicated lock for decoder target list
      cxl/port: Introduce cxl_port_to_pci_bus()
      cxl/pmem: Introduce a find_cxl_root() helper
      cxl/port: Up-level cxl_add_dport() locking requirements to the caller
      cxl/pci: Rename pci.h to cxlpci.h
      cxl/core: Generalize dport enumeration in the core
      cxl/core/hdm: Add CXL standard decoder enumeration to the core
      cxl/core: Emit modalias for CXL devices
      cxl/core/port: Remove @host argument for dport + decoder enumeration
      cxl/pci: Emit device serial number
      cxl/memdev: Add numa_node attribute
      cxl/core/port: Add switch port enumeration
      cxl/core: Move target_list out of base decoder attributes
      tools/testing/cxl: Mock dvsec_ranges()
      tools/testing/cxl: Fix root port to host bridge assignment
      tools/testing/cxl: Mock one level of switches
      tools/testing/cxl: Enumerate mock decoders
      tools/testing/cxl: Add a physical_node link


 Documentation/ABI/testing/sysfs-bus-cxl         |   36 +
 Documentation/driver-api/cxl/memory-devices.rst |  315 +++++
 drivers/cxl/Kconfig                             |   44 +
 drivers/cxl/Makefile                            |    6 
 drivers/cxl/acpi.c                              |  151 --
 drivers/cxl/core/Makefile                       |    4 
 drivers/cxl/core/bus.c                          |  675 ----------
 drivers/cxl/core/core.h                         |    3 
 drivers/cxl/core/hdm.c                          |  253 ++++
 drivers/cxl/core/memdev.c                       |   46 +
 drivers/cxl/core/pci.c                          |   98 ++
 drivers/cxl/core/pmem.c                         |   18 
 drivers/cxl/core/port.c                         | 1483 +++++++++++++++++++++++
 drivers/cxl/core/regs.c                         |   63 +
 drivers/cxl/cxl.h                               |  184 +++
 drivers/cxl/cxlmem.h                            |   40 +
 drivers/cxl/cxlpci.h                            |   75 +
 drivers/cxl/mem.c                               |  221 +++
 drivers/cxl/pci.c                               |  373 ++++--
 drivers/cxl/pci.h                               |   34 -
 drivers/cxl/pmem.c                              |   12 
 drivers/cxl/port.c                              |   76 +
 drivers/nvdimm/nd-core.h                        |    2 
 lib/Kconfig.debug                               |   23 
 tools/testing/cxl/Kbuild                        |   22 
 tools/testing/cxl/mock_acpi.c                   |   74 -
 tools/testing/cxl/mock_mem.c                    |   10 
 tools/testing/cxl/mock_pmem.c                   |   24 
 tools/testing/cxl/test/cxl.c                    |  330 ++++-
 tools/testing/cxl/test/mem.c                    |   19 
 tools/testing/cxl/test/mock.c                   |   91 +
 tools/testing/cxl/test/mock.h                   |    8 
 32 files changed, 3591 insertions(+), 1222 deletions(-)
 delete mode 100644 drivers/cxl/core/bus.c
 create mode 100644 drivers/cxl/core/hdm.c
 create mode 100644 drivers/cxl/core/pci.c
 create mode 100644 drivers/cxl/core/port.c
 create mode 100644 drivers/cxl/cxlpci.h
 create mode 100644 drivers/cxl/mem.c
 delete mode 100644 drivers/cxl/pci.h
 create mode 100644 drivers/cxl/port.c
 create mode 100644 tools/testing/cxl/mock_mem.c
 delete mode 100644 tools/testing/cxl/mock_pmem.c

base-commit: be185c2988b48db65348d94168c793bdbc8d23c3
