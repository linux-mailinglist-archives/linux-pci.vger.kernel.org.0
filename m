Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8E62DE862
	for <lists+linux-pci@lfdr.de>; Fri, 18 Dec 2020 18:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgLRRlv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Dec 2020 12:41:51 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:37858 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725939AbgLRRlv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Dec 2020 12:41:51 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 50CA9413B4;
        Fri, 18 Dec 2020 17:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1608313266; x=
        1610127667; bh=+3T4fgDTx4QzihcT1rnRpU0LAmsm0zZe0VZuU99zksk=; b=e
        L/0AXkFY6r+uXvGOL1/xJ1t9T1DRlXIHLqD/lzFEA6dXS6iIEn2OXsTip2AAgs7/
        zrtuM6PPfYR6FJF1yM9Sdm6maSXbxf+RY0xFXdKYlMeWI9UzerqSA6E4mpIADBTE
        oAhcmMZfDHf1gTsbJ8Nnz38KhniHvslGeScvx2ri/Q=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pY16fFg217A5; Fri, 18 Dec 2020 20:41:06 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 4D87A4120A;
        Fri, 18 Dec 2020 20:41:05 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 18
 Dec 2020 20:41:05 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Stefan Roese <sr@denx.de>, Andy Lavr <andy.lavr@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v9 00/26] PCI: Allow BAR movement during boot and hotplug
Date:   Fri, 18 Dec 2020 20:39:45 +0300
Message-ID: <20201218174011.340514-1-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.136]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently PCI hotplug works on top of resources which are usually reserved:
by BIOS, bootloader, firmware, or by the kernel (pci=hpmemsize=XM). These
resources are gaps in the address space where BARs of new devices may fit,
and extra bus number per port, so bridges can be hot-added. This series aim
the BARs problem: it shows the kernel how to redistribute them on the run,
so the hotplug becomes predictable and cross-platform. A follow-up patchset
will propose a solution for bus numbers. And another one -- for the powerpc
arch-specific problems.

To arrange a space for BARs of new hot-added devices, the kernel can pause
the drivers of working PCI devices and reshuffle the assigned BARs. When a
driver is un-paused by the kernel, it should ioremap() the new addresses of
its BARs.

Drivers indicate their support of the feature by implementing the new hooks
.bar_fixed(), .rescan_prepare(), .rescan_done() in the struct pci_driver.
If a driver doesn't yet support the feature, BARs of its devices are seen
as immovable and handled in the same way as resources with the PCI_FIXED
flag: they are guaranteed to remain untouched.

This approached was discussed during LPC 2020 [1].

The feature is usable not only for hotplug, but also for booting with a
complete set of BARs assigned, and for Resizable BARs.

Tested on a number of x86_64 machines without any special kernel command
line arguments (some of them -- with older v8 revision of this patchset):
 - PC: i7-5930K + ASUS X99-A;
 - PC: i5-8500 + ASUS Z370-F;
 - PC: AMD Ryzen 7 3700X + ASRock X570 + AMD 5700 XT (Resizable BARs);
 - Supermicro Super Server/H11SSL-i: AMD EPYC 7251;
 - HP ProLiant DL380 G5: Xeon X5460;
 - Dell Inspiron N5010: i5 M 480;
 - Dell Precision M6600: i7-2920XM.

Also tested on a Power8 (Vesnin) and Power9 (Nicole) ppc64le machines, but
with extra patchset, which is to be sent upstream a bit later.

The set contains:
 01-02: Independent bugfixes, both are not related directly to the movable
        BARs feature, but without them the rest of this series will not
	work as expected;

 03-14: Implement the essentials of the feature;

 15-21: Performance improvements for movable BARs and pciehp;

 22: Enable the feature by default;

 23-24: Add movable BARs support to nvme and portdrv;

 25-26: Debugging helpers.

