Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2886A0F1F
	for <lists+linux-pci@lfdr.de>; Thu, 23 Feb 2023 19:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjBWSGY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Feb 2023 13:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjBWSGU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2023 13:06:20 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC545AB59;
        Thu, 23 Feb 2023 10:06:14 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NHUPQG026389;
        Thu, 23 Feb 2023 10:06:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=p1+M9tISj/cvvWGhHk9rRBGqNYmcNWd4k8imRw9gF2U=;
 b=YdQDIDkWT/Iu0WIQZOA7uev9/onYM5lMeRbvZCHy3fKuf2FQ/NNZlrVGB6wAsKM2YDgY
 /jOToQ1PU9XjTEsiIaaspwhQvcHMWotKkr5eGv15XbWtI3t2k1hKb0Xiq4gPtSn4rotu
 s5JiMISHzL068xhCmBAwlejB/N+wYcwDMFLIe2zqDhuu85BF/ThM/p1bNOv6vOn6+M9k
 PsoWuDiCYj8eRprjtCfwxU9IaJcrh7Tzj07FszH3d2E8HbVvH0PlXqD0ohrUbrGXeR9V
 78L0As+QjAXvS3ZCay1iRmUHVIH4UGJhWMVnIm8Ku8mjotqkncihkG1+7qU1g5xt5Cte OA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3nwy5h2cwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 10:06:06 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 23 Feb
 2023 10:06:05 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Thu, 23 Feb 2023 10:06:05 -0800
Received: from jupiter073.il.marvell.com (unknown [10.5.116.85])
        by maili.marvell.com (Postfix) with ESMTP id 627AF3F7094;
        Thu, 23 Feb 2023 10:06:02 -0800 (PST)
From:   Elad Nachman <enachman@marvell.com>
To:     <thomas.petazzoni@bootlin.com>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Elad Nachman <enachman@marvell.com>
Subject: [PATCH v3 5/7] PCI: dwc: support AC5 Legacy PCIe interrupts
Date:   Thu, 23 Feb 2023 20:05:29 +0200
Message-ID: <20230223180531.15148-6-enachman@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230223180531.15148-1-enachman@marvell.com>
References: <20230223180531.15148-1-enachman@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: 8XWn3EIbxUWAWMc3PgI95hhNRQ3RrSgf
X-Proofpoint-ORIG-GUID: 8XWn3EIbxUWAWMc3PgI95hhNRQ3RrSgf
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

From: Elad Nachman <enachman@marvell.com>

Support message emulation of Legacy PCIe interrupts for Marvell AC5/X.
These message emulations require writing an additional status register
with acknowledge bits.

Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 drivers/pci/controller/dwc/pcie-armada8k.c | 41 +++++++++++++++-------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index 02481ecadd25..145434c7a9fb 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -46,7 +46,7 @@ struct armada8k_pcie_of_data {
 	const struct dw_pcie_ops *pcie_ops;
 };
 
-#define PCIE_VENDOR_REGS_OFFSET		0x8000	/* in ac5 is 0x10000 */
+#define PCIE_VENDOR_REGS_OFFSET		0x8000	/* in ac5 is in another region */
 
 #define PCIE_GLOBAL_CONTROL_REG		(PCIE_VENDOR_REGS_OFFSET + 0x0)
 #define PCIE_APP_LTSSM_EN		BIT(2)
@@ -61,6 +61,7 @@ struct armada8k_pcie_of_data {
 
 #define PCIE_GLOBAL_INT_CAUSE1_REG	(PCIE_VENDOR_REGS_OFFSET + 0x1C)
 #define PCIE_GLOBAL_INT_MASK1_REG	(PCIE_VENDOR_REGS_OFFSET + 0x20)
+#define PCIE_GLOBAL_INT_CAUSE2_REG	(PCIE_VENDOR_REGS_OFFSET + 0x24)
 #define PCIE_GLOBAL_INT_MASK2_REG	(PCIE_VENDOR_REGS_OFFSET + 0x28)
 #define PCIE_INT_A_ASSERT_MASK		BIT(9)
 #define PCIE_INT_B_ASSERT_MASK		BIT(10)
@@ -267,8 +268,14 @@ static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
 	 */
 	val = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_CAUSE1_REG);
 	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_CAUSE1_REG, val);
