Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5281F01AB
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jun 2020 23:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgFEV1S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jun 2020 17:27:18 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:38280 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726664AbgFEV1Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Jun 2020 17:27:16 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 6323F30D861;
        Fri,  5 Jun 2020 14:27:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 6323F30D861
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1591392435;
        bh=X1W5SBPglzGt+7ug7Z7PzaYs1FBERzpHlpxJDJ5NWW8=;
        h=From:To:Cc:Subject:Date:From;
        b=Yb7tCCTq3tEKqFK78fQleMf0F7oKo2GNKiGeJff4TJ8HjbO4U5hKMcBn5a/50b9QL
         ASYiSDzdEAdFQtERUZgBWiULuxpC0aChlTLqu6cf55XS6z7yAfcc69QKiYMK0Af9yd
         IC6UDRFn5YTpfAE57XQgz5wCaInS2sD8nKRoPv6w=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id C1CD7140069;
        Fri,  5 Jun 2020 14:27:11 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        David Kershner <david.kershner@unisys.com>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR ALLWINNER
        A10), Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        iommu@lists.linux-foundation.org (open list:IOMMU DRIVERS),
        Jens Axboe <axboe@kernel.dk>,
        Julien Grall <julien.grall@arm.com>,
        linux-acpi@vger.kernel.org (open list:ACPI FOR ARM64 (ACPI/arm64)),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PORT),
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)), linux-kernel@vger.kernel.org (open list),
        linux-media@vger.kernel.org (open list:ALLWINNER A10 CSI DRIVER),
        linux-remoteproc@vger.kernel.org (open list:REMOTE PROCESSOR
        (REMOTEPROC) SUBSYSTEM),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-sh@vger.kernel.org (open list:SUPERH),
        linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
        Mark Brown <broonie@kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Rob Herring <robh@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v4 00/12] PCI: brcmstb: enable PCIe for STB chips
Date:   Fri,  5 Jun 2020 17:26:40 -0400
Message-Id: <20200605212706.7361-1-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


v4:
  Commit "device core: Introduce multiple dma pfn offsets"
  -- of_dma_get_range() does not take a dev param but instead
     takes two "out" params: map and map_size.  We do this so
     that the code that parses dma-ranges is separate from
     the code that modifies 'dev'.   (Nicolas)
  -- the separate case of having a single pfn offset has
     been removed and is now processed by going through the
     map array. (Nicolas)
  -- move attach_uniform_dma_pfn_offset() from of/address.c to
     dma/mapping.c so that it does not depend on CONFIG_OF. (Nicolas)
  -- devm_kcalloc => devm_kzalloc (DanC)
  -- add/fix assignment to dev->dma_pfn_offset_map for func
     attach_uniform_dma_pfn_offset() (DanC, Nicolas)
  -- s/struct dma_pfn_offset_region/struct bus_dma_region/ (Nicolas)
  -- s/attach_uniform_dma_pfn_offset/dma_attach_uniform_pfn_offset/
  -- s/attach_dma_pfn_offset_map/dma_attach_pfn_offset_map/
  -- More use of PFN_{PHYS,DOWN,UP}. (AndyS)
  Commit "of: Include a dev param in of_dma_get_range()"
  -- this commit was sqaushed with "device core: Introduce ..."

v3:
  Commit "device core: Introduce multiple dma pfn offsets"
  Commit "arm: dma-mapping: Invoke dma offset func if needed"
  -- The above two commits have been squashed.  More importantly,
     the code has been modified so that the functionality for
     multiple pfn offsets subsumes the use of dev->dma_pfn_offset.
     In fact, dma_pfn_offset is removed and supplanted by
     dma_pfn_offset_map, which is a pointer to an array.  The
     more common case of a uniform offset is now handled as
     a map with a single entry, while cases requiring multiple
     pfn offsets use a map with multiple entries.  Code paths
     that used to do this:

         dev->dma_pfn_offset = mydrivers_pfn_offset;

     have been changed to do this:

         attach_uniform_dma_pfn_offset(dev, pfn_offset);

  Commit "dt-bindings: PCI: Add bindings for more Brcmstb chips"
  -- Add if/then clause for required props: resets, reset-names (RobH)
  -- Change compatible list from const to enum (RobH)
  -- Change list of u32-tuples to u64 (RobH)

  Commit "of: Include a dev param in of_dma_get_range()"
  -- modify of/unittests.c to add NULL param in of_dma_get_range() call.

  Commit "device core: Add ability to handle multiple dma offsets"
  -- align comment in device.h (AndyS).
  -- s/cpu_beg/cpu_start/ and s/dma_beg/dma_start/ in struct
     dma_pfn_offset_region (AndyS).

