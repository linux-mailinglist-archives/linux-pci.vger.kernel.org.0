Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73D86B77DB
	for <lists+linux-pci@lfdr.de>; Mon, 13 Mar 2023 13:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjCMMnQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Mar 2023 08:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjCMMm6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Mar 2023 08:42:58 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E738965044;
        Mon, 13 Mar 2023 05:42:24 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D6OxcO020021;
        Mon, 13 Mar 2023 05:42:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=QTMWXURCDJiR7mSr9wa/ZQQCka4cqYJIXxmGkMAjPKk=;
 b=kZiAJWRLUv7G48l4ZJvqZ6H74E5Befu1MXGgUImvfaaHqNHs5N3BayUlZ2Cf43vJhUFG
 xOt0A5RdrMSu1Cw8z5ktmLooE3RxN6nhvA/OUM/E5cExbQTuQGH1kQCgH2jkMJdbRofM
 yv3YpBWZEmMiU56GZxpw4ePN5ZWu8QZm/plzZjQlPJ2cDCbWoqyll6kGPQNG6x4pfLNB
 w6ywGDrm792W1T252CyX9APORp9tpOxq9HNDBKyQJ/1+VROMwEsx2+y+6aunBz6W/3TB
 8Oc3YKmEx68xbIlQMOMKs6q/PdhWCL7XW6FICc4ywWJvJgMfgNWs6YmK4P9ApGZdh3Pz 7g== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3p8t1t5gex-19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 05:42:15 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 13 Mar
 2023 05:41:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Mon, 13 Mar 2023 05:41:20 -0700
Received: from jupiter073.il.marvell.com (unknown [10.5.116.85])
        by maili.marvell.com (Postfix) with ESMTP id 53E565B693D;
        Mon, 13 Mar 2023 05:41:15 -0700 (PDT)
From:   Elad Nachman <enachman@marvell.com>
To:     <thomas.petazzoni@bootlin.com>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Elad Nachman <enachman@marvell.com>
Subject: [PATCH v4 5/8] PCI: armada8k: support AC5 INTx PCIe interrupts
Date:   Mon, 13 Mar 2023 14:40:13 +0200
Message-ID: <20230313124016.17102-6-enachman@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230313124016.17102-1-enachman@marvell.com>
References: <20230313124016.17102-1-enachman@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: JCyOKQzn5cf_Ucap8mVfSpT9mLIwwHHi
X-Proofpoint-ORIG-GUID: JCyOKQzn5cf_Ucap8mVfSpT9mLIwwHHi
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

Support message emulation of INTx PCIe interrupts for Marvell AC5/X.
These message emulations require writing an additional status register
with acknowledge bits.

Signed-off-by: Elad Nachman <enachman@marvell.com>
---
v4:
   Split the part not handling INTx interrupts to a separate patch

 drivers/pci/controller/dwc/pcie-armada8k.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index 02481ecadd25..2b94e32853ad 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
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
-- 
2.17.1

