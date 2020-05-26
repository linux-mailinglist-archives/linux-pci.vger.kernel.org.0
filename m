Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146691E2CE8
	for <lists+linux-pci@lfdr.de>; Tue, 26 May 2020 21:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392397AbgEZTS1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 15:18:27 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:46230 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391846AbgEZTNo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2020 15:13:44 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id BE16330D651;
        Tue, 26 May 2020 12:13:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com BE16330D651
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1590520422;
        bh=O+33eJKKKzwfVuoOuQlDtjddtvZIu0Ck8i/66RAb/gE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IAaQdWNqlg4MXpfcoP6tM9wmCoFrP1jLNFn1Nsd7J4/IS6BAvofg0u3Wp4Eo2fk4Z
         j7au5NiuOs+HPs9Ld0Rv3MVM1wPN2puK7rvLK+NmHYRVcTJ1exfRXIO9TwRlZDpyk8
         nnhV1sddbwHm5XlYWi9LYs4H7THBaV48qO6z2ZGM=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 5370814008B;
        Tue, 26 May 2020 12:13:41 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
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
Subject: [PATCH v2 11/14] PCI: brcmstb: Set internal memory viewport sizes
Date:   Tue, 26 May 2020 15:12:50 -0400
Message-Id: <20200526191303.1492-12-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526191303.1492-1-james.quinlan@broadcom.com>
References: <20200526191303.1492-1-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

BrcmSTB PCIe controllers are intimately connected to the memory
controller(s) on the SOC.  There is a "viewport" for each memory controller
that allows inbound accesses to CPU memory.  Each viewport's size must be
set to a power of two, and that size must be equal to or larger than the
amount of memory each controller supports.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 67 ++++++++++++++++++++-------
 1 file changed, 49 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index fa356bc149c3..338e9ed44230 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -55,6 +55,8 @@
 #define  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK	0x300000
 #define  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_128		0x0
 #define  PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK		0xf8000000
+#define  PCIE_MISC_MISC_CTRL_SCB1_SIZE_MASK		0x07c00000
+#define  PCIE_MISC_MISC_CTRL_SCB2_SIZE_MASK		0x0000001f
 
 #define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO		0x400c
 #define PCIE_MEM_WIN0_LO(win)	\
@@ -152,6 +154,7 @@
 #define SSC_STATUS_OFFSET		0x1
 #define SSC_STATUS_SSC_MASK		0x400
 #define SSC_STATUS_PLL_LOCK_MASK	0x800
+#define PCIE_BRCM_MAX_MEMC		3
 
 /* Rescal registers */
 #define PCIE_DVT_PMU_PCIE_PHY_CTRL				0xc700
@@ -261,6 +264,8 @@ struct brcm_pcie {
 	const int		*reg_field_info;
 	enum pcie_type		type;
 	struct reset_control	*rescal;
+	int			num_memc;
+	u64			memc_size[PCIE_BRCM_MAX_MEMC];
 };
 
 /*
@@ -717,22 +722,40 @@ static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
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
+	ret = of_property_read_variable_u64_array(
+		pcie->np, "brcm,scb-sizes", pcie->memc_size, 1,
+		PCIE_BRCM_MAX_MEMC);
+
+	if (ret <= 0) {
+		/* Make an educated guess */
+		pcie->num_memc = 1;
+		pcie->memc_size[0] = 1 << fls64(size - 1);
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
@@ -784,12 +807,11 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
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
@@ -825,11 +847,20 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
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
+			u32p_replace_bits(&tmp, scb_size_val,
+					  PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK);
+		else if (memc == 1)
+			u32p_replace_bits(&tmp, scb_size_val,
+					  PCIE_MISC_MISC_CTRL_SCB1_SIZE_MASK);
+		else if (memc == 2)
+			u32p_replace_bits(&tmp, scb_size_val,
+					  PCIE_MISC_MISC_CTRL_SCB2_SIZE_MASK);
+	}
 	writel(tmp, base + PCIE_MISC_MISC_CTRL);
 
 	/*
-- 
2.17.1

