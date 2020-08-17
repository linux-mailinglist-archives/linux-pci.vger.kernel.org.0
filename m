Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735F124794F
	for <lists+linux-pci@lfdr.de>; Mon, 17 Aug 2020 23:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbgHQVxp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Aug 2020 17:53:45 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:47522 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728801AbgHQVxk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Aug 2020 17:53:40 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 9B80830C210;
        Mon, 17 Aug 2020 14:51:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 9B80830C210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1597701076;
        bh=SCeymgfmidxWNTewp2CUtXHPgRiJmtVBtU2BuTPYLFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qd1ME3Qf44YjINzWPCjmeP0ShPnLhxS0WhC+LKigbKbJ5Uas0A+ahySFOQD9Ah4yg
         wRGVl29ZTN3ib6/Uy1wCyCkLnqRPzPMVuSpvn1YrMt+KdC8ljns4T9UD8pBxQb/USD
         vRkjTAFDTQBID0iJeUS8Qu0wJYPzdI5AA0rvbX+4=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 7F69E14008B;
        Mon, 17 Aug 2020 14:53:37 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RESEND v10 03/11] PCI: brcmstb: Add bcm7278 register info
Date:   Mon, 17 Aug 2020 17:53:05 -0400
Message-Id: <20200817215326.30912-4-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817215326.30912-1-james.quinlan@broadcom.com>
References: <20200817215326.30912-1-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jim Quinlan <jquinlan@broadcom.com>

Add in compatibility strings and code for three Broadcom STB chips.  Some
of the register locations, shifts, and masks are different for certain
chips, requiring the use of different constants based on of_id.

We would like to add the following at this time to the match list but we
need to wait until the end of this patchset so that everything works.

    { .compatible = "brcm,bcm7211-pcie", .data = &generic_cfg },
    { .compatible = "brcm,bcm7278-pcie", .data = &bcm7278_cfg },
    { .compatible = "brcm,bcm7216-pcie", .data = &bcm7278_cfg },
    { .compatible = "brcm,bcm7445-pcie", .data = &generic_cfg },

Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 105 +++++++++++++++++++++++---
 1 file changed, 93 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 7730ea845ff2..b7a222fde3c4 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -122,9 +122,8 @@
 #define  PCIE_EXT_SLOT_SHIFT				15
 #define  PCIE_EXT_FUNC_SHIFT				12
 
-#define PCIE_RGR1_SW_INIT_1				0x9210
 #define  PCIE_RGR1_SW_INIT_1_PERST_MASK			0x1
-#define  PCIE_RGR1_SW_INIT_1_INIT_MASK			0x2
+#define  PCIE_RGR1_SW_INIT_1_PERST_SHIFT		0x0
 
 /* PCIe parameters */
 #define BRCM_NUM_PCIE_OUT_WINS		0x4
@@ -154,6 +153,73 @@
 #define SSC_STATUS_SSC_MASK		0x400
 #define SSC_STATUS_PLL_LOCK_MASK	0x800
 
