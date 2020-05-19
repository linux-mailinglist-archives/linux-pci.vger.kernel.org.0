Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75AB91DA2A5
	for <lists+linux-pci@lfdr.de>; Tue, 19 May 2020 22:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgESUeq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 May 2020 16:34:46 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:34958 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725885AbgESUep (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 May 2020 16:34:45 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 02B4730D7BF;
        Tue, 19 May 2020 13:33:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 02B4730D7BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1589920402;
        bh=yuPEfulO+iRK9pTGrG+3vEVTPxwnaY2RYoFKfJNpl/4=;
        h=From:To:Cc:Subject:Date:From;
        b=BGCCEXGcLPBUG5WcSDFpUnH7X6Scj2cn6JSilSFImuyVpUvNUEbcGLaTqCiJFjL3K
         RC/aTNSU30qAdciwtiidWHRIF/dypocgc+fxv9lyMCer+wWJgYag7fmkpvdu32QtpX
         rTr1Zk1rKZs1p0VraKIQ5wSOx8XgHzb84gj4JsY0=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 4463514008B;
        Tue, 19 May 2020 13:34:42 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     james.quinlan@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        Dan Williams <dan.j.williams@intel.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE), Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        iommu@lists.linux-foundation.org (open list:DMA MAPPING HELPERS),
        Julien Grall <julien.grall@arm.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PORT),
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)), linux-kernel@vger.kernel.org (open list),
        linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND
        ENDPOINT DRIVERS),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Rob Herring <robh@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 00/15] PCI: brcmstb: enable PCIe for STB chips
Date:   Tue, 19 May 2020 16:33:58 -0400
Message-Id: <20200519203419.12369-1-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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

Jim Quinlan (15):
  PCI: brcmstb: PCIE_BRCMSTB depends on ARCH_BRCMSTB
  ahci_brcm: fix use of BCM7216 reset controller
  dt-bindings: PCI: Add bindings for more Brcmstb chips
  PCI: brcmstb: Add compatibily of other chips
  PCI: brcmstb: Add suspend and resume pm_ops
  PCI: brcmstb: Asserting PERST is different for 7278
  PCI: brcmstb: Add control of rescal reset
  of: Include a dev param in of_dma_get_range()
  device core: Add ability to handle multiple dma offsets
  dma-direct: Invoke dma offset func if needed
  arm: dma-mapping: Invoke dma offset func if needed
  PCI: brcmstb: Set internal memory viewport sizes
  PCI: brcmstb: Accommodate MSI for older chips
  PCI: brcmstb: Set bus max burst side by chip type
  PCI: brcmstb: add compatilbe chips to match list

 .../bindings/pci/brcm,stb-pcie.yaml           |  40 +-
 arch/arm/include/asm/dma-mapping.h            |  17 +-
 drivers/ata/ahci_brcm.c                       |  14 +-
 drivers/of/address.c                          |  54 ++-
 drivers/of/device.c                           |   2 +-
 drivers/of/of_private.h                       |   8 +-
 drivers/pci/controller/Kconfig                |   4 +-
 drivers/pci/controller/pcie-brcmstb.c         | 403 +++++++++++++++---
 include/linux/device.h                        |   9 +-
 include/linux/dma-direct.h                    |  16 +
 include/linux/dma-mapping.h                   |  44 ++
 kernel/dma/Kconfig                            |  12 +
 12 files changed, 542 insertions(+), 81 deletions(-)

-- 
2.17.1

