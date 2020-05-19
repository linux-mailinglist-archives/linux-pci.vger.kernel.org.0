Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3061DA2B8
	for <lists+linux-pci@lfdr.de>; Tue, 19 May 2020 22:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgESUfJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 May 2020 16:35:09 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:35446 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726290AbgESUfH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 May 2020 16:35:07 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id BE52630D852;
        Tue, 19 May 2020 13:33:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com BE52630D852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1589920423;
        bh=OFtOG638/x1XYtIKwS4AiMdjfBNuldhsuTARIfdOFe8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LPRrv8zoC2ycouwAYS3yDoE4ukPOAgKBGn8I1BVNg+KfD5bClFYKcvwTCXYhS2VEV
         gjrHJ/tuBn0HBekjfWZdmi5TtzswbRAaYetCJ2R1WUdGWqTaaBL+tlR8Ca0OlE0SBR
         g64hG7+ZEpb/Ik4BmmKH/DUVCsxlB+CY23wUe2LI=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 1133A1406B7;
        Tue, 19 May 2020 13:35:04 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     james.quinlan@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND
        ENDPOINT DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 13/15] PCI: brcmstb: Accommodate MSI for older chips
Date:   Tue, 19 May 2020 16:34:11 -0400
Message-Id: <20200519203419.12369-14-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519203419.12369-1-james.quinlan@broadcom.com>
References: <20200519203419.12369-1-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jim Quinlan <jquinlan@broadcom.com>

Older BrcmSTB chips do not have a separate register for MSI
interrupts; the MSIs are in a register that also contains
unrelated interrupts.  In addition, the interrupts lie in
bits [31..24] for these legacy chips.  This commit provides
commont code for both legacy and non-legacy MSI interrupt
registers.

Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 72 +++++++++++++++++++--------
 1 file changed, 52 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 532f2bc76202..7bf945efd71b 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -80,7 +80,8 @@
 #define PCIE_MISC_MSI_BAR_CONFIG_HI			0x4048
 
 #define PCIE_MISC_MSI_DATA_CONFIG			0x404c
-#define  PCIE_MISC_MSI_DATA_CONFIG_VAL			0xffe06540
+#define  PCIE_MISC_MSI_DATA_CONFIG_VAL_32		0xffe06540
+#define  PCIE_MISC_MSI_DATA_CONFIG_VAL_8		0xfff86540
 
 #define PCIE_MISC_PCIE_CTRL				0x4064
 #define  PCIE_MISC_PCIE_CTRL_PCIE_L23_REQUEST_MASK	0x1
@@ -92,6 +93,9 @@
 #define  PCIE_MISC_PCIE_STATUS_PCIE_PHYLINKUP_MASK	0x10
 #define  PCIE_MISC_PCIE_STATUS_PCIE_LINK_IN_L23_MASK	0x40
 
+#define PCIE_MISC_REVISION				0x406c
+#define  BRCM_PCIE_HW_REV_33				0x0303
+
 #define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT		0x4070
 #define  PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_LIMIT_MASK	0xfff00000
 #define  PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_BASE_MASK	0xfff0
@@ -112,10 +116,14 @@
 #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK	0x2
 #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK		0x08000000
 
-#define PCIE_MSI_INTR2_STATUS				0x4500
-#define PCIE_MSI_INTR2_CLR				0x4508
-#define PCIE_MSI_INTR2_MASK_SET				0x4510
-#define PCIE_MSI_INTR2_MASK_CLR				0x4514
+
+#define PCIE_INTR2_CPU_BASE		0x4300
+#define PCIE_MSI_INTR2_BASE		0x4500
+/* Offsets from PCIE_INTR2_CPU_BASE and PCIE_MSI_INTR2_BASE */
+#define  MSI_INT_STATUS			0x0
+#define  MSI_INT_CLR			0x8
+#define  MSI_INT_MASK_SET		0x10
+#define  MSI_INT_MASK_CLR		0x14
 
 #define PCIE_EXT_CFG_DATA				0x8000
 
@@ -130,6 +138,8 @@
 /* PCIe parameters */
 #define BRCM_NUM_PCIE_OUT_WINS		0x4
 #define BRCM_INT_PCI_MSI_NR		32
+#define BRCM_INT_PCI_MSI_LEGACY_NR	8
+#define BRCM_INT_PCI_MSI_SHIFT		0
 
 /* MSI target adresses */
 #define BRCM_MSI_TARGET_ADDR_LT_4GB	0x0fffffffcULL
@@ -240,6 +250,12 @@ struct brcm_msi {
 	int			irq;
 	/* used indicates which MSI interrupts have been alloc'd */
 	unsigned long		used;
+	bool			legacy;
+	/* Some chips have MSIs in bits [31..24] of a shared register. */
+	int			legacy_shift;
+	int			nr; /* No. of MSI available, depends on chip */
+	/* This is the base pointer for interrupt status/set/clr regs */
+	void __iomem		*intr_base;
 };
 
 /* Internal PCIe Host Controller Information.*/
