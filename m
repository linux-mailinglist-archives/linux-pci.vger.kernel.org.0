Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FC535C9E4
	for <lists+linux-pci@lfdr.de>; Mon, 12 Apr 2021 17:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242904AbhDLPbu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Apr 2021 11:31:50 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:47208 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242899AbhDLPbr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Apr 2021 11:31:47 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13CFVBk6004588;
        Mon, 12 Apr 2021 08:31:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pfpt0220;
 bh=1w1aOW3ghY/Ww+N67gF96mJvYXQ0kxUthm1XoYVB+Qs=;
 b=kaq9aYBbPal/PUIU6NyIipJ3FFRg9k5/qlYxy/dijCi2a8Th+ZJ5W/f7zD0rVHXzlxl/
 wtAwGWpPZxhUasZ5SRQ78t9VkOJGLPhgHfUDG22ODTUYV7+EhvYrpvdRVBTEzs2+ozZM
 R2MKqkYdfqBZYcQ2JeRGjhk9JlV0QCJypYEprxwG5UWDq+kD9Wp7GmFlP++T1AxjpVI4
 FHoTbB0M9LZLoJTvfuw6BqXgNQI8VONqTl49C7poomwPR0XQ5e0aaiubDQrDCgo52ssz
 j+wi0gOD84gVbwl2mFu+vJhJ09KA90/VER8Xb39/Nl9R+LBWP8VLqcs287PFfImCSDPE 4A== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 37vcu99xp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 08:31:11 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Apr
 2021 08:31:09 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Apr
 2021 08:31:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 12 Apr 2021 08:31:09 -0700
Received: from nw-bp.marvell.com (nw-bp.marvell.com [10.5.24.22])
        by maili.marvell.com (Postfix) with ESMTP id 5290F3F7043;
        Mon, 12 Apr 2021 08:31:05 -0700 (PDT)
From:   <bpeled@marvell.com>
To:     <thomas.petazzoni@bootlin.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <robh+dt@kernel.org>, <mw@semihalf.com>,
        <jaz@semihalf.com>, <kostap@marvell.com>, <nadavh@marvell.com>,
        <stefanc@marvell.com>, <oferh@marvell.com>, <bpeled@marvell.com>,
        "Marc St-Amand" <mstamand@ciena.com>
Subject: =?UTF-8?q?=5B=E2=80=9DPATCH=E2=80=9D=201/5=5D=20PCI=3A=20armada8k=3A=20Disable=20LTSSM=20on=20link=20down=20interrupts?=
Date:   Mon, 12 Apr 2021 18:30:52 +0300
Message-ID: <1618241456-27200-2-git-send-email-bpeled@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1618241456-27200-1-git-send-email-bpeled@marvell.com>
References: <1618241456-27200-1-git-send-email-bpeled@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lH0eozCtIxCe8ZuBdcND7yXWxwbA3kra
X-Proofpoint-ORIG-GUID: lH0eozCtIxCe8ZuBdcND7yXWxwbA3kra
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_11:2021-04-12,2021-04-12 signatures=0
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

