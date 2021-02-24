Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D522932365D
	for <lists+linux-pci@lfdr.de>; Wed, 24 Feb 2021 05:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbhBXEHA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Feb 2021 23:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbhBXEGt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Feb 2021 23:06:49 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65185C0617A7
        for <linux-pci@vger.kernel.org>; Tue, 23 Feb 2021 20:05:42 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id s8so830278edd.5
        for <linux-pci@vger.kernel.org>; Tue, 23 Feb 2021 20:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=hmwsW/hf6/2eNzJ4EGL8BqxVfyFIYIQmZsJ1d9wI35s=;
        b=V2OwGNpjZM3cH+Ci1gP9V+sU0EEQLoI8bMChDK6jv/XeY+2prCQEhzVTk3OiOcpO4X
         FG6fepE7DKhQWWNJQB4PN5nzUd8Z4f+3g6WpAGoTHev0uGpt4LGdZXrmOecbK/IkZIyX
         fBuRmeRZbdHp7EXBsfJOUrWvVt5H44gLttBjCFMm7G4237ZsmZCrWSceYgt3K0FOZTtN
         fL52IdG+ooqOL/TiDnhKsXn/VHZIQYACBKkC1IiE0QTl4+fNgmyquSLbAzM+LSilIshg
         UVrEHp8AvmFt5kNYZE1SZ4VhZTwxVmgcZW2/FY/YY2mbjMzNOnuSOQCvdVr24a6rd7w0
         Ug2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hmwsW/hf6/2eNzJ4EGL8BqxVfyFIYIQmZsJ1d9wI35s=;
        b=isi1yIi0ksym3vFW4HZ1LvL5bc5qA5mZx07m/MjO7sm6bTqE6qCLVZjExtPcbh708I
         7tFKHF0d71RpWgbueB1IzIt32vv3SnJKK0s1IpOO3Sm1lH6JAN63S4/KeC8m3GiZMfOp
         Em/rEPjfxJJpAoEl6Qcg6g5EIL8IavZ4/L2d6+AZ5fPFcleBRejFHCd2YtVD4tkezgqA
         eNigkSECj9s4yabyUGsK6GQFJekhteJNxWhshJmrdHdD6xb5HfQ1pI6TjlzxJEXciuBC
         BTajgzj2wZ59ofYRkhW/9HWNo8ISVH2z2R4kx64i6c5w19jryCu7h+XbqUacSmmACrnW
         vjeQ==
X-Gm-Message-State: AOAM531wZtzKs+aXz8ehFJ5DrVXqQ5V3fIvi5ZNm79UtNx2rbNyXFDQz
        iHjxbtD9WN8XZcgM3c/pna1wogfWt/OamRfbkcDv5g==
X-Google-Smtp-Source: ABdhPJyyMXiElO804i+nVnIKVghScSNY8WXhEcoxqmt+bxh74dj5khIOevOokzp6nvoTt0Vm4in3WgBzIM7gGBXJHZE=
X-Received: by 2002:aa7:d315:: with SMTP id p21mr29659333edq.300.1614139540770;
 Tue, 23 Feb 2021 20:05:40 -0800 (PST)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Feb 2021 20:05:36 -0800
Message-ID: <CAPcyv4gsXbi6Cc71wW5hob8mGuupXKkL5tHLRaZkdLZ1oAuK8Q@mail.gmail.com>
Subject: [GIT PULL] Compute Express Linux (CXL) for v5.12-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/cxl-for-5.12

...to receive an initial driver for CXL 2.0 Memory Devices. Technical
details are in the tag message and Documentation/. I am taking this
through nvdimm.git this first cycle until the cxl.git repository and
maintainer team can be set up on git.kernel.org.

In terms of why merge this initial driver now, it establishes just
enough functionality to enumerate these devices and issue all
administrative commands. It sets a v5.12 baseline to develop the more
complicated higher order functionality like memory device
interleaving, persistent memory support, and hotplug which entangle
with ACPI, LIBNVDIMM, and PCI.