v2:
Commit: "device core: Add ability to handle multiple dma offsets"
  o Added helper func attach_dma_pfn_offset_map() in address.c (Chistoph)
  o Helpers funcs added to __phys_to_dma() & __dma_to_phys() (Christoph)
  o Added warning when multiple offsets are needed and !DMA_PFN_OFFSET_MAP
  o dev->dma_pfn_map => dev->dma_pfn_offset_map
  o s/frm/from/ for dma_pfn_offset_frm_{phys,dma}_addr() (Christoph)
  o In device.h: s/const void */const struct dma_pfn_offset_region */
  o removed 'unlikely' from unlikely(dev->dma_pfn_offset_map) since
    guarded by CONFIG_DMA_PFN_OFFSET_MAP (Christoph)
  o Since dev->dma_pfn_offset is copied in usb/core/{usb,message}.c, now
    dev->dma_pfn_offset_map is copied as well.
  o Merged two of the DMA commits into one (Christoph).

Commit "arm: dma-mapping: Invoke dma offset func if needed":
  o Use helper functions instead of #if CONFIG_DMA_PFN_OFFSET

Other commits' changes:
  o Removed need for carrying of_id var in priv (Nicolas)
  o Commit message rewordings (Bjorn)
  o Commit log messages filled to 75 chars (Bjorn)
  o devm_reset_control_get_shared())
    => devm_reset_control_get_optional_shared (Philipp)
  o Add call to reset_control_assert() in PCIe remove routines (Philipp)

v1:
This patchset expands the usefulness of the Broadcom Settop Box PCIe
controller by building upon the PCIe driver used currently by the
Raspbery Pi.  Other forms of this patchset were submitted by me years
ago and not accepted; the major sticking point was the code required
for the DMA remapping needed for the PCIe driver to work [1].

There have been many changes to the DMA and OF subsystems since that
time, making a cleaner and less intrusive patchset possible.  This
patchset implements a generalization of "dev->dma_pfn_offset", except
that instead of a single scalar offset it provides for multiple
offsets via a function which depends upon the "dma-ranges" property of
the PCIe host controller.  This is required for proper functionality
of the BrcmSTB PCIe controller and possibly some other devices.

[1] https://lore.kernel.org/linux-arm-kernel/1516058925-46522-5-git-send-email-jim2101024@gmail.com/

Jim Quinlan (12):
  PCI: brcmstb: PCIE_BRCMSTB depends on ARCH_BRCMSTB
  ata: ahci_brcm: Fix use of BCM7216 reset controller
  dt-bindings: PCI: Add bindings for more Brcmstb chips
  PCI: brcmstb: Add bcm7278 register info
  PCI: brcmstb: Add suspend and resume pm_ops
  PCI: brcmstb: Add bcm7278 PERST support
  PCI: brcmstb: Add control of rescal reset
  device core: Introduce multiple dma pfn offsets
  PCI: brcmstb: Set internal memory viewport sizes
  PCI: brcmstb: Accommodate MSI for older chips
  PCI: brcmstb: Set bus max burst size by chip type
  PCI: brcmstb: Add bcm7211, bcm7216, bcm7445, bcm7278 to match list

 .../bindings/pci/brcm,stb-pcie.yaml           |  58 ++-
 arch/arm/include/asm/dma-mapping.h            |   9 +-
 arch/arm/mach-keystone/keystone.c             |   9 +-
 arch/sh/drivers/pci/pcie-sh7786.c             |   3 +-
 arch/sh/kernel/dma-coherent.c                 |  14 +-
 arch/x86/pci/sta2x11-fixup.c                  |   7 +-
 drivers/acpi/arm64/iort.c                     |   5 +-
 drivers/ata/ahci_brcm.c                       |  14 +-
 drivers/gpu/drm/sun4i/sun4i_backend.c         |   5 +-
 drivers/iommu/io-pgtable-arm.c                |   2 +-
 .../platform/sunxi/sun4i-csi/sun4i_csi.c      |   5 +-
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      |   4 +-
 drivers/of/address.c                          |  72 +++-
 drivers/of/device.c                           |  19 +-
 drivers/of/of_private.h                       |  11 +-
 drivers/of/unittest.c                         |   8 +-
 drivers/pci/controller/Kconfig                |   3 +-
 drivers/pci/controller/pcie-brcmstb.c         | 408 +++++++++++++++---
 drivers/remoteproc/remoteproc_core.c          |   2 +-
 .../staging/media/sunxi/cedrus/cedrus_hw.c    |   7 +-
 drivers/usb/core/message.c                    |   4 +-
 drivers/usb/core/usb.c                        |   2 +-
 include/linux/device.h                        |   4 +-
 include/linux/dma-direct.h                    |  16 +-
 include/linux/dma-mapping.h                   |  38 ++
 kernel/dma/coherent.c                         |  11 +-
 kernel/dma/mapping.c                          |  38 ++
 27 files changed, 647 insertions(+), 131 deletions(-)

-- 
2.17.1

