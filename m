Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764362F3409
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jan 2021 16:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbhALPSW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jan 2021 10:18:22 -0500
Received: from mga04.intel.com ([192.55.52.120]:33566 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728415AbhALPSW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Jan 2021 10:18:22 -0500
IronPort-SDR: MY0KvRpX5rvgOEFZPGtJ26ZUdQJn2SxK/sIqy7vZ4u9d59Qbb8JkJs9pGADsdsBHYD9a1iW9vS
 1h76eWuH/JrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="175472498"
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400"; 
   d="scan'208";a="175472498"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 07:17:38 -0800
IronPort-SDR: e+WG/q1Fy/owCRmYTgvFlaiYFnOK5mRIUPr8m5ifrxp31x2FqvwB0rFvZEQrpjbu06huSTtuTn
 0g/QO7jRPTQQ==
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400"; 
   d="scan'208";a="381461679"
Received: from rjfugatt-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.129.188])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 07:17:37 -0800
Date:   Tue, 12 Jan 2021 07:17:35 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     =?utf-8?B?5YiY5LmQ5LmQKOS5kOS6hik=?= <daniel.lll@alibaba-inc.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Xu, Di" <di.x@alibaba-inc.com>
Subject: Re: [RFC PATCH v3 00/16] CXL 2.0 Support
Message-ID: <20210112151735.w45qbi37pc3zuucw@intel.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
 <0f2a6d62-09d8-416f-e972-3e9869c3e1a6@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f2a6d62-09d8-416f-e972-3e9869c3e1a6@alibaba-inc.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-01-12 22:55:50, 刘乐乐(乐了) wrote:
> Ben,
> 
> Thanks for your hard work. I have compiled this patch(aff2b059786d ,
> cxl-2.0v3) together qemu emulator v3, this is the first time I see a CXL
> device in linux.
> 
> Still I have problems, I can saw the CXL device with `lspci -vvv`  and a
> device /dev/cxl/mem0 . But I can't see the memory in system and lsmem
> command.
> 
> Qemu command line is :
> 
> sudo ./qemu-cxl/build/qemu-system-x86_64 -enable-kvm -smp 8 -drive
> file=/mnt/lele/vm/cxl-centos8-uefi.qcow2,format=qcow2,cache=none -drive if=pflash,format=raw,unit=0,file=/mnt/lele/edk2/usr/share/edk2-ovmf/x64/OVMF_CODE.fd,readonly=on
> -drive if=pflash,format=raw,readonly,unit=1,file=/mnt/lele/edk2/usr/share/edk2-ovmf/x64/OVMF_VARS.fd
> -m 32G -vnc :12 -machine type=pc-q35-4.0,hmat=on,accel=kvm -net nic -net
> tap,ifname=tap1,script=/mnt/lele/vm/qemu-ifup,downscript=no -object memory-backend-file,id=cxl-mem1,share,mem-path=/mnt/lele/cxl-mem.dat,size=512M
> -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52,uid=0,len-window-base=1,window-base[0]=0x4c0000000,memdev[0]=cxl-mem1
> -device cxl-rp,id=rp0,bus=cxl.0,addr=0.0,chassis=0,slot=0 -device
> cxl-type3,bus=rp0,memdev=cxl-mem1,id=cxl-pmem0,size=256M
> 
> So, what's the further step to show the memory in system memory?

The code to actually find the memory region and make the OS aware of it isn't
yet present. It's next on the list of things to work on in fact. You can look
for that in v4.

With QEMU patches in my gitlab, the memory isn't even made a region. There is a
#define you can set:
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index dee5a8884b..60c774840e 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -13,6 +13,8 @@
 #include "sysemu/hostmem.h"
 #include "hw/cxl/cxl.h"

