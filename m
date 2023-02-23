Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82476A0F15
	for <lists+linux-pci@lfdr.de>; Thu, 23 Feb 2023 19:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjBWSGJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Feb 2023 13:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBWSGI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2023 13:06:08 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8BD166EE;
        Thu, 23 Feb 2023 10:06:07 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NHSAqW023951;
        Thu, 23 Feb 2023 10:05:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=qDCZ7zFyU4bHlmdw+iEtezqf0gOsQQPNRg0V800jwlo=;
 b=fIrnrXzQr/poe1TrgzvA+XINTOsyqt3jnVGIRWdUrVaM8JaHHMtAMrRVNaDtF3huf4gK
 8yjhJ0RPFN68L7Tafw4LtkAtDZxJzbCxfUe7y4bWbWaKdbixWQg9qfCqIV3+Bbdo3o7d
 znD4hASnxOQzxpqzFdeSrCOih4YDVvj5ObgrSQ37ZkbHLjVVoVhqbpZD/6aDBxcqkAg4
 dIl3gzrtA/ok8pK4uXC1ALSFkzEZldS29WldBJkzqpKlNbpFvDX7IQ3X7oBIhFBaPorL
 riqOMz/6l2mjljkpYpnR79xX8RqSoFj+t/caRYtbefQkEzUMc4PvlvGeLioK+RTHNGdB 0Q== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3nwy5h2cvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 10:05:57 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 23 Feb
 2023 10:05:55 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Thu, 23 Feb 2023 10:05:55 -0800
Received: from jupiter073.il.marvell.com (unknown [10.5.116.85])
        by maili.marvell.com (Postfix) with ESMTP id 4A25B3F7096;
        Thu, 23 Feb 2023 10:05:53 -0800 (PST)
From:   Elad Nachman <enachman@marvell.com>
To:     <thomas.petazzoni@bootlin.com>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Raz Adashi <raza@marvell.com>
Subject: [PATCH v3 2/7] PCI: armada8k: Add AC5 SoC support
Date:   Thu, 23 Feb 2023 20:05:26 +0200
Message-ID: <20230223180531.15148-3-enachman@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230223180531.15148-1-enachman@marvell.com>
References: <20230223180531.15148-1-enachman@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: V5_5YJzk6wDT7CHcc6ge76BTsjN5umI5
X-Proofpoint-ORIG-GUID: V5_5YJzk6wDT7CHcc6ge76BTsjN5umI5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_11,2023-02-23_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Raz Adashi <raza@marvell.com>

pcie-armada8k driver is utilized to serve also AC5.

Driver assumes interrupt mask registers are located
in the same address inboth CPUs. This assumption is
incorrect - fix it for AC5.

Co-developed-by: Yuval Shaia <yshaia@marvell.com>
Signed-off-by: Yuval Shaia <yshaia@marvell.com>
Signed-off-by: Raz Adashi <raza@marvell.com>
Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
v2:
   1) fix W1 warnings which caused by unused leftover code

   2) Use one xlate function to translate ac5 dbi access. Also add
      mode description in comments about this translation.

   3) Use correct name of Raz

   4) Use matching data to pass the SoC specific params (type & ops)

 drivers/pci/controller/dwc/pcie-armada8k.c | 145 +++++++++++++++++----
 1 file changed, 120 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index 5c999e15c357..b9fb1375dc58 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
@@ -26,15 +27,26 @@
 
 #define ARMADA8K_PCIE_MAX_LANES PCIE_LNK_X4
 
+enum armada8k_pcie_type {
+	ARMADA8K_PCIE_TYPE_A8K,
+	ARMADA8K_PCIE_TYPE_AC5
+};
+
 struct armada8k_pcie {
 	struct dw_pcie *pci;
 	struct clk *clk;
 	struct clk *clk_reg;
 	struct phy *phy[ARMADA8K_PCIE_MAX_LANES];
 	unsigned int phy_count;
+	enum armada8k_pcie_type pcie_type;
 };
 
-#define PCIE_VENDOR_REGS_OFFSET		0x8000
+struct armada8k_pcie_of_data {
+	enum armada8k_pcie_type pcie_type;
+	const struct dw_pcie_ops *pcie_ops;
+};
+
+#define PCIE_VENDOR_REGS_OFFSET		0x8000	/* in ac5 is 0x10000 */
 
 #define PCIE_GLOBAL_CONTROL_REG		(PCIE_VENDOR_REGS_OFFSET + 0x0)
 #define PCIE_APP_LTSSM_EN		BIT(2)
