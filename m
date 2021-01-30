Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9341F30946B
	for <lists+linux-pci@lfdr.de>; Sat, 30 Jan 2021 11:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbhA3A0D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Jan 2021 19:26:03 -0500
Received: from mga01.intel.com ([192.55.52.88]:38336 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230009AbhA3AZa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Jan 2021 19:25:30 -0500
IronPort-SDR: ihODjFYr1ag+oXqn21UF3cNlZMyxdzBQwqFEzZGnXp2FsT0NIqxcNw6KABQJbdWMVuHBQv8jyp
 0OvEI9mvsCVg==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="199350680"
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="199350680"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 16:24:45 -0800
IronPort-SDR: 2Qr93ZP+aH/uhPOAc0J5zom4DzflXQWWzztfofYSrASo6XXKWnzKVo9aQbDuqJbLce75q5/+gP
 6Qi46MABmQiQ==
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="370591638"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.15])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 16:24:44 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        daniel.lll@alibaba-inc.com,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Subject: [PATCH 00/14] CXL 2.0 Support
Date:   Fri, 29 Jan 2021 16:24:24 -0800
Message-Id: <20210130002438.1872527-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

# Changes since RFC v3 [1]
   * Added error message when payload size is too small. (Ben)
   * Fix includes in UAPI for Clang (LKP)
   * Reorder CXL in MAINTAINERS (Joe Perches)
   * Kconfig whitespace and spelling fixes (Randy)
   * Remove excess frees controlled by devm, introduced in v3 (Jonathan, Dan)
   * Use 'PCI Express' instead of 'PCI-E' in Kconfig (Jonathan)
   * Fail when mailbox commands return value is an error (Jonathan)
   * Add comment to mailbox protocol to explain ordering of operations
     (Jonathan, Ben)
   * Fail mailbox xfer when doorbell is busy. (Jonathan)
   * Remove extraneous SHIFT defines. (Jonathan)
   * Change kdocs for mbox_cmd size_out to output only. (Jonathan)
   * Fix transient bug (ENOTTY) in CXL_MEM_QUERY_COMMANDS (Jonathan)
   * Add some comments and code beautification to mbox commands (Jonathan)
   * Add some comments and code beautification to user commands (Jonathan)
   * Fix bogus check of memcpy return value (Ben)
   * Add concept of blocking certain RAW opcodes (Dan)
   * Add debugfs knob to allow all RAW opcodes (Vishal)
   * Move docs to driver-api/ (Dan)
   * Use bounce buffer again like in v2 (Jonathan)
       * Use kvzalloc instead of memdup (Ben)
   * Wordsmith some changelogs and documentation (Dan)
   * Use a percpu_ref counter to protect devm allocated data in the ioctl path
     (Dan)
   * Rework cdev registration and lookup to use inode->i_cdev (Dan)
   * Drop mutex_lock_interruptible() from ioctl path (Dan)
   * Convert add_taint() to WARN_TAINT_ONCE()
   * Drop ACPI coordination for pure mailbox driver milestone (Dan)
   * Permit GET_LOG with CEL_UUID (Ben)
   * Cover letter overhaul (Ben)
   * Use info.id instead of CXL_COMMAND_INDEX (Dan)
   * Add several new commands to the mailbox interface (Ben)

---

In addition to the mailing list, please feel free to use #cxl on oftc IRC for
discussion.

---

# Summary

Introduce support for “type-3” memory devices defined in the Compute Express
Link (CXL) 2.0 specification [2]. Specifically, these are the memory devices
defined by section 8.2.8.5 of the CXL 2.0 spec. A reference implementation
emulating these devices has been submitted to the QEMU mailing list [3] and is
available on gitlab [4], but will move to a shared tree on kernel.org after
initial acceptance. “Type-3” is a CXL device that acts as a memory expander for
RAM or Persistent Memory. The device might be interleaved with other CXL devices
in a given physical address range.

In addition to the core functionality of discovering the spec defined registers
and resources, introduce a CXL device model that will be the foundation for
translating CXL capabilities into existing Linux infrastructure for Persistent
Memory and other memory devices. For now, this only includes support for the
management command mailbox the surfacing of type-3 devices. These control
devices fill the role of “DIMMs” / nmemX memory-devices in LIBNVDIMM terms.

## Userspace Interaction

Interaction with the driver and type-3 devices via the CXL drivers is introduced
in this patch series and considered stable ABI. They include

   * sysfs - Documentation/ABI/testing/sysfs-bus-cxl
   * IOCTL - Documentation/driver-api/cxl/memory-devices.rst
   * debugfs - Documentation/ABI/testing/debugfs-debug


Work is in process to add support for CXL interactions to the ndctl project [5]

### Development plans

One of the unique challenges that CXL imposes on the Linux driver model is that
it requires the operating system to perform physical address space management
interleaved across devices and bridges. Whereas LIBNVDIMM handles a list of
established static persistent memory address ranges (for example from the ACPI
NFIT), CXL introduces hotplug and the concept of allocating address space to
instantiate persistent memory ranges. This is similar to PCI in the sense that
the platform establishes the MMIO range for PCI BARs to be allocated, but it is
significantly complicated by the fact that a given device can optionally be
interleaved with other devices and can participate in several interleave-sets at
once. LIBNVDIMM handled something like this with the aliasing between PMEM and
BLOCK-WINDOW mode, but CXL adds flexibility to alias DEVICE MEMORY through up to
10 decoders per device.

