Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354136B77D2
	for <lists+linux-pci@lfdr.de>; Mon, 13 Mar 2023 13:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjCMMnA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Mar 2023 08:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjCMMmx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Mar 2023 08:42:53 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6B7509BF;
        Mon, 13 Mar 2023 05:42:19 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D6OxcL020021;
        Mon, 13 Mar 2023 05:42:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=smJUiCQiNLdPlixvyvi7R49nYO+OJQrNMk6ebrooLUg=;
 b=cQk3XQKwCKwMV+Q+GHMszbu4m3vYe5eMjVNyrFGeSYw08hBOmI+U0iPCjFn+Y0PBcm0T
 NaKWn1w397JrGuMN8FiS5szDt1gtnDKarKC54giPOMhuE6enm3J+8/0lA2fZYxl+lbB8
 +a7tG4IGjxigAAXIuYFyTvG4zNjtP8T1GdTBeiWsiU+MjtlawSkpSPaYApqUQpl2N+Ph
 5aYSyZHW+T5wOdXpn2MrMhyUIfE8t8iEgOKkh4vFKfQPQ0DnRydV+avx1xp/PehwLMQo
 VbuxyFtpUhvHkJVJDNuAjnvTst8qqNfbCdJCO5nbJbRTWB3+GNMyN1ll+4zLyPmv6xB7 TA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3p8t1t5gex-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 05:42:11 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 13 Mar
 2023 05:41:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Mon, 13 Mar 2023 05:41:08 -0700
Received: from jupiter073.il.marvell.com (unknown [10.5.116.85])
        by maili.marvell.com (Postfix) with ESMTP id 5F9725B692A;
        Mon, 13 Mar 2023 05:41:04 -0700 (PDT)
From:   Elad Nachman <enachman@marvell.com>
To:     <thomas.petazzoni@bootlin.com>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Yuval Shaia <yshaia@marvell.com>
Subject: [PATCH v4 3/8] PCI: armada8k: Add AC5 MSI support
Date:   Mon, 13 Mar 2023 14:40:11 +0200
Message-ID: <20230313124016.17102-4-enachman@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230313124016.17102-1-enachman@marvell.com>
References: <20230313124016.17102-1-enachman@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: ssu20ViTP4SDOzJwL_cAsAz3DlZ2xhBl
X-Proofpoint-ORIG-GUID: ssu20ViTP4SDOzJwL_cAsAz3DlZ2xhBl
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

From: Yuval Shaia <yshaia@marvell.com>

AC5 requires different handling for MSI as with armada8k.
Fix it by:

1. Enabling the relevant bits in init phase
2. Dispatch virtual IRQ handlers when MSI interrupts are received

Also enable/disable PCIE_APP_LTSSM for AC5.

Signed-off-by: Yuval Shaia <yshaia@marvell.com>
Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
v4:
   Fix commit subject to be aligned with previous patch in series

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

