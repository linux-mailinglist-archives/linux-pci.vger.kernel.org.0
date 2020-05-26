Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404751E2D03
	for <lists+linux-pci@lfdr.de>; Tue, 26 May 2020 21:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404237AbgEZTNU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 15:13:20 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:45826 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389966AbgEZTNT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2020 15:13:19 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 3A98130D62B;
        Tue, 26 May 2020 12:13:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 3A98130D62B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1590520396;
        bh=+b41cKto7oBml6gbt0P3Uc1iMp9Snf8kHAJBk8ILXSc=;
        h=From:To:Cc:Subject:Date:From;
        b=kMVkvfh2RF6stG81DoEIP5rW2Bb1X314UrWcAaVH2vesNfHDGDr6KhshbNA46ZHix
         7ZwntfMj7r7NDOxK4+O77jSehqnV1xcgzxPORE2AO6ggOOFgMQnDPaBIK+8fl7+mZP
         rhW1OIwreN8UcomYfGhgxrbXcaiUc4E8Vm+33GjA=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 6F1C914008B;
        Tue, 26 May 2020 12:13:13 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Corey Minyard <minyard@acm.org>,
        Dan Williams <dan.j.williams@intel.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE), Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        iommu@lists.linux-foundation.org (open list:DMA MAPPING HELPERS),
        Julien Grall <julien.grall@arm.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PORT),
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)), linux-kernel@vger.kernel.org (open list),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
        Mark Brown <broonie@kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Rob Herring <robh@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa@kernel.org>
Subject: [PATCH v2 00/14] PCI: brcmstb: enable PCIe for STB chips
Date:   Tue, 26 May 2020 15:12:39 -0400
Message-Id: <20200526191303.1492-1-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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

Jim Quinlan (14):
  PCI: brcmstb: PCIE_BRCMSTB depends on ARCH_BRCMSTB
  ata: ahci_brcm: Fix use of BCM7216 reset controller
  dt-bindings: PCI: Add bindings for more Brcmstb chips
  PCI: brcmstb: Add bcm7278 reigister info
  PCI: brcmstb: Add suspend and resume pm_ops
  PCI: brcmstb: Add bcm7278 PERST support
  PCI: brcmstb: Add control of rescal reset
  of: Include a dev param in of_dma_get_range()
  device core: Add ability to handle multiple dma offsets
  arm: dma-mapping: Invoke dma offset func if needed
  PCI: brcmstb: Set internal memory viewport sizes
  PCI: brcmstb: Accommodate MSI for older chips
  PCI: brcmstb: Set bus max burst size by chip type
  PCI: brcmstb: Add bcm7211, bcm7216, bcm7445, bcm7278 to match list

 .../bindings/pci/brcm,stb-pcie.yaml           |  40 +-
 arch/arm/include/asm/dma-mapping.h            |  13 +-
 drivers/ata/ahci_brcm.c                       |  14 +-
 drivers/of/address.c                          |  69 ++-
 drivers/of/device.c                           |   2 +-
 drivers/of/of_private.h                       |   8 +-
 drivers/pci/controller/Kconfig                |   3 +-
 drivers/pci/controller/pcie-brcmstb.c         | 408 +++++++++++++++---
 drivers/usb/core/message.c                    |   3 +
 drivers/usb/core/usb.c                        |   3 +
 include/linux/device.h                        |  10 +-
 include/linux/dma-direct.h                    |  10 +-
 include/linux/dma-mapping.h                   |  46 ++
 kernel/dma/Kconfig                            |  13 +
 14 files changed, 559 insertions(+), 83 deletions(-)

-- 
2.17.1

