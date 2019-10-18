Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30BC6DC386
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2019 13:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437791AbfJRLBX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Oct 2019 07:01:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:57262 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2442524AbfJRLBV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Oct 2019 07:01:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D744CAD1A;
        Fri, 18 Oct 2019 11:01:17 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     rubini@gnudd.com, hch@infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     helgaas@kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 2/2] x86/PCI: sta2x11: use default DMA address translation
Date:   Fri, 18 Oct 2019 13:00:44 +0200
Message-Id: <20191018110044.22062-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018110044.22062-1-nsaenzjulienne@suse.de>
References: <20191018110044.22062-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The devices found behind this PCIe chip have unusual DMA mapping
constraints as there is an AMBA interconnect placed in between them and
the different PCI endpoints. The offset between physical memory
addresses and AMBA's view is provided by reading a PCI config register,
which is saved and used whenever DMA mapping is needed.

It turns out that this DMA setup can be represented by properly setting
'dma_pfn_offset', 'dma_bus_mask' and 'dma_mask' during the PCI device
enable fixup. And ultimately allows us to get rid of this device's
custom DMA functions.

Aside from the code deletion and DMA setup, sta2x11_pdev_to_mapping() is
moved to avoid warnings whenever CONFIG_PM is not enabled.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

Changed since v1:
  - use variable to avoid recalculating AMBA's max address
  - remove x86's dma-direct.h as it's not longer needed

Note: This was only compile tested. Also, there was some conversation
      here: https://lkml.org/lkml/2019/10/17/1014, that Christoph might
      have missed as I misspelled his email on v1.

 arch/x86/Kconfig                  |   1 -
 arch/x86/include/asm/device.h     |   3 -
 arch/x86/include/asm/dma-direct.h |   9 --
 arch/x86/pci/sta2x11-fixup.c      | 135 ++++++------------------------
 4 files changed, 26 insertions(+), 122 deletions(-)
 delete mode 100644 arch/x86/include/asm/dma-direct.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index abe822d52167..9c2a51e1cb59 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -708,7 +708,6 @@ config X86_SUPPORTS_MEMORY_FAILURE
 config STA2X11
 	bool "STA2X11 Companion Chip Support"
 	depends on X86_32_NON_STANDARD && PCI
-	select ARCH_HAS_PHYS_TO_DMA
 	select SWIOTLB
 	select MFD_STA2X11
 	select GPIOLIB
diff --git a/arch/x86/include/asm/device.h b/arch/x86/include/asm/device.h
index a8f6c809d9b1..5e12c63b47aa 100644
--- a/arch/x86/include/asm/device.h
+++ b/arch/x86/include/asm/device.h
@@ -6,9 +6,6 @@ struct dev_archdata {
 #if defined(CONFIG_INTEL_IOMMU) || defined(CONFIG_AMD_IOMMU)
 	void *iommu; /* hook for IOMMU specific extension */
 #endif
-#ifdef CONFIG_STA2X11
-	bool is_sta2x11;
-#endif
 };
 
 #if defined(CONFIG_X86_DEV_DMA_OPS) && defined(CONFIG_PCI_DOMAINS)
diff --git a/arch/x86/include/asm/dma-direct.h b/arch/x86/include/asm/dma-direct.h
deleted file mode 100644
index 1a19251eaac9..000000000000
--- a/arch/x86/include/asm/dma-direct.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef ASM_X86_DMA_DIRECT_H
-#define ASM_X86_DMA_DIRECT_H 1
-
-bool dma_capable(struct device *dev, dma_addr_t addr, size_t size);
-dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr);
-phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr);
-
-#endif /* ASM_X86_DMA_DIRECT_H */
diff --git a/arch/x86/pci/sta2x11-fixup.c b/arch/x86/pci/sta2x11-fixup.c
index 6269a175385d..4a631264b809 100644
--- a/arch/x86/pci/sta2x11-fixup.c
+++ b/arch/x86/pci/sta2x11-fixup.c
@@ -30,7 +30,6 @@ struct sta2x11_ahb_regs { /* saved during suspend */
 };
 
 struct sta2x11_mapping {
-	u32 amba_base;
 	int is_suspended;
 	struct sta2x11_ahb_regs regs[STA2X11_NR_FUNCS];
 };
@@ -92,18 +91,6 @@ static int sta2x11_pdev_to_ep(struct pci_dev *pdev)
 	return pdev->bus->number - instance->bus0;
 }
 
