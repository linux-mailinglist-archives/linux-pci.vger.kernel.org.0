Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FCB6A0F18
	for <lists+linux-pci@lfdr.de>; Thu, 23 Feb 2023 19:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjBWSGM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Feb 2023 13:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjBWSGK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2023 13:06:10 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E8159E42;
        Thu, 23 Feb 2023 10:06:09 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NBuLWx007788;
        Thu, 23 Feb 2023 10:06:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=Bs5K6DWJG7CI20ovumSdg/wFmZR4Ty0H43WJ6J4Bil4=;
 b=ISYHPHfgMG71IM0NY2MyyYqiQ+aKMDAn+qBENzC3ef8EXstLdppCcU709PQgw07HOhHp
 FfRO3cNN+8wl99ib3YrSGI/2+OBUXaqlIxHogvv3oD8m9/yYqo9WLDq7WiRt8YRH3hHB
 THH7RFX86SZA1t5lJPIThNU111y/xylDEf52rRyNXbzN7r6lW0ZDZkpGRk3YAgMiTdQI
 S+Nv0GoAoQHIv+LdMQCYEsuomfoEwX1wzYBQaOBtDurZbqP+Ho04qgIgxfPtWLClQkXY
 ex8aJHgD48vMJ10bD8r+oiw2QBdciSRljkHvmlYvzKGqxnxfRY9KSVJiDtVm7Nq/SeDL ug== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3nwy8qktdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 10:06:00 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 23 Feb
 2023 10:05:59 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Thu, 23 Feb 2023 10:05:58 -0800
Received: from jupiter073.il.marvell.com (unknown [10.5.116.85])
        by maili.marvell.com (Postfix) with ESMTP id 527FA3F7095;
        Thu, 23 Feb 2023 10:05:56 -0800 (PST)
From:   Elad Nachman <enachman@marvell.com>
To:     <thomas.petazzoni@bootlin.com>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Yuval Shaia <yshaia@marvell.com>
Subject: [PATCH v3 3/7] PCI: armada8k: Add MSI support for AC5 SoC
Date:   Thu, 23 Feb 2023 20:05:27 +0200
Message-ID: <20230223180531.15148-4-enachman@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230223180531.15148-1-enachman@marvell.com>
References: <20230223180531.15148-1-enachman@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: BWmPvui4gNwcnlDfRUOsQuJQsP0Yucni
X-Proofpoint-ORIG-GUID: BWmPvui4gNwcnlDfRUOsQuJQsP0Yucni
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

From: Yuval Shaia <yshaia@marvell.com>

AC5 requires different handling for MSI as with armada8k.
Fix it by:

1. Enabling the relevant bits in init phase
2. Dispatch virtual IRQ handlers when MSI interrupts are received

Also enable/disable PCIE_APP_LTSSM for AC5.

Signed-off-by: Yuval Shaia <yshaia@marvell.com>
Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
v2:
   1) fix W1 warnings which caused by unused leftover code

   2) fix type in "requieres" word in the description

 drivers/pci/controller/dwc/pcie-armada8k.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index b9fb1375dc58..02481ecadd25 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -50,6 +50,7 @@ struct armada8k_pcie_of_data {
 
 #define PCIE_GLOBAL_CONTROL_REG		(PCIE_VENDOR_REGS_OFFSET + 0x0)
 #define PCIE_APP_LTSSM_EN		BIT(2)
+#define PCIE_APP_LTSSM_EN_AC5		BIT(24)
 #define PCIE_DEVICE_TYPE_SHIFT		4
 #define PCIE_DEVICE_TYPE_MASK		0xF
 #define PCIE_DEVICE_TYPE_RC		0x4 /* Root complex */
@@ -69,6 +70,7 @@ struct armada8k_pcie_of_data {
 #define PCIE_INT_B_ASSERT_MASK_AC5	BIT(13)
 #define PCIE_INT_C_ASSERT_MASK_AC5	BIT(14)
 #define PCIE_INT_D_ASSERT_MASK_AC5	BIT(15)
+#define PCIE_MSI_MASK_AC5		BIT(11)
 
 #define PCIE_ATU_ACCESS_MASK_AC5	GENMASK(21, 20)
 
@@ -184,6 +186,16 @@ static int armada8k_pcie_start_link(struct dw_pcie *pci)
 	return 0;
 }
 
+static void ac5_pcie_msi_init(struct dw_pcie *pci)
+{
+	u32 val;
+
+	/* Set MSI bit in interrupt mask */
+	val = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_MASK1_REG);
+	val |= PCIE_MSI_MASK_AC5;
+	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK1_REG, val);
+}
+
 static int armada8k_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	u32 reg;
@@ -193,7 +205,10 @@ static int armada8k_pcie_host_init(struct dw_pcie_rp *pp)
 	if (!dw_pcie_link_up(pci)) {
 		/* Disable LTSSM state machine to enable configuration */
 		reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_CONTROL_REG);
-		reg &= ~(PCIE_APP_LTSSM_EN);
+		if (pcie->pcie_type == ARMADA8K_PCIE_TYPE_AC5)
+			reg &= ~(PCIE_APP_LTSSM_EN_AC5);
+		else
+			reg &= ~(PCIE_APP_LTSSM_EN);
 		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_CONTROL_REG, reg);
 	}
 
@@ -233,6 +248,9 @@ static int armada8k_pcie_host_init(struct dw_pcie_rp *pp)
 		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK1_REG, reg);
 	}
 
+	if (IS_ENABLED(CONFIG_PCI_MSI) && (pcie->pcie_type == ARMADA8K_PCIE_TYPE_AC5))
+		ac5_pcie_msi_init(pci);
+
 	return 0;
 }
 
@@ -249,6 +267,8 @@ static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
 	 */
 	val = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_CAUSE1_REG);
 	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_CAUSE1_REG, val);
+	if ((PCIE_MSI_MASK_AC5 & val) && (pcie->pcie_type == ARMADA8K_PCIE_TYPE_AC5))
+		dw_handle_msi_irq(&pci->pp);
 
 	return IRQ_HANDLED;
 }
-- 
2.17.1