@@ -48,10 +60,17 @@ struct armada8k_pcie {
 
 #define PCIE_GLOBAL_INT_CAUSE1_REG	(PCIE_VENDOR_REGS_OFFSET + 0x1C)
 #define PCIE_GLOBAL_INT_MASK1_REG	(PCIE_VENDOR_REGS_OFFSET + 0x20)
+#define PCIE_GLOBAL_INT_MASK2_REG	(PCIE_VENDOR_REGS_OFFSET + 0x28)
 #define PCIE_INT_A_ASSERT_MASK		BIT(9)
 #define PCIE_INT_B_ASSERT_MASK		BIT(10)
 #define PCIE_INT_C_ASSERT_MASK		BIT(11)
 #define PCIE_INT_D_ASSERT_MASK		BIT(12)
+#define PCIE_INT_A_ASSERT_MASK_AC5	BIT(12)
+#define PCIE_INT_B_ASSERT_MASK_AC5	BIT(13)
+#define PCIE_INT_C_ASSERT_MASK_AC5	BIT(14)
+#define PCIE_INT_D_ASSERT_MASK_AC5	BIT(15)
+
+#define PCIE_ATU_ACCESS_MASK_AC5	GENMASK(21, 20)
 
 #define PCIE_ARCACHE_TRC_REG		(PCIE_VENDOR_REGS_OFFSET + 0x50)
 #define PCIE_AWCACHE_TRC_REG		(PCIE_VENDOR_REGS_OFFSET + 0x54)
@@ -169,6 +188,7 @@ static int armada8k_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	u32 reg;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct armada8k_pcie *pcie = to_armada8k_pcie(pci);
 
 	if (!dw_pcie_link_up(pci)) {
 		/* Disable LTSSM state machine to enable configuration */
@@ -177,32 +197,41 @@ static int armada8k_pcie_host_init(struct dw_pcie_rp *pp)
 		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_CONTROL_REG, reg);
 	}
 
-	/* Set the device to root complex mode */
-	reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_CONTROL_REG);
-	reg &= ~(PCIE_DEVICE_TYPE_MASK << PCIE_DEVICE_TYPE_SHIFT);
-	reg |= PCIE_DEVICE_TYPE_RC << PCIE_DEVICE_TYPE_SHIFT;
-	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_CONTROL_REG, reg);
+	if (pcie->pcie_type == ARMADA8K_PCIE_TYPE_A8K) {
+		/* Set the device to root complex mode */
+		reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_CONTROL_REG);
+		reg &= ~(PCIE_DEVICE_TYPE_MASK << PCIE_DEVICE_TYPE_SHIFT);
+		reg |= PCIE_DEVICE_TYPE_RC << PCIE_DEVICE_TYPE_SHIFT;
+		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_CONTROL_REG, reg);
 
-	/* Set the PCIe master AxCache attributes */
-	dw_pcie_writel_dbi(pci, PCIE_ARCACHE_TRC_REG, ARCACHE_DEFAULT_VALUE);
-	dw_pcie_writel_dbi(pci, PCIE_AWCACHE_TRC_REG, AWCACHE_DEFAULT_VALUE);
+		/* Set the PCIe master AxCache attributes */
+		dw_pcie_writel_dbi(pci, PCIE_ARCACHE_TRC_REG, ARCACHE_DEFAULT_VALUE);
+		dw_pcie_writel_dbi(pci, PCIE_AWCACHE_TRC_REG, AWCACHE_DEFAULT_VALUE);
 
-	/* Set the PCIe master AxDomain attributes */
-	reg = dw_pcie_readl_dbi(pci, PCIE_ARUSER_REG);
-	reg &= ~(AX_USER_DOMAIN_MASK << AX_USER_DOMAIN_SHIFT);
-	reg |= DOMAIN_OUTER_SHAREABLE << AX_USER_DOMAIN_SHIFT;
-	dw_pcie_writel_dbi(pci, PCIE_ARUSER_REG, reg);
+		/* Set the PCIe master AxDomain attributes */
+		reg = dw_pcie_readl_dbi(pci, PCIE_ARUSER_REG);
+		reg &= ~(AX_USER_DOMAIN_MASK << AX_USER_DOMAIN_SHIFT);
+		reg |= DOMAIN_OUTER_SHAREABLE << AX_USER_DOMAIN_SHIFT;
+		dw_pcie_writel_dbi(pci, PCIE_ARUSER_REG, reg);
 
-	reg = dw_pcie_readl_dbi(pci, PCIE_AWUSER_REG);
-	reg &= ~(AX_USER_DOMAIN_MASK << AX_USER_DOMAIN_SHIFT);
-	reg |= DOMAIN_OUTER_SHAREABLE << AX_USER_DOMAIN_SHIFT;
-	dw_pcie_writel_dbi(pci, PCIE_AWUSER_REG, reg);
+		reg = dw_pcie_readl_dbi(pci, PCIE_AWUSER_REG);
+		reg &= ~(AX_USER_DOMAIN_MASK << AX_USER_DOMAIN_SHIFT);
+		reg |= DOMAIN_OUTER_SHAREABLE << AX_USER_DOMAIN_SHIFT;
+		dw_pcie_writel_dbi(pci, PCIE_AWUSER_REG, reg);
+	}
 
 	/* Enable INT A-D interrupts */