-static struct sta2x11_mapping *sta2x11_pdev_to_mapping(struct pci_dev *pdev)
-{
-	struct sta2x11_instance *instance;
-	int ep;
-
-	instance = sta2x11_pdev_to_instance(pdev);
-	if (!instance)
-		return NULL;
-	ep = sta2x11_pdev_to_ep(pdev);
-	return instance->map + ep;
-}
-
 /* This is exported, as some devices need to access the MFD registers */
 struct sta2x11_instance *sta2x11_get_instance(struct pci_dev *pdev)
 {
@@ -111,39 +98,6 @@ struct sta2x11_instance *sta2x11_get_instance(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL(sta2x11_get_instance);
 
-
-/**
- * p2a - Translate physical address to STA2x11 AMBA address,
- *       used for DMA transfers to STA2x11
- * @p: Physical address
- * @pdev: PCI device (must be hosted within the connext)
- */
-static dma_addr_t p2a(dma_addr_t p, struct pci_dev *pdev)
-{
-	struct sta2x11_mapping *map;
-	dma_addr_t a;
-
-	map = sta2x11_pdev_to_mapping(pdev);
-	a = p + map->amba_base;
-	return a;
-}
-
-/**
- * a2p - Translate STA2x11 AMBA address to physical address
- *       used for DMA transfers from STA2x11
- * @a: STA2x11 AMBA address
- * @pdev: PCI device (must be hosted within the connext)
- */
-static dma_addr_t a2p(dma_addr_t a, struct pci_dev *pdev)
-{
-	struct sta2x11_mapping *map;
-	dma_addr_t p;
-
-	map = sta2x11_pdev_to_mapping(pdev);
-	p = a - map->amba_base;
-	return p;
-}
-
 /* At setup time, we use our own ops if the device is a ConneXt one */
 static void sta2x11_setup_pdev(struct pci_dev *pdev)
 {
@@ -151,70 +105,12 @@ static void sta2x11_setup_pdev(struct pci_dev *pdev)
 
 	if (!instance) /* either a sta2x11 bridge or another ST device */
 		return;
-	pci_set_consistent_dma_mask(pdev, STA2X11_AMBA_SIZE - 1);
-	pci_set_dma_mask(pdev, STA2X11_AMBA_SIZE - 1);
-	pdev->dev.archdata.is_sta2x11 = true;
 
 	/* We must enable all devices as master, for audio DMA to work */
 	pci_set_master(pdev);
 }
 DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_STMICRO, PCI_ANY_ID, sta2x11_setup_pdev);
 
-/*
- * The following three functions are exported (used in swiotlb: FIXME)
- */
-/**
- * dma_capable - Check if device can manage DMA transfers (FIXME: kill it)
- * @dev: device for a PCI device
- * @addr: DMA address
- * @size: DMA size
- */
-bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
-{
-	struct sta2x11_mapping *map;
-
-	if (!dev->archdata.is_sta2x11) {
-		if (!dev->dma_mask)
-			return false;
-		return addr + size - 1 <= *dev->dma_mask;
-	}
-
-	map = sta2x11_pdev_to_mapping(to_pci_dev(dev));
-
-	if (!map || (addr < map->amba_base))
-		return false;
-	if (addr + size >= map->amba_base + STA2X11_AMBA_SIZE) {
-		return false;
-	}
-
-	return true;
-}
-
-/**
- * __phys_to_dma - Return the DMA AMBA address used for this STA2x11 device
- * @dev: device for a PCI device
- * @paddr: Physical address
- */
-dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
-{
-	if (!dev->archdata.is_sta2x11)
-		return paddr;
-	return p2a(paddr, to_pci_dev(dev));
-}
-
-/**
- * dma_to_phys - Return the physical address used for this STA2x11 DMA address
- * @dev: device for a PCI device
- * @daddr: STA2x11 AMBA DMA address
- */
-phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr)
-{
-	if (!dev->archdata.is_sta2x11)
-		return daddr;
-	return a2p(daddr, to_pci_dev(dev));
-}
-
-
 /*
  * At boot we must set up the mappings for the pcie-to-amba bridge.
  * It involves device access, and the same happens at suspend/resume time
@@ -234,12 +130,22 @@ phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr)
 /* At probe time, enable mapping for each endpoint, using the pdev */
 static void sta2x11_map_ep(struct pci_dev *pdev)
 {
-	struct sta2x11_mapping *map = sta2x11_pdev_to_mapping(pdev);
+	struct sta2x11_instance *instance = sta2x11_pdev_to_instance(pdev);
+	struct device *dev = &pdev->dev;
+	u32 amba_base, max_amba_addr;
 	int i;
 
-	if (!map)
+	if (!instance)
 		return;
-	pci_read_config_dword(pdev, AHB_BASE(0), &map->amba_base);
+
+	pci_read_config_dword(pdev, AHB_BASE(0), &amba_base);
+	max_amba_addr = amba_base + STA2X11_AMBA_SIZE - 1;
+
+	dev->dma_pfn_offset = PFN_DOWN(-amba_base);
+
+	dev->bus_dma_mask = max_amba_addr;
+	pci_set_consistent_dma_mask(pdev, max_amba_addr);
+	pci_set_dma_mask(pdev, max_amba_addr);
 
 	/* Configure AHB mapping */
 	pci_write_config_dword(pdev, AHB_PEXLBASE(0), 0);
@@ -253,13 +159,24 @@ static void sta2x11_map_ep(struct pci_dev *pdev)
 
 	dev_info(&pdev->dev,
 		 "sta2x11: Map EP %i: AMBA address %#8x-%#8x\n",
-		 sta2x11_pdev_to_ep(pdev),  map->amba_base,
-		 map->amba_base + STA2X11_AMBA_SIZE - 1);
+		 sta2x11_pdev_to_ep(pdev), amba_base, max_amba_addr);
 }
 DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_STMICRO, PCI_ANY_ID, sta2x11_map_ep);
 
 #ifdef CONFIG_PM /* Some register values must be saved and restored */
 
+static struct sta2x11_mapping *sta2x11_pdev_to_mapping(struct pci_dev *pdev)
+{
+	struct sta2x11_instance *instance;
+	int ep;
+
+	instance = sta2x11_pdev_to_instance(pdev);
+	if (!instance)
+		return NULL;
+	ep = sta2x11_pdev_to_ep(pdev);
+	return instance->map + ep;
+}
+
 static void suspend_mapping(struct pci_dev *pdev)
 {
 	struct sta2x11_mapping *map = sta2x11_pdev_to_mapping(pdev);
-- 
2.23.0

