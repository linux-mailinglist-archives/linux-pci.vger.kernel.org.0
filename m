Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF401E2C3F
	for <lists+linux-pci@lfdr.de>; Tue, 26 May 2020 21:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404274AbgEZTN1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 15:13:27 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:45942 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404260AbgEZTNZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2020 15:13:25 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id ADABD30D766;
        Tue, 26 May 2020 12:13:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com ADABD30D766
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1590520403;
        bh=BVy8DtkdeXBmOOkbeG16lruOXBYUDAPR3V9ijJ0fk9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O6pUaEBA21oH0g3GlaYWwTRTR+Xd8ijuJhBuX+B7NTuu+fm1HvDNLXqnXxDL3rsgH
         dSQvUDk1aOKef+150WDi/met6UEb0qsXBrkc9t4SeBZSNQkPcsz7nMWpw/CnV6oO5q
         XigvretWMP+pJwuBkg45xmO2sicUOs4lfz1jBbjg=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 2FCA014008B;
        Tue, 26 May 2020 12:13:22 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
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
Subject: [PATCH v2 04/14] PCI: brcmstb: Add bcm7278 reigister info
Date:   Tue, 26 May 2020 15:12:43 -0400
Message-Id: <20200526191303.1492-5-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526191303.1492-1-james.quinlan@broadcom.com>
References: <20200526191303.1492-1-james.quinlan@broadcom.com>
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
---
 drivers/pci/controller/pcie-brcmstb.c | 108 +++++++++++++++++++++++---
 1 file changed, 96 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 73020b4ff090..7c707e483181 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -120,9 +120,8 @@
 #define  PCIE_EXT_SLOT_SHIFT				15
 #define  PCIE_EXT_FUNC_SHIFT				12
 
-#define PCIE_RGR1_SW_INIT_1				0x9210
 #define  PCIE_RGR1_SW_INIT_1_PERST_MASK			0x1
-#define  PCIE_RGR1_SW_INIT_1_INIT_MASK			0x2
+#define  PCIE_RGR1_SW_INIT_1_PERST_SHIFT		0x0
 
 /* PCIe parameters */
 #define BRCM_NUM_PCIE_OUT_WINS		0x4
@@ -152,6 +151,76 @@
 #define SSC_STATUS_SSC_MASK		0x400
 #define SSC_STATUS_PLL_LOCK_MASK	0x800
 
+#define IDX_ADDR(pcie)	\
+	(pcie->reg_offsets[EXT_CFG_INDEX])
+#define DATA_ADDR(pcie)	\
+	(pcie->reg_offsets[EXT_CFG_DATA])
+#define PCIE_RGR1_SW_INIT_1(pcie) \
+	(pcie->reg_offsets[RGR1_SW_INIT_1])
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
@@ -176,6 +245,9 @@ struct brcm_pcie {
 	int			gen;
 	u64			msi_target_addr;
 	struct brcm_msi		*msi;
+	const int		*reg_offsets;
+	const int		*reg_field_info;
+	enum pcie_type		type;
 };
 
 /*
@@ -602,20 +674,21 @@ static struct pci_ops brcm_pcie_ops = {
 
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
@@ -924,10 +997,16 @@ static int brcm_pcie_remove(struct platform_device *pdev)
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
+	const struct pcie_cfg_data *data;
 	struct brcm_pcie *pcie;
 	struct pci_bus *child;
 	struct resource *res;
@@ -937,9 +1016,18 @@ static int brcm_pcie_probe(struct platform_device *pdev)
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
@@ -1005,10 +1093,6 @@ static int brcm_pcie_probe(struct platform_device *pdev)
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