The focus of this release is establishing the ioctl UAPI for the
management commands. Similar to NVME there are a set of standard
commands as well as the possibility for vendor specific commands.
Unlike the NVME driver the CXL driver does not enable vendor specific
command functionality by default. This conservatism is out of concern
for the fact that CXL interleaves memory across devices and implements
host memory. The system integrity implications of some commands are
more severe than NVME and vendor specific functionality is mostly
unauditable. This will be an ongoing topic of discussion with the
wider CXL community for next few months.

The driver has been developed in the open since November against a
work-in-progress QEMU emulation of the CXL device model. That QEMU
effort has recently attracted contributions from multiple hardware
vendors.

The driver has appeared in -next. It collected some initial static
analysis fixes and build-robot reports, but all quiet in -next for the
past week.

A list of review tags that arrived after the branch for -next was cut
is appended to the tag message below.

---

The following changes since commit 1048ba83fb1c00cd24172e23e8263972f6b5d9ac:

  Linux 5.11-rc6 (2021-01-31 13:50:09 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/cxl-for-5.12

for you to fetch changes up to 88ff5d466c0250259818f3153dbdc4af1f8615dd:

  cxl/mem: Fix potential memory leak (2021-02-22 14:44:39 -0800)

----------------------------------------------------------------
cxl for 5.12

Introduce an initial driver for CXL 2.0 Type-3 Memory Devices. CXL is
Compute Express Link which released the 2.0 specification in November.
The Linux relevant changes in CXL 2.0 are support for an OS to
dynamically assign address space to memory devices, support for
switches, persistent memory, and hotplug. A Type-3 Memory Device is a
PCI enumerated device presenting the CXL Memory Device Class Code and
implementing the CXL.mem protocol. CXL.mem allows device to advertise
CPU and I/O coherent memory to the system, i.e. typical "System RAM" and
"Persistent Memory" in Linux /proc/iomem terms.

In addition to the CXL.mem fast path there is an administrative command
hardware mailbox interface for maintenance and provisioning. It is this
command interface that is the focus of the initial driver. With this
driver a CXL device that is mapped by the BIOS can be administered by
Linux. Linux support for CXL PMEM and dynamic CXL address space
management are to be implemented post v5.12.

4cdadfd5e0a7 cxl/mem: Introduce a driver for CXL-2.0-Type-3 endpoints
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

8adaf747c9f0 cxl/mem: Find device capabilities
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

b39cb1052a5c cxl/mem: Register CXL memX devices
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

13237183c735 cxl/mem: Add a "RAW" send command
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

472b1ce6e9d6 cxl/mem: Enable commands via CEL
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

57ee605b976c cxl/mem: Add set of informational commands
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

----------------------------------------------------------------
Ben Widawsky (7):
      cxl/mem: Find device capabilities
      cxl/mem: Add basic IOCTL interface
      cxl/mem: Add a "RAW" send command
      cxl/mem: Enable commands via CEL
      cxl/mem: Add set of informational commands
      MAINTAINERS: Add maintainers of the CXL driver
      cxl/mem: Fix potential memory leak

Dan Carpenter (1):
      cxl/mem: Return -EFAULT if copy_to_user() fails

Dan Williams (2):
      cxl/mem: Introduce a driver for CXL-2.0-Type-3 endpoints
      cxl/mem: Register CXL memX devices

 .clang-format                                      |    1 +
 Documentation/ABI/testing/sysfs-bus-cxl            |   26 +
 Documentation/driver-api/cxl/index.rst             |   12 +
 Documentation/driver-api/cxl/memory-devices.rst    |   46 +
 Documentation/driver-api/index.rst                 |    1 +
 Documentation/userspace-api/ioctl/ioctl-number.rst |    1 +
 MAINTAINERS                                        |   11 +
 drivers/Kconfig                                    |    1 +
 drivers/Makefile                                   |    1 +
 drivers/cxl/Kconfig                                |   53 +
 drivers/cxl/Makefile                               |    7 +
 drivers/cxl/bus.c                                  |   29 +
 drivers/cxl/cxl.h                                  |   95 ++
 drivers/cxl/mem.c                                  | 1552 ++++++++++++++++++++
 drivers/cxl/pci.h                                  |   31 +
 include/linux/pci_ids.h                            |    1 +
 include/uapi/linux/cxl_mem.h                       |  172 +++
 17 files changed, 2040 insertions(+)
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
