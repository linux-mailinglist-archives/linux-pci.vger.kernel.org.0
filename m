Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45B135F4C4
	for <lists+linux-pci@lfdr.de>; Wed, 14 Apr 2021 15:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhDNNXM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Apr 2021 09:23:12 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:34600 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351322AbhDNNXG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Apr 2021 09:23:06 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13EDG1va020128;
        Wed, 14 Apr 2021 06:21:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pfpt0220;
 bh=1w1aOW3ghY/Ww+N67gF96mJvYXQ0kxUthm1XoYVB+Qs=;
 b=XU1tpVxJX/dIFConuEnm/ZXW/ygcd1ydOQTmb4p8/g5KzAg6KrawOQUDOOaBDix2voux
 pIGUobGsKWUvwQsQKeukeSRZXlRyziq/u5IeTODQUb80QJctTSlpEx7xTatvdgjYAjwv
 o3F8lFU/bvWqXtkNXa9PxIyKEw3Q5UeoDcBdXyBjYGBQLPRqCNchAH/wRFuEK86LgUW1
 gm4FWA7AUjCGt8dxQXRF3cS6NkiiZnOlx9uHUHVJwDhLybG6p0rbpqLghVeLrhg7odcz
 0183ry55ejbKsMW2iM5cXmbah3TJdlRZy5uLMAv8q86B4k0F0UhDlSKxXVHHJMJZAq5P 9w== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 37wqtm1svd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 14 Apr 2021 06:21:08 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 14 Apr
 2021 06:21:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Apr 2021 06:21:06 -0700
Received: from nw-bp.marvell.com (nw-bp.marvell.com [10.5.24.22])
        by maili.marvell.com (Postfix) with ESMTP id 22F443F7043;
        Wed, 14 Apr 2021 06:21:01 -0700 (PDT)
From:   <bpeled@marvell.com>
To:     <thomas.petazzoni@bootlin.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <robh+dt@kernel.org>, <mw@semihalf.com>,
        <jaz@semihalf.com>, <kostap@marvell.com>, <nadavh@marvell.com>,
        <stefanc@marvell.com>, <oferh@marvell.com>,
        Ben Peled <bpeled@marvell.com>,
        Marc St-Amand <mstamand@ciena.com>
Subject: =?UTF-8?q?=5B=E2=80=9DPATCH=E2=80=9D=20v2=201/5=5D=20PCI=3A=20armada8k=3A=20Disable=20LTSSM=20on=20link=20down=20interrupts?=
Date:   Wed, 14 Apr 2021 16:20:50 +0300
Message-ID: <1618406454-7953-2-git-send-email-bpeled@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1618406454-7953-1-git-send-email-bpeled@marvell.com>
References: <1618406454-7953-1-git-send-email-bpeled@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WDbkL8ZwggSTTIPgQA8z11jWe6SvOfXT
X-Proofpoint-GUID: WDbkL8ZwggSTTIPgQA8z11jWe6SvOfXT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-14_07:2021-04-14,2021-04-14 signatures=0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ben Peled <bpeled@marvell.com>

When a PCI link down condition is detected, the link training state
machine must be disabled immediately.

Signed-off-by: Marc St-Amand <mstamand@ciena.com>
Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
Signed-off-by: Ben Peled <bpeled@marvell.com>
---
 drivers/pci/controller/dwc/pcie-armada8k.c | 38 ++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index 13901f3..b2278b1 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -54,6 +54,10 @@ struct armada8k_pcie {
 #define PCIE_INT_C_ASSERT_MASK		BIT(11)
 #define PCIE_INT_D_ASSERT_MASK		BIT(12)
 
+#define PCIE_GLOBAL_INT_CAUSE2_REG	(PCIE_VENDOR_REGS_OFFSET + 0x24)
+#define PCIE_GLOBAL_INT_MASK2_REG	(PCIE_VENDOR_REGS_OFFSET + 0x28)
+#define PCIE_INT2_PHY_RST_LINK_DOWN	BIT(1)
+
 #define PCIE_ARCACHE_TRC_REG		(PCIE_VENDOR_REGS_OFFSET + 0x50)
 #define PCIE_AWCACHE_TRC_REG		(PCIE_VENDOR_REGS_OFFSET + 0x54)
 #define PCIE_ARUSER_REG			(PCIE_VENDOR_REGS_OFFSET + 0x5C)
@@ -193,6 +197,11 @@ static void armada8k_pcie_establish_link(struct armada8k_pcie *pcie)
 	       PCIE_INT_C_ASSERT_MASK | PCIE_INT_D_ASSERT_MASK;
 	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK1_REG, reg);
 
+	/* Also enable link down interrupts */
+	reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_MASK2_REG);
+	reg |= PCIE_INT2_PHY_RST_LINK_DOWN;
+	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK2_REG, reg);
+
 	if (!dw_pcie_link_up(pci)) {
 		/* Configuration done. Start LTSSM */
 		reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_CONTROL_REG);
@@ -230,6 +239,35 @@ static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
 	val = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_CAUSE1_REG);
 	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_CAUSE1_REG, val);
 
+	val = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_CAUSE2_REG);
+
+	if (PCIE_INT2_PHY_RST_LINK_DOWN & val) {
+		u32 ctrl_reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_CONTROL_REG);
+		/*
+		 * The link went down. Disable LTSSM immediately. This
+		 * unlocks the root complex config registers. Downstream
+		 * device accesses will return all-Fs
+		 */
+		ctrl_reg &= ~(PCIE_APP_LTSSM_EN);
+		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_CONTROL_REG, ctrl_reg);
+		/*
+		 * Mask link down interrupts. They can be re-enabled once
+		 * the link is retrained.
+		 */
+		ctrl_reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_MASK2_REG);
+		ctrl_reg &= ~PCIE_INT2_PHY_RST_LINK_DOWN;
+		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK2_REG, ctrl_reg);
+		/*
+		 * At this point a worker thread can be triggered to
+		 * initiate a link retrain. If link retrains were
+		 * possible, that is.
+		 */
+		dev_dbg(pci->dev, "%s: link went down\n", __func__);
+	}
+
+	/* Now clear the second interrupt cause. */
+	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_CAUSE2_REG, val);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.7.4