This patchset is a part of our work on adding support for hot-adding
chains of chassis full of other bridges, NVME drives, SAS HBAs, GPUs, etc.
without special requirements such as Hot-Plug Controller, reservation of
bus numbers or memory regions by firmware, etc.

[1] https://linuxplumbersconf.org/event/7/contributions/847/attachments/584/1035/lpc2020_sergmir.pdf
    LPC 2020: VFIO/IOMMU/PCI MC: PCI hotplug: movable BARs and bus numbers

Changes since v8:
 - Fixed support of Resizable BARs, with amdgpu (no changes in the driver);
 - Added a new hook .bar_fixed(), so part of device's BARs can be movable,
   and this new call makes the API a bit cleaner in usage;
 - Memory reservation (via pci=hpmemsize, etc) now works as well;
 - Fix for a race condition (patch 01) has been simplified;
 - Simplified: the .realloc_range field is not needed anymore;
 - Added some debug messages;
 - Compilation warnings, NULL dereference fixed.

Changes since v7:
 - Added some documentation;
 - Replaced every occurrence of the word "immovable" with "fixed";
 - Don't touch PNP, ACPI resources anymore;
 - Replaced double rescan with triple rescan:
   * first try every BAR;
   * if that failed, retry without BARs which weren't assigned before;
   * if that failed, retry without BARs of hotplugged devices;
 - Reassign BARs during boot only if BIOS assigned not all requested BARs;
 - Fixed up PCIBIOS_MIN_MEM instead of ignoring it;
 - Now the feature auto-disables in presence of a transparent bridge;
 - Improved support of runtime PM;
 - Fixed issues with incorrectly released bridge windows;
 - Fixed calculating bridge window size.
 
Changes since v6:
 - Added a fix for hotplug on AMD Epyc + Supermicro H11SSL-i by ignoring
   PCIBIOS_MIN_MEM;
 - Fixed a workaround which marks VGA BARs as immovables;
 - Fixed misleading "can't claim BAR ... no compatible bridge window" error
   messages;
 - Refactored the code, reduced the amount of patches;
 - Exclude PowerPC-specific arch patches, they will be sent separately;
 - Disabled for PowerNV by default - waiting for the PCIPOCALYPSE patchset.
 - Fixed reports from the kbuild test robot.

Changes since v5:
 - Simplified the disable flag, now it is "pci=no_movable_buses";
 - More deliberate marking the BARs as immovable;
 - Mark as immovable BARs which are used by unbound drivers;
 - Ignoring BAR assignment by non-kernel program components, so the kernel
   is able now to distribute BARs in optimal and predictable way;
 - Move here PowerNV-specific patches from the older "powerpc/powernv/pci:
   Make hotplug self-sufficient, independent of FW and DT" series;
 - Fix EEH cache rebuilding and PE allocation for PowerNV during rescan.

Changes since v4:
 - Feature is enabled by default (turned on by one of the latest patches);
 - Add pci_dev_movable_bars_supported(dev) instead of marking the immovable
   BARs with the IORESOURCE_PCI_FIXED flag;
 - Set up PCIe bridges during rescan via sysfs, so MPS settings are now
   configured not only during system boot or pcihp events;
 - Allow movement of switch's BARs if claimed by portdrv;
 - Update EEH address caches after rescan for powerpc;
 - Don't disable completely hot-added devices which can't have BARs being
   fit - just disable their BARs, so they are still visible in lspci etc;
 - Clearer names: fixed_range_hard -> immovable_range, fixed_range_soft ->
   realloc_range;
 - Drop the patch for pci_restore_config_space() - fixed by properly using
   the runtime PM.

Changes since v3:
 - Rebased to the upstream, so the patches apply cleanly again.

Changes since v2:
 - Fixed double-assignment of bridge windows;
 - Fixed assignment of fixed prefetched resources;
 - Fixed releasing of fixed resources;
 - Fixed a debug message;
 - Removed auto-enabling the movable BARs for x86 - let's rely on the
   "pcie_movable_bars=force" option for now;
 - Reordered the patches - bugfixes first.

