Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE8D6B77DE
	for <lists+linux-pci@lfdr.de>; Mon, 13 Mar 2023 13:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjCMMnQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Mar 2023 08:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjCMMm6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Mar 2023 08:42:58 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DF267824;
        Mon, 13 Mar 2023 05:42:25 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D6OxcP020021;
        Mon, 13 Mar 2023 05:42:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=7DKfIo9JLAYpRKRTLSaaANvz0M1ibKDER5y1y9Rke+A=;
 b=kSLrJR17BZ/AdYbZrQCJVWrdkXS5u3hbqm+RLcXs3NXP3mmmWSSeQ2v7SKbBdedLtWLr
 Vo4qLU3kByYxhEFV2ILU3k4TkUu8FMwme9FrgHldbJboGyyVS12cV+Tszu00TS92rofb
 jMAommBcTKIzo/n9InELHXz6j0V5eSYRw+q9TeJZqPptUdeP0DYGR60CZE44viHOMcj0
 wxsFLw8ELmZPk6oUdMRk1XF1Mw3XDUewRZvJPXu7H8KDEvqhlcfuX0mIXZfVR0od5sCg
 gAdZTH8HFMvt6d7vE9derhgcpXhKc7oz3Nw+wyJAAWIduCIu6EtWFYT9fXAo88C2xkok Aw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3p8t1t5gex-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 05:42:17 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 13 Mar
 2023 05:41:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Mon, 13 Mar 2023 05:41:22 -0700
Received: from jupiter073.il.marvell.com (unknown [10.5.116.85])
        by maili.marvell.com (Postfix) with ESMTP id 2C5325B6921;
        Mon, 13 Mar 2023 05:41:18 -0700 (PDT)
From:   Elad Nachman <enachman@marvell.com>
To:     <thomas.petazzoni@bootlin.com>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Elad Nachman <enachman@marvell.com>
Subject: [PATCH v4 6/8] PCI: armada8k: support reg regions according to DT.
Date:   Mon, 13 Mar 2023 14:40:14 +0200
Message-ID: <20230313124016.17102-7-enachman@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230313124016.17102-1-enachman@marvell.com>
References: <20230313124016.17102-1-enachman@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: R8-l_f3q1QTZAIqYGGMZ9XTliljdjdj1
X-Proofpoint-ORIG-GUID: R8-l_f3q1QTZAIqYGGMZ9XTliljdjdj1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_05,2023-03-13_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Elad Nachman <enachman@marvell.com>

Support atu/vendor registers regions start according to DT rather than using
inflexible offset arithmetics.

Signed-off-by: Elad Nachman <enachman@marvell.com>
---
v4:
   Split from previous patch in series

 drivers/pci/controller/dwc/pcie-armada8k.c | 30 ++++++++++++++--------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index 2b94e32853ad..145434c7a9fb 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -46,7 +46,7 @@ struct armada8k_pcie_of_data {
 	const struct dw_pcie_ops *pcie_ops;
 };
 
-#define PCIE_VENDOR_REGS_OFFSET		0x8000	/* in ac5 is 0x10000 */
+#define PCIE_VENDOR_REGS_OFFSET		0x8000	/* in ac5 is in another region */
 
 #define PCIE_GLOBAL_CONTROL_REG		(PCIE_VENDOR_REGS_OFFSET + 0x0)
 #define PCIE_APP_LTSSM_EN		BIT(2)
@@ -314,24 +314,29 @@ static int armada8k_add_pcie_port(struct armada8k_pcie *pcie,
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
@@ -339,14 +344,14 @@ static u32 ac5_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
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
@@ -425,7 +430,6 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 		ret = PTR_ERR(pci->dbi_base);
 		goto fail_clkreg;
 	}
-
 	ret = armada8k_pcie_setup_phys(pcie);
 	if (ret)
 		goto fail_clkreg;
@@ -436,6 +440,10 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
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