+#define SET_PMEM_ADDR
+
 typedef struct cxl_type3_dev {
     /* Private */
     PCIDevice parent_obj;

With that, even though you won't see the range in Linux, the memory device
should work if you send cycles to the address range at 0x4c0000000.

Thanks.
Ben

> 
> 
> Thanks,
> Daniel
> 
> 在 2021/1/12 6:51, Ben Widawsky 写道:
> > Changes since v2 [1]
> > 
> >    - Rebased onto v5.11-rc2
> >    - fixes for sparse (Ben)
> >    - Add (and modify) IOCTL number to ioctl-number.rst. (Randy)
> >    - Change @enable to @flags with enable field. (Dan)
> >    - Move command "name" to UAPI enum. (Dan)
> >    - Make command array use designated initializer. (Dan)
> >    - Avoid copies to/from payload registers (Ben)
> >    - Actually write the input payload length (Ben)
> >    - Return ENOTTY instead of EINVAL for missing Send command. (Dan)
> >    - Keep device locked and pinned during send commands. (Dan)
> >    - Validate input payload size doesn't exceed hardware's limit. (Ben)
> >    - Get rid of TAINT flag in UAPI. (Dan)
> >    - Spelling fixes. (Dan)
> >    - Document things that must be zero. (Dan)
> >    - Use new TAINT (Dan)
> >    - Replace cxl_debug with dev_debug (Dan)
> >      - Squash debug info into relevant patches (Ben)
> >    - Put CXL_CMD on a diet, #define the opcodes (Dan)
> >    - Switch mailbox sync from spinlock to mutex (Ben)
> >    - Store off (and debug print) hardware's payload size (Ben)
> >    - Fix length of GENMASK for mailbox payload (Ben)
> >    - Create concept of enabled commands. (Ben)
> >    - Use CEL to enable commands based on hardware. (Ben)
> >    - Move command struct definitions into mem.c (Ben)
> >    - Create concept of hidden commands, and kernel only commands (Ben)
> >    - Add payload min to sysfs (Ben)
> > 
> > ---
> > 
> > The patches can be found here:
> > https://gitlab.com/bwidawsk/linux/-/commits/cxl-2.0v3
> > I've also created #cxl on oftc for any discussion.
> > 
> > ---
> > 
> > Introduce support for “type-3” memory devices defined in the recently released
> > Compute Express Link (CXL) 2.0 specification[2]. Specifically, these are the
> > memory devices defined by section 8.2.8.5 of the CXL 2.0 spec. A reference
> > implementation emulating these devices has been submitted to the QEMU mailing
> > list [3] and is available on gitlab [4]. “Type-3” is a CXL device that acts as a
> > memory expander for RAM or PMEM. It might be interleaved with other CXL devices
> > in a given physical address range.
> > 
> > These changes allow for foundational enumeration of CXL 2.0 memory devices as
> > well as basic userspace interaction. The functionality present is:
> > - Initial driver bring-up
> > - Device enumeration and an initial sysfs representation
> > - Submit a basic firmware command via ‘mailbox’ to an emulated memory device
> >    with non-volatile capacity.
> > - Provide an interface to send commands to the hardware.
> > 
> > Some of the functionality that is still missing includes:
> > - Memory interleaving at the host bridge, root port, or switch level
> > - CXL 1.1 Root Complex Integrated Endpoint Support
> > - CXL 2.0 Hot plug support
> > - A bevy of supported device commands
> > 
> > In addition to the core functionality of discovering the spec defined registers
> > and resources, introduce a CXL device model that will be the foundation for
> > translating CXL capabilities into existing Linux infrastructure for Persistent
> > Memory and other memory devices. For now, this only includes support for the
> > management command mailbox that type-3 devices surface. These control devices
> > fill the role of “DIMMs” / nmemX memory-devices in LIBNVDIMM terms.
> > 
> > Now, while implementing the driver some feedback for the specification was
> > generated to cover perceived gaps and address conflicts. The feedback is
> > presented as a reference implementation in the driver and QEMU emulation.
> > Specifically the following concepts are original to the Linux implementation and
> > feedback / collaboration is requested to develop these into specification
> > proposals:
> > 1. Top level ACPI object (ACPI0017)
> > 2. HW imposed address space and interleave constraints
> > 
> > ACPI0017
> > --------
> > Introduce a new ACPI namespace device with an _HID of ACPI0017. The purpose of
> > this object is twofold, support a legacy OS with a set of out-of-tree CXL
> > modules, and establish an attach point for a driver that knows about
> > interleaving. Both of these boil down to the same point, to centralize Operating
> > System support for resources described by the CXL Early Discovery Table (CEDT).
> > 
> > The legacy OS problem stems from the spec's description of a host bridge,
> > ACPI0016 is denoted as the _HID for host bridges, with a _CID of PNP0A08. In a
> > CXL unaware version of Linux, the core ACPI subsystem will bind a driver to
> > PNP0A08 and preclude a CXL-aware driver from binding to ACPI0016. An ACPI0017
> > device allows a standalone CXL-aware driver to register for handling /
> > coordinating CEDT and CXL-specific _OSC control.
> > 
> > Similarly when managing interleaving there needs to be some management layer
> > above the ACPI0016 device that is capable of assembling leaf nodes into
> > interleave sets. As is the case with ACPI0012 that does this central
> > coordination for NFIT defined resources, ACPI0017 does the same for CEDT
> > described resources.
> > 
> > Memory Windows
> > -------
> > For CXL.mem capable platforms, there is a need for a mechanism for platform
> > firmware to make the Operating System aware of any restrictions that hardware
> > might have in address space. For example, in a system with 4 host bridges all
> > participating in an interleave set, the firmware needs to provide some
> > description of this. That information is missing from the CXL 2.0 spec as of
> > today and it also is not implemented in the driver. A variety of ACPI based
> > mechanisms, for example _CRS fields on the ACPI0017 device, were considered.
> > 
> > Next steps after this basic foundation is expanded command support and LIBNVDIMM
> > integration. This is the initial “release early / release often” version of the
> > Linux CXL enabling.
> > 
> > [1]: https://lore.kernel.org/linux-cxl/20201209002418.1976362-1-ben.widawsky@intel.com/
> > [2]: https://www.computeexpresslink.org/
> > [3]: https://lore.kernel.org/qemu-devel/20210105165323.783725-1-ben.widawsky@intel.com/T/#t
> > [4]: https://gitlab.com/bwidawsk/qemu/-/tree/cxl-2.0v2
> > 
> > Ben Widawsky (12):
> >    docs: cxl: Add basic documentation
> >    cxl/mem: Map memory device registers
> >    cxl/mem: Find device capabilities
> >    cxl/mem: Implement polled mode mailbox
> >    cxl/mem: Add basic IOCTL interface
> >    cxl/mem: Add send command
> >    taint: add taint for direct hardware access
> >    cxl/mem: Add a "RAW" send command
> >    cxl/mem: Create concept of enabled commands
> >    cxl/mem: Use CEL for enabling commands
> >    cxl/mem: Add limited Get Log command (0401h)
> >    MAINTAINERS: Add maintainers of the CXL driver
> > 
> > Dan Williams (2):
> >    cxl/mem: Introduce a driver for CXL-2.0-Type-3 endpoints
> >    cxl/mem: Register CXL memX devices
> > 
> > Vishal Verma (2):
> >    cxl/acpi: Add an acpi_cxl module for the CXL interconnect
> >    cxl/acpi: add OSC support
> > 
> >   .clang-format                                 |    1 +
> >   Documentation/ABI/testing/sysfs-bus-cxl       |   26 +
> >   Documentation/admin-guide/sysctl/kernel.rst   |    1 +
> >   Documentation/admin-guide/tainted-kernels.rst |    6 +-
> >   Documentation/cxl/index.rst                   |   12 +
> >   Documentation/cxl/memory-devices.rst          |   51 +
> >   Documentation/index.rst                       |    1 +
> >   .../userspace-api/ioctl/ioctl-number.rst      |    1 +
> >   MAINTAINERS                                   |   10 +
> >   drivers/Kconfig                               |    1 +
> >   drivers/Makefile                              |    1 +
> >   drivers/base/core.c                           |   14 +
> >   drivers/cxl/Kconfig                           |   58 +
> >   drivers/cxl/Makefile                          |    9 +
> >   drivers/cxl/acpi.c                            |  351 ++++
> >   drivers/cxl/acpi.h                            |   35 +
> >   drivers/cxl/bus.c                             |   54 +
> >   drivers/cxl/bus.h                             |    8 +
> >   drivers/cxl/cxl.h                             |  147 ++
> >   drivers/cxl/mem.c                             | 1475 +++++++++++++++++
> >   drivers/cxl/pci.h                             |   34 +
> >   include/acpi/actbl1.h                         |   50 +
> >   include/linux/device.h                        |    1 +
> >   include/linux/kernel.h                        |    3 +-
> >   include/uapi/linux/cxl_mem.h                  |  168 ++
> >   kernel/panic.c                                |    1 +
> >   26 files changed, 2517 insertions(+), 2 deletions(-)
> >   create mode 100644 Documentation/ABI/testing/sysfs-bus-cxl
> >   create mode 100644 Documentation/cxl/index.rst
> >   create mode 100644 Documentation/cxl/memory-devices.rst
> >   create mode 100644 drivers/cxl/Kconfig
> >   create mode 100644 drivers/cxl/Makefile
> >   create mode 100644 drivers/cxl/acpi.c
> >   create mode 100644 drivers/cxl/acpi.h
> >   create mode 100644 drivers/cxl/bus.c
> >   create mode 100644 drivers/cxl/bus.h
> >   create mode 100644 drivers/cxl/cxl.h
> >   create mode 100644 drivers/cxl/mem.c
> >   create mode 100644 drivers/cxl/pci.h
> >   create mode 100644 include/uapi/linux/cxl_mem.h
> > 