-	if ((PCIE_MSI_MASK_AC5 & val) && (pcie->pcie_type == ARMADA8K_PCIE_TYPE_AC5))
-		dw_handle_msi_irq(&pci->pp);
+	if (pcie->pcie_type == ARMADA8K_PCIE_TYPE_AC5) {
+		if (PCIE_MSI_MASK_AC5 & val)
+			dw_handle_msi_irq(&pci->pp);
+
+		val = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_CAUSE2_REG);
+		/* Now clear the second interrupt cause. */
+		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_CAUSE2_REG, val);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -307,24 +314,29 @@ static int armada8k_add_pcie_port(struct armada8k_pcie *pcie,
 	return 0;
 }
 
-static u32 ac5_xlate_dbi_reg(u32 reg)
+static void __iomem *ac5_xlate_dbi_reg(struct dw_pcie *pci,
+				       void __iomem *base,
+				       u32 reg)
 {
 	/* Handle AC5 ATU access */
 	if ((reg & ~0xfffff) == PCIE_ATU_ACCESS_MASK_AC5) {
 		reg &= 0xfffff;
-		/* ATU registers offset is 0xC00 + 0x200 * n,
+		/* ATU registers offset is 0xC000 + 0x200 * n,
 		 * from RFU registers.
 		 */
-		reg = 0xc000 | (0x200 * (reg >> 9)) | (reg & 0xff);
+		reg = (0x200 * (reg >> 9)) | (reg & 0xff);
+		return pci->atu_base + reg;
 	} else if ((reg & 0xfffff000) == PCIE_VENDOR_REGS_OFFSET) {
 		/* PCIe RFU registers in A8K are at offset 0x8000 from base
 		 * (0xf2600000) while in AC5 offset is 0x10000 from base
-		 * (0x800a0000) therefore need the addition of 0x8000.
+		 * (0x800a0000) therefore need to be reduced by 0x8000
+		 * and rebased from dbi2 base, which is set to the PCIe rfu
+		 * base in the AC5 dts:
 		 */
-		reg += PCIE_VENDOR_REGS_OFFSET;
+		reg -= PCIE_VENDOR_REGS_OFFSET;
+		return pci->dbi_base2 + reg;
 	}
-
-	return reg;
+	return base + reg;
 }
 
 static u32 ac5_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
@@ -332,14 +344,14 @@ static u32 ac5_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
 {
 	u32 val;
 
-	dw_pcie_read(base + ac5_xlate_dbi_reg(reg), size, &val);
+	dw_pcie_read(ac5_xlate_dbi_reg(pci, base, reg), size, &val);
 	return val;
 }
 
 static void ac5_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
 			       u32 reg, size_t size, u32 val)
 {
-	dw_pcie_write(base + ac5_xlate_dbi_reg(reg), size, val);
+	dw_pcie_write(ac5_xlate_dbi_reg(pci, base, reg), size, val);
 }
 
 static const struct dw_pcie_ops armada8k_dw_pcie_ops = {
@@ -418,7 +430,6 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 		ret = PTR_ERR(pci->dbi_base);
 		goto fail_clkreg;
 	}
-
 	ret = armada8k_pcie_setup_phys(pcie);
 	if (ret)
 		goto fail_clkreg;
@@ -429,6 +440,10 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto disable_phy;
 
+	/* backwards compatibility with older dts files: */
+	if (!pci->dbi_base2)
+		pci->dbi_base2 = pci->dbi_base;
+
 	return 0;
 
 disable_phy:
-- 
2.17.1

