Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C3323ADB6
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 21:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgHCTqF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 15:46:05 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:40144 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728448AbgHCTqE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2020 15:46:04 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id C118430C149;
        Mon,  3 Aug 2020 12:44:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com C118430C149
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1596483875;
        bh=1EHDgk40/Aa+4zbPiQtcmu4xZYbFGPkFfGJE7AaKWjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hKoQokvIqw/z3XxFgY/KYWnGnN7E3q1PYUYcAkGAbHZSHfH6c1OMTK5HYrYU91i0f
         Ivq0kKy+n23kG8gJPkU9TMSrjps//xMRzBmjr1xXonpYXOmhK43VYEhGgsYZdCCrEc
         GYkc9zq56dyXxg73XZUgj60twJsJ7ZKQrdH9+MpE=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 23C0A14008C;
        Mon,  3 Aug 2020 12:46:01 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 08/11] PCI: brcmstb: Set additional internal memory DMA viewport sizes
Date:   Mon,  3 Aug 2020 15:45:13 -0400
Message-Id: <20200803194529.32357-9-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200803194529.32357-1-james.quinlan@broadcom.com>
References: <20200803194529.32357-1-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Raspberry Pi (RPI) is currently the only chip using this driver
(pcie-brcmstb.c).  There, only one memory controller is used, without an
extension region, and the SCB0 viewport size is set to the size of the
first and only dma-range region.  Other BrcmSTB SOCs have more complicated
memory configurations that require setting additional viewport sizes.

BrcmSTB PCIe controllers are intimately connected to the memory
controller(s) on the SOC.  The SOC may have one to three memory
controllers; they are indicated by the term SCBi.  Each controller has a
base region and an optional extension region.  In physical memory, the base
and extension regions of a controller are not adjacent, but in PCIe-space
they are.

There is a "viewport" for each memory controller that allows DMA from
endpoint devices.  Each viewport's size must be set to a power of two, and
that size must be equal to or larger than the amount of memory each
controller supports which is the sum of base region and its optional
extension.  Further, the 1-3 viewports are also adjacent in PCIe-space.

Unfortunately the viewport sizes cannot be ascertained from the
"dma-ranges" property so they have their own property, "brcm,scb-sizes".
This is because dma-range information does not indicate what memory
controller it is associated.  For example, consider the following case
where the size of one dma-range is 2GB and the second dma-range is 1GB:

    /* Case 1: SCB0 size set to 4GB */
    dma-range0: 2GB (from memc0-base)
    dma-range1: 1GB (from memc0-extension)

    /* Case 2: SCB0 size set to 2GB, SCB1 size set to 1GB */
    dma-range0: 2GB (from memc0-base)
    dma-range1: 1GB (from memc0-extension)

By just looking at the dma-ranges information, one cannot tell which
situation applies. That is why an additional property is needed.  Its
length indicates the number of memory controllers being used and each value
indicates the viewport size.

Note that the RPI DT does not have a "brcm,scb-sizes" property value,
as it is assumed that it only requires one memory controller and no
extension.  So the optional use of "brcm,scb-sizes" will be backwards
compatible.

One last layer of complexity exists: all of the viewports sizes must be
added and rounded up to a power of two to determine what the "BAR" size is.
Further, an offset must be given that indicates the base PCIe address of
this "BAR".  The use of the term BAR is typically associated with endpoint
devices, and the term is used here because the PCIe HW may be used as an RC
or an EP.  In the former case, all of the system memory appears in a single
"BAR" region in PCIe memory.  As it turns out, BrcmSTB PCIe HW is rarely
used in the EP role and its system of mapping memory is an artifact that
requires multiple dma-ranges regions.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 68 ++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 8dacb9d3b7b6..ffcb733e3ec5 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -57,6 +57,8 @@
 #define  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK	0x300000
 #define  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_128		0x0
 #define  PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK		0xf8000000
+#define  PCIE_MISC_MISC_CTRL_SCB1_SIZE_MASK		0x07c00000
+#define  PCIE_MISC_MISC_CTRL_SCB2_SIZE_MASK		0x0000001f
 
 #define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO		0x400c
 #define PCIE_MEM_WIN0_LO(win)	\
@@ -154,6 +156,7 @@
 #define SSC_STATUS_OFFSET		0x1
 #define SSC_STATUS_SSC_MASK		0x400
 #define SSC_STATUS_PLL_LOCK_MASK	0x800
