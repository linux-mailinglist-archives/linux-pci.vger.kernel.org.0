Return-Path: <linux-pci+bounces-16495-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D459C4EDF
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 07:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED0728A24A
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 06:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118DF208230;
	Tue, 12 Nov 2024 06:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Asqa4Xh+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2227C1EBFFD;
	Tue, 12 Nov 2024 06:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731393805; cv=none; b=ZUBfJvnNpeTxLzmc8cXoeVAHp1Rpruw7nlzStN8xSEh6BM9Uh0urej2zLu1bF2+V2UBbGtXXjro4E1f6EbAvNU3SP51uOf8NuVcGK6tgMKl4Cvt037yGa3mcDMVQXe5kg0mTfVIyMSdm6EqoSeCokHE9+TOumgZavh2GA0CGkm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731393805; c=relaxed/simple;
	bh=UcwCPueJulWSkFqUB80HGBURui4A6wg6aTImCp5GGNA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JlsGTKu4X2aJ6WqhyWMg4pOwZYiu4KCcBQ//ZGEO5fw6XrwTE8Qfxc/CUI7RVIcRPZsxrNsj+IWq8/AJoagMgGWwMl1Mi3oWNOsdSqBnvx2pJvNdAu6Im9x8AOTJ02lgnpoRyyYpI6jrhNaDBR6l7CNXb3LLoBSfnrg0V8VIpfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Asqa4Xh+; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABGLWwT026372;
	Mon, 11 Nov 2024 22:42:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=sX7YiodoPeDSKhYbJ1Y5EqM
	xoHvu4S+GIOBJqn6nAUU=; b=Asqa4Xh+qL5xuzWkmvhgDcNLlYCF/e9Bi1FPyO6
	ArCk8cuHD0VDVLdLjZ5o6W0+hKUL/U5RnTc46S+Lz08UGFcQPLke6XKLugGm4lNu
	BVA60RIIy9ygmBFkUmU7ZZcNOIX1yvaVx6eaChDv0TyCZAyvPyqkjxEFdeTIrQtj
	JOhDz4AdDTpSW0knuVf63rnj3T1KXzQ7stNsQMlhB0dwqSSsq0wEDN4T++ZKtb1X
	feRTww5CUlo6W21gqY+y8A/j7zjeX8PiYOEURRSVM8NE1xas+K79PLEre06t3XxL
	Nm2p9dCsTNoxnm2IuZQCPKlAafGX0WXkuAXO36ixGTlvCOA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42t84pmj8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 22:42:51 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 11 Nov 2024 22:42:50 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 11 Nov 2024 22:42:50 -0800
Received: from localhost.localdomain (unknown [10.111.135.16])
	by maili.marvell.com (Postfix) with ESMTP id 838463F7079;
	Mon, 11 Nov 2024 22:42:49 -0800 (PST)
From: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
To: <lpieralisi@kernel.org>, <thomas.petazzoni@bootlin.com>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <salee@marvell.com>, <dingwei@marvell.com>,
        Jenishkumar Maheshbhai Patel
	<jpatel2@marvell.com>
Subject: [PATCH 1/1] PCI: armada8k: Disable LTSSM on link down interrupts
Date: Mon, 11 Nov 2024 22:42:41 -0800
Message-ID: <20241112064241.749493-1-jpatel2@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: LwPhCRUsieXdHV9l6Uw864Ev4W3g_4qj
X-Proofpoint-GUID: LwPhCRUsieXdHV9l6Uw864Ev4W3g_4qj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

When a PCI link down condition is detected, the link training state
machine must be disabled immediately.

Signed-off-by: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
---
 drivers/pci/controller/dwc/pcie-armada8k.c | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index b5c599ccaacf..07775539b321 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -53,6 +53,10 @@ struct armada8k_pcie {
 #define PCIE_INT_C_ASSERT_MASK		BIT(11)
 #define PCIE_INT_D_ASSERT_MASK		BIT(12)
 
+#define PCIE_GLOBAL_INT_CAUSE2_REG	(PCIE_VENDOR_REGS_OFFSET + 0x24)
+#define PCIE_GLOBAL_INT_MASK2_REG	(PCIE_VENDOR_REGS_OFFSET + 0x28)
+#define PCIE_INT2_PHY_RST_LINK_DOWN	BIT(1)
+
 #define PCIE_ARCACHE_TRC_REG		(PCIE_VENDOR_REGS_OFFSET + 0x50)
 #define PCIE_AWCACHE_TRC_REG		(PCIE_VENDOR_REGS_OFFSET + 0x54)
 #define PCIE_ARUSER_REG			(PCIE_VENDOR_REGS_OFFSET + 0x5C)
@@ -204,6 +208,11 @@ static int armada8k_pcie_host_init(struct dw_pcie_rp *pp)
 	       PCIE_INT_C_ASSERT_MASK | PCIE_INT_D_ASSERT_MASK;
 	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK1_REG, reg);
 
+	/* Also enable link down interrupts */
+	reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_MASK2_REG);
+	reg |= PCIE_INT2_PHY_RST_LINK_DOWN;
+	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK2_REG, reg);
+
 	return 0;
 }
 
@@ -221,6 +230,35 @@ static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
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
2.25.1