-	reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_MASK1_REG);
-	reg |= PCIE_INT_A_ASSERT_MASK | PCIE_INT_B_ASSERT_MASK |
-	       PCIE_INT_C_ASSERT_MASK | PCIE_INT_D_ASSERT_MASK;
-	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK1_REG, reg);
+	if (pcie->pcie_type == ARMADA8K_PCIE_TYPE_AC5) {
+		reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_MASK2_REG);
+		reg |= PCIE_INT_A_ASSERT_MASK_AC5 | PCIE_INT_B_ASSERT_MASK_AC5 |
+		       PCIE_INT_C_ASSERT_MASK_AC5 | PCIE_INT_D_ASSERT_MASK_AC5;
+		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK2_REG, reg);
+	} else {
+		reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_MASK1_REG);
+		reg |= PCIE_INT_A_ASSERT_MASK | PCIE_INT_B_ASSERT_MASK |
+		       PCIE_INT_C_ASSERT_MASK | PCIE_INT_D_ASSERT_MASK;
+		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK1_REG, reg);
+	}
 
 	return 0;
 }
@@ -258,9 +287,61 @@ static int armada8k_add_pcie_port(struct armada8k_pcie *pcie,
 	return 0;
 }
 
-static const struct dw_pcie_ops dw_pcie_ops = {
+static u32 ac5_xlate_dbi_reg(u32 reg)
+{
+	/* Handle AC5 ATU access */
+	if ((reg & ~0xfffff) == PCIE_ATU_ACCESS_MASK_AC5) {
+		reg &= 0xfffff;
+		/* ATU registers offset is 0xC00 + 0x200 * n,
+		 * from RFU registers.
+		 */
+		reg = 0xc000 | (0x200 * (reg >> 9)) | (reg & 0xff);
+	} else if ((reg & 0xfffff000) == PCIE_VENDOR_REGS_OFFSET) {
+		/* PCIe RFU registers in A8K are at offset 0x8000 from base
+		 * (0xf2600000) while in AC5 offset is 0x10000 from base
+		 * (0x800a0000) therefore need the addition of 0x8000.
+		 */
+		reg += PCIE_VENDOR_REGS_OFFSET;
+	}
+
+	return reg;
+}
+
+static u32 ac5_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
+			     u32 reg, size_t size)
+{
+	u32 val;
+
+	dw_pcie_read(base + ac5_xlate_dbi_reg(reg), size, &val);
+	return val;
+}
+
+static void ac5_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
+			       u32 reg, size_t size, u32 val)
+{
+	dw_pcie_write(base + ac5_xlate_dbi_reg(reg), size, val);
+}
+
+static const struct dw_pcie_ops armada8k_dw_pcie_ops = {
+	.link_up = armada8k_pcie_link_up,
+	.start_link = armada8k_pcie_start_link,
+};
+
+static const struct dw_pcie_ops ac5_dw_pcie_ops = {
 	.link_up = armada8k_pcie_link_up,
 	.start_link = armada8k_pcie_start_link,
+	.read_dbi = ac5_pcie_read_dbi,
+	.write_dbi = ac5_pcie_write_dbi,
+};
+
+static const struct armada8k_pcie_of_data a8k_pcie_of_data = {
+	.pcie_type = ARMADA8K_PCIE_TYPE_A8K,
+	.pcie_ops = &armada8k_dw_pcie_ops,
+};
+
+static const struct armada8k_pcie_of_data ac5_pcie_of_data = {
+	.pcie_type = ARMADA8K_PCIE_TYPE_AC5,
+	.pcie_ops = &ac5_dw_pcie_ops,
 };
 
 static int armada8k_pcie_probe(struct platform_device *pdev)
@@ -268,9 +349,15 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 	struct dw_pcie *pci;
 	struct armada8k_pcie *pcie;
 	struct device *dev = &pdev->dev;
+	const struct armada8k_pcie_of_data *data;
 	struct resource *base;
 	int ret;
 
+	data = of_device_get_match_data(dev);
+	if (!data)
+		return -EINVAL;
+
+
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
 		return -ENOMEM;
@@ -279,9 +366,10 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 	if (!pci)
 		return -ENOMEM;
 
+	pci->ops = data->pcie_ops;
 	pci->dev = dev;
-	pci->ops = &dw_pcie_ops;
 
+	pcie->pcie_type = data->pcie_type;
 	pcie->pci = pci;
 
 	pcie->clk = devm_clk_get(dev, NULL);
@@ -334,7 +422,14 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id armada8k_pcie_of_match[] = {
-	{ .compatible = "marvell,armada8k-pcie", },
+	{
+		.compatible = "marvell,armada8k-pcie",
+		.data = &a8k_pcie_of_data,
+	},
+	{
+		.compatible = "marvell,ac5-pcie",
+		.data = &ac5_pcie_of_data,
+	},
 	{},
 };
 
-- 
2.17.1