Changes since v1:
 - Add a "pcie_movable_bars={ off | force }" command line argument;
 - Handle the IORESOURCE_PCI_FIXED flag properly;
 - Don't move BARs of devices which don't support the feature;
 - Guarantee that new hotplugged devices will not steal memory from working
   devices by ignoring the failing new devices with the new PCI_DEV_IGNORE
   flag;
 - Add rescan_prepare()+rescan_done() to the struct pci_driver instead of
   using the reset_prepare()+reset_done() from struct pci_error_handlers;
 - Add a bugfix of a race condition;
 - Fixed hotplug in a non-pre-enabled (by BIOS/firmware) bridge;
 - Fix the compatibility of the feature with pm_runtime and D3-state;
 - Hotplug events from pciehp also can move BARs;
 - Add support of the feature to the NVME driver.

Sergei Miroshnichenko (26):
  PCI: Fix race condition in pci_enable/disable_device()
  PCI: Ensure a bridge has I/O and MEM access for hot-added devices
  PCI: hotplug: Initial support of the movable BARs feature
  PCI: Add version of release_child_resources() aware of fixed BARs
  PCI: hotplug: Fix reassigning the released BARs
  PCI: hotplug: Recalculate every bridge window during rescan
  PCI: hotplug: Don't allow hot-added devices to steal resources
  PCI: Reassign BARs if BIOS/bootloader had assigned not all of them
  PCI: Movable BARs: Make just a single attempt to assign bridge
    resources
  PCI: hotplug: Calculate fixed parts of bridge windows
  PCI: Include fixed BARs into the bus size calculating
  PCI: Make sure bridge windows include their fixed BARs
  PCI: hotplug: Add support of fixed BARs to pci_assign_resource()
  PCI: hotplug: Sort fixed BARs before assignment
  x86/PCI/ACPI: Fix up PCIBIOS_MIN_MEM if value computed from e820 is
    invalid
  PCI: hotplug: Configure MPS after manual bus rescan
  PCI: hotplug: Don't disable the released bridge windows immediately
  PCI: pciehp: Trigger a domain rescan on hp events when enabled movable
    BARs
  PCI: Don't claim fixed BARs
  PCI: hotplug: Retry bus assignment without reserved space
  PCI: Rescan the bus to resize a BAR
  PCI: hotplug: Enable the movable BARs feature by default
  PCI/portdrv: Declare support of movable BARs
  nvme-pci: Handle movable BARs
  PCI: Add a message for updating BARs
  resource: increase max nesting level for /proc/iomem

 Documentation/PCI/pci.rst                     |  63 +++
 .../admin-guide/kernel-parameters.txt         |   1 +
 arch/powerpc/platforms/powernv/pci.c          |   2 +
 arch/powerpc/platforms/pseries/setup.c        |   2 +
 arch/x86/pci/acpi.c                           |  15 +
 drivers/nvme/host/pci.c                       |  27 +-
 drivers/pci/bus.c                             |   2 +-
 drivers/pci/hotplug/pciehp_pci.c              |   5 +
 drivers/pci/iov.c                             |   2 +
 drivers/pci/pci.c                             |  24 ++
 drivers/pci/pci.h                             |  34 ++
 drivers/pci/pcie/portdrv_pci.c                |   7 +
 drivers/pci/probe.c                           | 401 +++++++++++++++++-
 drivers/pci/setup-bus.c                       | 227 +++++++---
 drivers/pci/setup-res.c                       | 105 ++++-
 include/linux/pci.h                           |  16 +
 kernel/resource.c                             |   2 +-
 17 files changed, 863 insertions(+), 72 deletions(-)


base-commit: a409ed156a90093a03fe6a93721ddf4c591eac87
-- 
2.24.1