+#define IDX_ADDR(pcie)			(pcie->reg_offsets[EXT_CFG_INDEX])
+#define DATA_ADDR(pcie)			(pcie->reg_offsets[EXT_CFG_DATA])
+#define PCIE_RGR1_SW_INIT_1(pcie)	(pcie->reg_offsets[RGR1_SW_INIT_1])
+
+enum {
+	RGR1_SW_INIT_1,
+	EXT_CFG_INDEX,
+	EXT_CFG_DATA,
+};
+
+enum {
+	RGR1_SW_INIT_1_INIT_MASK,
+	RGR1_SW_INIT_1_INIT_SHIFT,
+};
+
+enum pcie_type {
+	GENERIC,
+	BCM7278,
+	BCM2711,
+};
+
+struct pcie_cfg_data {
+	const int *reg_field_info;
+	const int *offsets;
+	const enum pcie_type type;
+};
+
+static const int pcie_reg_field_info[] = {
+	[RGR1_SW_INIT_1_INIT_MASK] = 0x2,
+	[RGR1_SW_INIT_1_INIT_SHIFT] = 0x1,
+};
+
+static const int pcie_reg_field_info_bcm7278[] = {
+	[RGR1_SW_INIT_1_INIT_MASK] = 0x1,
+	[RGR1_SW_INIT_1_INIT_SHIFT] = 0x0,
+};
+
+static const int pcie_offsets[] = {
+	[RGR1_SW_INIT_1] = 0x9210,
+	[EXT_CFG_INDEX]  = 0x9000,
+	[EXT_CFG_DATA]   = 0x9004,
+};
+
+static const struct pcie_cfg_data generic_cfg = {
+	.reg_field_info	= pcie_reg_field_info,
+	.offsets	= pcie_offsets,
+	.type		= GENERIC,
+};
+
+static const int pcie_offset_bcm7278[] = {
+	[RGR1_SW_INIT_1] = 0xc010,
+	[EXT_CFG_INDEX] = 0x9000,
+	[EXT_CFG_DATA] = 0x9004,
+};
+
+static const struct pcie_cfg_data bcm7278_cfg = {
+	.reg_field_info = pcie_reg_field_info_bcm7278,
+	.offsets	= pcie_offset_bcm7278,
+	.type		= BCM7278,
+};
+
+static const struct pcie_cfg_data bcm2711_cfg = {
+	.reg_field_info	= pcie_reg_field_info,
+	.offsets	= pcie_offsets,
+	.type		= BCM2711,
+};
+
 struct brcm_msi {
 	struct device		*dev;
 	void __iomem		*base;
@@ -178,6 +244,9 @@ struct brcm_pcie {
 	int			gen;
 	u64			msi_target_addr;
 	struct brcm_msi		*msi;
+	const int		*reg_offsets;
+	const int		*reg_field_info;
+	enum pcie_type		type;
 };
 
 /*
@@ -604,20 +673,21 @@ static struct pci_ops brcm_pcie_ops = {
 
 static inline void brcm_pcie_bridge_sw_init_set(struct brcm_pcie *pcie, u32 val)
 {
-	u32 tmp;
+	u32 tmp, mask =  pcie->reg_field_info[RGR1_SW_INIT_1_INIT_MASK];
+	u32 shift = pcie->reg_field_info[RGR1_SW_INIT_1_INIT_SHIFT];
 
-	tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1);
-	u32p_replace_bits(&tmp, val, PCIE_RGR1_SW_INIT_1_INIT_MASK);
-	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1);
+	tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
+	tmp = (tmp & ~mask) | ((val << shift) & mask);
+	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
 }
 
 static inline void brcm_pcie_perst_set(struct brcm_pcie *pcie, u32 val)
 {
 	u32 tmp;
 
-	tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1);
+	tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
 	u32p_replace_bits(&tmp, val, PCIE_RGR1_SW_INIT_1_PERST_MASK);
-	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1);
+	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
 }
 
 static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
@@ -927,11 +997,17 @@ static int brcm_pcie_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id brcm_pcie_match[] = {
+	{ .compatible = "brcm,bcm2711-pcie", .data = &bcm2711_cfg },
+	{},
+};
+
 static int brcm_pcie_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node, *msi_np;
 	struct pci_host_bridge *bridge;
 	struct device_node *fw_np;
+	const struct pcie_cfg_data *data;
 	struct brcm_pcie *pcie;
 	struct pci_bus *child;
 	struct resource *res;
@@ -955,9 +1031,18 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	if (!bridge)
 		return -ENOMEM;
 
+	data = of_device_get_match_data(&pdev->dev);
+	if (!data) {
+		pr_err("failed to look up compatible string\n");
+		return -EINVAL;
+	}
+
 	pcie = pci_host_bridge_priv(bridge);
 	pcie->dev = &pdev->dev;
 	pcie->np = np;
+	pcie->reg_offsets = data->offsets;
+	pcie->reg_field_info = data->reg_field_info;
+	pcie->type = data->type;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pcie->base = devm_ioremap_resource(&pdev->dev, res);
@@ -1023,10 +1108,6 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static const struct of_device_id brcm_pcie_match[] = {
-	{ .compatible = "brcm,bcm2711-pcie" },
-	{},
-};
 MODULE_DEVICE_TABLE(of, brcm_pcie_match);
 
 static struct platform_driver brcm_pcie_driver = {
-- 
2.17.1