@@ -259,6 +275,7 @@ struct brcm_pcie {
 	struct reset_control	*rescal;
 	int			num_memc;
 	u64			memc_size[PCIE_BRCM_MAX_MEMC];
+	u32			hw_rev;
 };
 
 /*
@@ -449,8 +466,10 @@ static void brcm_pcie_msi_isr(struct irq_desc *desc)
 	msi = irq_desc_get_handler_data(desc);
 	dev = msi->dev;
 
-	status = readl(msi->base + PCIE_MSI_INTR2_STATUS);
-	for_each_set_bit(bit, &status, BRCM_INT_PCI_MSI_NR) {
+	status = readl(msi->intr_base + MSI_INT_STATUS);
+	status >>= msi->legacy_shift;
+
+	for_each_set_bit(bit, &status, msi->nr) {
 		virq = irq_find_mapping(msi->inner_domain, bit);
 		if (virq)
 			generic_handle_irq(virq);
@@ -467,7 +486,7 @@ static void brcm_msi_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 
 	msg->address_lo = lower_32_bits(msi->target_addr);
 	msg->address_hi = upper_32_bits(msi->target_addr);
-	msg->data = (0xffff & PCIE_MISC_MSI_DATA_CONFIG_VAL) | data->hwirq;
+	msg->data = (0xffff & PCIE_MISC_MSI_DATA_CONFIG_VAL_32) | data->hwirq;
 }
 
 static int brcm_msi_set_affinity(struct irq_data *irq_data,
@@ -479,8 +498,9 @@ static int brcm_msi_set_affinity(struct irq_data *irq_data,
 static void brcm_msi_ack_irq(struct irq_data *data)
 {
 	struct brcm_msi *msi = irq_data_get_irq_chip_data(data);
+	const int shift_amt = data->hwirq + msi->legacy_shift;
 
-	writel(1 << data->hwirq, msi->base + PCIE_MSI_INTR2_CLR);
+	writel(1 << shift_amt, msi->intr_base + MSI_INT_CLR);
 }
 
 
@@ -496,7 +516,7 @@ static int brcm_msi_alloc(struct brcm_msi *msi)
 	int hwirq;
 
 	mutex_lock(&msi->lock);
-	hwirq = bitmap_find_free_region(&msi->used, BRCM_INT_PCI_MSI_NR, 0);
+	hwirq = bitmap_find_free_region(&msi->used, msi->nr, 0);
 	mutex_unlock(&msi->lock);
 
 	return hwirq;
@@ -545,7 +565,7 @@ static int brcm_allocate_domains(struct brcm_msi *msi)
 	struct fwnode_handle *fwnode = of_node_to_fwnode(msi->np);
 	struct device *dev = msi->dev;
 
-	msi->inner_domain = irq_domain_add_linear(NULL, BRCM_INT_PCI_MSI_NR,
+	msi->inner_domain = irq_domain_add_linear(NULL, msi->nr,
 						  &msi_domain_ops, msi);
 	if (!msi->inner_domain) {
 		dev_err(dev, "failed to create IRQ domain\n");
@@ -583,7 +603,10 @@ static void brcm_msi_remove(struct brcm_pcie *pcie)
 
 static void brcm_msi_set_regs(struct brcm_msi *msi)
 {
-	writel(0xffffffff, msi->base + PCIE_MSI_INTR2_MASK_CLR);
+	u32 val = __GENMASK(31, msi->legacy_shift);
+
+	writel(val, msi->intr_base + MSI_INT_MASK_CLR);
+	writel(val, msi->intr_base + MSI_INT_CLR);
 
 	/*
 	 * The 0 bit of PCIE_MISC_MSI_BAR_CONFIG_LO is repurposed to MSI
@@ -594,8 +617,10 @@ static void brcm_msi_set_regs(struct brcm_msi *msi)
 	writel(upper_32_bits(msi->target_addr),
 	       msi->base + PCIE_MISC_MSI_BAR_CONFIG_HI);
 
-	writel(PCIE_MISC_MSI_DATA_CONFIG_VAL,
-	       msi->base + PCIE_MISC_MSI_DATA_CONFIG);
+	val = msi->legacy ? PCIE_MISC_MSI_DATA_CONFIG_VAL_8 :
+		PCIE_MISC_MSI_DATA_CONFIG_VAL_32;
+
+	writel(val, msi->base + PCIE_MISC_MSI_DATA_CONFIG);
 }
 
 static int brcm_pcie_enable_msi(struct brcm_pcie *pcie)
@@ -620,6 +645,17 @@ static int brcm_pcie_enable_msi(struct brcm_pcie *pcie)
 	msi->np = pcie->np;
 	msi->target_addr = pcie->msi_target_addr;
 	msi->irq = irq;
+	msi->legacy = pcie->hw_rev < BRCM_PCIE_HW_REV_33;
+
+	if (msi->legacy) {
+		msi->intr_base = msi->base + PCIE_INTR2_CPU_BASE;
+		msi->nr = BRCM_INT_PCI_MSI_LEGACY_NR;
+		msi->legacy_shift = 24;
+	} else {
+		msi->intr_base = msi->base + PCIE_MSI_INTR2_BASE;
+		msi->nr = BRCM_INT_PCI_MSI_NR;
+		msi->legacy_shift = 0;
+	}
 
 	ret = brcm_allocate_domains(msi);
 	if (ret)
@@ -878,12 +914,6 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	tmp &= ~PCIE_MISC_RC_BAR3_CONFIG_LO_SIZE_MASK;
 	writel(tmp, base + PCIE_MISC_RC_BAR3_CONFIG_LO);
 
-	/* Mask all interrupts since we are not handling any yet */
-	writel(0xffffffff, pcie->base + PCIE_MSI_INTR2_MASK_SET);
-
-	/* clear any interrupts we find on boot */
-	writel(0xffffffff, pcie->base + PCIE_MSI_INTR2_CLR);
-
 	if (pcie->gen)
 		brcm_pcie_set_gen(pcie, pcie->gen);
 
@@ -1215,6 +1245,8 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto fail;
 
+	pcie->hw_rev = readl(pcie->base + PCIE_MISC_REVISION);
+
 	msi_np = of_parse_phandle(pcie->np, "msi-parent", 0);
 	if (pci_msi_enabled() && msi_np == pcie->np) {
 		ret = brcm_pcie_enable_msi(pcie);
-- 
2.17.1