All of the above needs to be enabled with respect to PCI hotplug events on
Type-3 memory device which needs hooks to determine if a given device is
contributing to a "System RAM" address range that is unable to be unplugged. In
other words CXL ties PCI hotplug to Memory Hotplug and PCI hotplug needs to be
able to negotiate with memory hotplug.  In the medium term the implications of
CXL hotplug vs ACPI SRAT/SLIT/HMAT need to be reconciled. One capability that
seems to be needed is either the dynamic allocation of new memory nodes, or
default initializing extra pgdat instances beyond what is enumerated in ACPI
SRAT to accommodate hot-added CXL memory.

Patches welcome, questions welcome as the development effort on the post v5.12
capabilities proceeds.

## Running in QEMU

The incantation to get CXL support in QEMU [4] is considered unstable at this
time. Future readers of this cover letter should verify if any changes are
needed. For the novice QEMU user, the following can be copy/pasted into a
working QEMU commandline. It is enough to make the simplest topology possible.
The topology would consist of a single memory window, single type3 device,
single root port, and single host bridge.

    +-------------+
    |   CXL PXB   |
    |             |
    |  +-------+  |<----------+
    |  |CXL RP |  |           |
    +--+-------+--+           v
           |            +----------+
           |            | "window" |
           |            +----------+
           v                  ^
    +-------------+           |
    |  CXL Type 3 |           |
    |   Device    |<----------+
    +-------------+

// Memory backend
-object memory-backend-file,id=cxl-mem1,share,mem-path=cxl-type3,size=512M

// Host Bridge
-device pxb-cxl id=cxl.0,bus=pcie.0,bus_nr=52,uid=0 len-window-base=1,window-base[0]=0x4c0000000 memdev[0]=cxl-mem1

// Single root port
-device cxl rp,id=rp0,bus=cxl.0,addr=0.0,chassis=0,slot=0,memdev=cxl-mem1

// Single type3 device
-device cxl-type3,bus=rp0,memdev=cxl-mem1,id=cxl-pmem0,size=256M -device cxl-type3,bus=rp1,memdev=cxl-mem1,id=cxl-pmem1,size=256M

---

[1]: https://lore.kernel.org/linux-cxl/20201209002418.1976362-1-ben.widawsky@intel.com/
[2]: https://www.computeexpresslink.org/](https://www.computeexpresslink.org/
[3]: https://lore.kernel.org/qemu-devel/20210105165323.783725-1-ben.widawsky@intel.com/T/#t
[4]: https://gitlab.com/bwidawsk/qemu/-/tree/cxl-2.0v*
[5]: https://github.com/pmem/ndctl/tree/cxl-2.0v*


Ben Widawsky (12):
  cxl/mem: Map memory device registers
  cxl/mem: Find device capabilities
  cxl/mem: Implement polled mode mailbox
  cxl/mem: Add basic IOCTL interface
  cxl/mem: Add send command
  taint: add taint for direct hardware access
  cxl/mem: Add a "RAW" send command
  cxl/mem: Create concept of enabled commands
  cxl/mem: Use CEL for enabling commands
  cxl/mem: Add set of informational commands
  cxl/mem: Add limited Get Log command (0401h)
  MAINTAINERS: Add maintainers of the CXL driver

Dan Williams (2):
  cxl/mem: Introduce a driver for CXL-2.0-Type-3 endpoints
  cxl/mem: Register CXL memX devices

 .clang-format                                 |    1 +
 Documentation/ABI/testing/debugfs-cxl         |   10 +
 Documentation/ABI/testing/sysfs-bus-cxl       |   26 +
 Documentation/admin-guide/sysctl/kernel.rst   |    1 +
 Documentation/admin-guide/tainted-kernels.rst |    6 +-
 Documentation/driver-api/cxl/index.rst        |   12 +
 .../driver-api/cxl/memory-devices.rst         |   46 +
 Documentation/driver-api/index.rst            |    1 +
 .../userspace-api/ioctl/ioctl-number.rst      |    1 +
 MAINTAINERS                                   |   11 +
 drivers/Kconfig                               |    1 +
 drivers/Makefile                              |    1 +
 drivers/base/core.c                           |   14 +
 drivers/cxl/Kconfig                           |   49 +
 drivers/cxl/Makefile                          |    7 +
 drivers/cxl/bus.c                             |   29 +
 drivers/cxl/cxl.h                             |  140 ++
 drivers/cxl/mem.c                             | 1603 +++++++++++++++++
 drivers/cxl/pci.h                             |   34 +
 include/linux/device.h                        |    1 +
 include/linux/kernel.h                        |    3 +-
 include/uapi/linux/cxl_mem.h                  |  180 ++
 kernel/panic.c                                |    1 +
 23 files changed, 2176 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-cxl
 create mode 100644 Documentation/ABI/testing/sysfs-bus-cxl
 create mode 100644 Documentation/driver-api/cxl/index.rst
 create mode 100644 Documentation/driver-api/cxl/memory-devices.rst
 create mode 100644 drivers/cxl/Kconfig
 create mode 100644 drivers/cxl/Makefile
 create mode 100644 drivers/cxl/bus.c
 create mode 100644 drivers/cxl/cxl.h
 create mode 100644 drivers/cxl/mem.c
 create mode 100644 drivers/cxl/pci.h
 create mode 100644 include/uapi/linux/cxl_mem.h

-- 
2.30.0