+#define PCIE_BRCM_MAX_MEMC		3
 
 #define IDX_ADDR(pcie)			(pcie->reg_offsets[EXT_CFG_INDEX])
 #define DATA_ADDR(pcie)			(pcie->reg_offsets[EXT_CFG_DATA])
@@ -260,6 +263,8 @@ struct brcm_pcie {
 	const int		*reg_field_info;
 	enum pcie_type		type;
 	struct reset_control	*rescal;
+	int			num_memc;
+	u64			memc_size[PCIE_BRCM_MAX_MEMC];
 };
 
 /*
@@ -715,22 +720,44 @@ static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
 							u64 *rc_bar2_offset)
 {
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
-	struct device *dev = pcie->dev;
 	struct resource_entry *entry;
+	struct device *dev = pcie->dev;
+	u64 lowest_pcie_addr = ~(u64)0;
+	int ret, i = 0;
+	u64 size = 0;
 
-	entry = resource_list_first_type(&bridge->dma_ranges, IORESOURCE_MEM);
-	if (!entry)
-		return -ENODEV;
+	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
+		u64 pcie_beg = entry->res->start - entry->offset;
 
+		size += entry->res->end - entry->res->start + 1;
+		if (pcie_beg < lowest_pcie_addr)
+			lowest_pcie_addr = pcie_beg;
+	}
 
-	/*
-	 * The controller expects the inbound window offset to be calculated as
-	 * the difference between PCIe's address space and CPU's. The offset
-	 * provided by the firmware is calculated the opposite way, so we
-	 * negate it.
-	 */
-	*rc_bar2_offset = -entry->offset;
-	*rc_bar2_size = 1ULL << fls64(entry->res->end - entry->res->start);
+	if (lowest_pcie_addr == ~(u64)0) {
+		dev_err(dev, "DT node has no dma-ranges\n");
+		return -EINVAL;
+	}
+
+	ret = of_property_read_variable_u64_array(pcie->np, "brcm,scb-sizes", pcie->memc_size, 1,
+						  PCIE_BRCM_MAX_MEMC);
+
+	if (ret <= 0) {
+		/* Make an educated guess */
+		pcie->num_memc = 1;
+		pcie->memc_size[0] = 1ULL << fls64(size - 1);
+	} else {
+		pcie->num_memc = ret;
+	}
+
+	/* Each memc is viewed through a "port" that is a power of 2 */
+	for (i = 0, size = 0; i < pcie->num_memc; i++)
+		size += pcie->memc_size[i];
+
+	/* System memory starts at this address in PCIe-space */
+	*rc_bar2_offset = lowest_pcie_addr;
+	/* The sum of all memc views must also be a power of 2 */
+	*rc_bar2_size = 1ULL << fls64(size - 1);
 
 	/*
 	 * We validate the inbound memory view even though we should trust
@@ -782,12 +809,11 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	void __iomem *base = pcie->base;
 	struct device *dev = pcie->dev;
 	struct resource_entry *entry;
-	unsigned int scb_size_val;
 	bool ssc_good = false;
 	struct resource *res;
 	int num_out_wins = 0;
 	u16 nlw, cls, lnksta;
-	int i, ret;
+	int i, ret, memc;
 	u32 tmp, aspm_support;
 
 	/* Reset the bridge */
@@ -827,11 +853,17 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	writel(upper_32_bits(rc_bar2_offset),
 	       base + PCIE_MISC_RC_BAR2_CONFIG_HI);
 
-	scb_size_val = rc_bar2_size ?
-		       ilog2(rc_bar2_size) - 15 : 0xf; /* 0xf is 1GB */
 	tmp = readl(base + PCIE_MISC_MISC_CTRL);
-	u32p_replace_bits(&tmp, scb_size_val,
-			  PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK);
+	for (memc = 0; memc < pcie->num_memc; memc++) {
+		u32 scb_size_val = ilog2(pcie->memc_size[memc]) - 15;
+
+		if (memc == 0)
+			u32p_replace_bits(&tmp, scb_size_val, PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK);
+		else if (memc == 1)
+			u32p_replace_bits(&tmp, scb_size_val, PCIE_MISC_MISC_CTRL_SCB1_SIZE_MASK);
+		else if (memc == 2)
+			u32p_replace_bits(&tmp, scb_size_val, PCIE_MISC_MISC_CTRL_SCB2_SIZE_MASK);
+	}
 	writel(tmp, base + PCIE_MISC_MISC_CTRL);
 
 	/*
-- 
2.17.1

