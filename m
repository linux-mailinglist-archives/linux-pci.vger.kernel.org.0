Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB34731D470
	for <lists+linux-pci@lfdr.de>; Wed, 17 Feb 2021 05:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhBQEKr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Feb 2021 23:10:47 -0500
Received: from mga07.intel.com ([134.134.136.100]:21743 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229480AbhBQEKq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Feb 2021 23:10:46 -0500
IronPort-SDR: kaA9mu7GXL/3wWDbV2I5SjtdgrbTUebEgdW5Yj/hoBo5WIO0WYeTX8j8WI4laf8AAlbTp0HUfZ
 AiWYE7Gty05A==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="247165904"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="247165904"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 20:10:05 -0800
IronPort-SDR: 5bLMSbQoMP5uFKbdJvlT+REImQxEIlJ0aHFJAZY+v0AIYJfXoNzNJtWrsxTescVpNTTP47v+JS
 ZolgZBBXEH6w==
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="384948752"
Received: from yxie-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.134.141])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 20:10:03 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Subject: [PATCH v5 0/9] CXL 2.0 Support
Date:   Tue, 16 Feb 2021 20:09:49 -0800
Message-Id: <20210217040958.1354670-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

# Changes since v4 [1]

* Use vmemdup_user instead of open-coded (Al Viro)
* Fix when kernel docs get introduced (Ben)
  * Fix unhappy sphinx '%-*' (sfr)
* Remove redundant initialization (Colin, Dan C)
* Make cxl_mem_mbox_send_cmd enforce size (Dan, Jonathan)
  * Except for variable sized output (Ben)
* Fix off by one in register block enumeration (Jonathan)
* Use FIELD_GET for capability ID (Jonathan)
* Fix potential overflows on output buffer (Jonathan)
  * Go back to using size_out to verify memcpy_fromio size
  * Add out_size to cxl_mem_mbox_send_cmd
* UAPI change (Dan)
  * Make out.size represent the actual amount written as opposed to how much
    hardware wrote. The kernel docs already reflected this behavior, so it's
    fair to say the change is a bug fix rather than UAPI change.

Excluding the bug fix there have been no UAPI changes since v1.

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

// Memory backend for "window"
-object memory-backend-file,id=cxl-mem1,share,mem-path=cxl-type3,size=512M

// Memory backend for LSA
-object memory-backend-file,id=cxl-mem1-lsa,share,mem-path=cxl-mem1-lsa,size=1K

// Host Bridge
-device pxb-cxl id=cxl.0,bus=pcie.0,bus_nr=52,uid=0 len-window-base=1,window-base[0]=0x4c0000000 memdev[0]=cxl-mem1

// Single root port
-device cxl rp,id=rp0,bus=cxl.0,addr=0.0,chassis=0,slot=0,memdev=cxl-mem1

// Single type3 device
-device cxl-type3,bus=rp0,memdev=cxl-mem1,id=cxl-pmem0,size=256M -device cxl-type3,bus=rp1,memdev=cxl-mem1,id=cxl-pmem1,size=256M,lsa=cxl-mem1-lsa

---

[1]: https://lore.kernel.org/linux-cxl/20210216014538.268106-1-ben.widawsky@intel.com/
[2]: https://www.computeexpresslink.org/](https://www.computeexpresslink.org/
[3]: https://lore.kernel.org/qemu-devel/20210202005948.241655-1-ben.widawsky@intel.com/
[4]: https://gitlab.com/bwidawsk/qemu/-/tree/cxl-2.0v4
[5]: https://github.com/pmem/ndctl/tree/cxl-2.0v2

Cc: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-nvdimm@lists.01.org
Cc: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Chris Browy <cbrowy@avery-design.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jon Masters <jcm@jonmasters.org>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: "John Groves (jgroves)" <jgroves@micron.com>
Cc: "Kelley, Sean V" <sean.v.kelley@intel.com>

---

Ben Widawsky (7):
  cxl/mem: Find device capabilities
  cxl/mem: Add basic IOCTL interface
  cxl/mem: Add a "RAW" send command
  cxl/mem: Enable commands via CEL
  cxl/mem: Add set of informational commands
  MAINTAINERS: Add maintainers of the CXL driver
  cxl/mem: Add payload dumping for debug

Dan Williams (2):
  cxl/mem: Introduce a driver for CXL-2.0-Type-3 endpoints
  cxl/mem: Register CXL memX devices

 .clang-format                                 |    1 +
 Documentation/ABI/testing/sysfs-bus-cxl       |   26 +
 Documentation/driver-api/cxl/index.rst        |   12 +
 .../driver-api/cxl/memory-devices.rst         |   46 +
 Documentation/driver-api/index.rst            |    1 +
 .../userspace-api/ioctl/ioctl-number.rst      |    1 +
 MAINTAINERS                                   |   11 +
 drivers/Kconfig                               |    1 +
 drivers/Makefile                              |    1 +
 drivers/cxl/Kconfig                           |   66 +
 drivers/cxl/Makefile                          |    7 +
 drivers/cxl/bus.c                             |   29 +
 drivers/cxl/cxl.h                             |   95 +
 drivers/cxl/mem.c                             | 1553 +++++++++++++++++
 drivers/cxl/pci.h                             |   31 +
 include/linux/pci_ids.h                       |    1 +
 include/uapi/linux/cxl_mem.h                  |  172 ++
 17 files changed, 2054 insertions(+)
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
2.30.1

