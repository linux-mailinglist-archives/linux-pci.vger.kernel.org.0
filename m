Return-Path: <linux-pci+bounces-16501-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1F99C4F21
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 08:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FA2B1F22FBD
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 07:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02453208217;
	Tue, 12 Nov 2024 07:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="OCKYIpaS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E4A4C91;
	Tue, 12 Nov 2024 07:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731395291; cv=none; b=BSG7RiGQMjxVFqa2kMZmi7LVPMqsV4X4LTQ7PyV0EDgidkwR/xcPXrBgFwBkbUHsBkADcu4eW0OFi71i62lQ16hFvw9be8bsib21IAacLIT+DuidWTtl9H/xurvUw+dcauoOt6t1FVrFdcHblSQVgKZvrqMHU0QQD42+rdt8z3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731395291; c=relaxed/simple;
	bh=hPJ9b+LAB8Cy/8kbisAyVbSJuv+QHdGjxX3F0YiWX0E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nKr6WaeC+YWjjdL68tLuC9DNaMuhjgWVWi/FASVRzflM/WTVvTMQm8Af7ToUE/mupIP50EQ+Du+F3/y+X/BVd77PvyQxGdd7ZuJt5axHwQA6Nr9Bf8WBWSGPlpY303GKBnJHOaAyAvQuktOMpTCQI082RAOFB/UaIFCVKFVBpKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=OCKYIpaS; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABGFCSQ010340;
	Mon, 11 Nov 2024 23:07:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=tNGtlJ859MOStlOAyMOnTuu
	TvP/WK9GKtzqFV9IHsbk=; b=OCKYIpaS37KImCKR/doeRPfVwQUDWp0rpS69Kwv
	+1SKPKgK5AaizvxhWG1m5p9HTU5qdWnHzO/k7hM0JrbDycALrPdY1m9Yusol0zyz
	nt+v6816bLAm+Mwh7DBdH7nOy//HKU7TLTGeBBmZ/GllhMVqH3AkT3JM7nOlwv9S
	DsvwMC3o/cMN+kiNB8D0pi3C9sjqtOwEusZwGoLmwIHwFrsD3akCc3GwxNMzAmrQ
	0AAAH/PW5NZAqnHIgq440AfnqcET4xElkkYnudeJ8XdbAojlox8J6xO81dfsjKCm
	zOyVlv/71tiNvMNWWcAjddXrP9hEnmi3T7c/oPtwA3W/54Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42un9d1cf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 23:07:49 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 11 Nov 2024 23:07:48 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 11 Nov 2024 23:07:48 -0800
Received: from localhost.localdomain (unknown [10.111.135.16])
	by maili.marvell.com (Postfix) with ESMTP id 2E4F43F707F;
	Mon, 11 Nov 2024 23:07:48 -0800 (PST)
From: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
To: <lpieralisi@kernel.org>, <thomas.petazzoni@bootlin.com>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <salee@marvell.com>, <dingwei@marvell.com>,
        Jenishkumar Maheshbhai Patel
	<jpatel2@marvell.com>
Subject: [PATCH 1/1] PCI: armada8k: use reset controller to reset mac
Date: Mon, 11 Nov 2024 23:07:45 -0800
Message-ID: <20241112070745.759678-1-jpatel2@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: XMOBZNRL9HXZhZ4epaptv3UUDHs_xQIu
X-Proofpoint-ORIG-GUID: XMOBZNRL9HXZhZ4epaptv3UUDHs_xQIu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

change mac reset and mac reset bits to reset controller

Signed-off-by: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
---
 drivers/pci/controller/dwc/pcie-armada8k.c | 30 +++++++---------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index 9a48ef60be51..f9d6907900d1 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -21,7 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/resource.h>
 #include <linux/of_pci.h>
-#include <linux/mfd/syscon.h>
+#include <linux/reset.h>
 #include <linux/regmap.h>
 #include <linux/of_gpio.h>
 
@@ -35,11 +35,10 @@ struct armada8k_pcie {
 	struct clk *clk_reg;
 	struct phy *phy[ARMADA8K_PCIE_MAX_LANES];
 	unsigned int phy_count;
-	struct regmap *sysctrl_base;
-	u32 mac_rest_bitmask;
 	struct work_struct recover_link_work;
 	enum of_gpio_flags flags;
 	struct gpio_desc *reset_gpio;
+	struct reset_control *reset;
 };
 
 #define PCIE_VENDOR_REGS_OFFSET		0x8000
@@ -257,12 +256,9 @@ static void armada8k_pcie_recover_link(struct work_struct *ws)
 	msleep(100);
 
 	/* Reset mac */
-	regmap_update_bits_base(pcie->sysctrl_base, UNIT_SOFT_RESET_CONFIG_REG,
-				pcie->mac_rest_bitmask, 0, NULL, false, true);
+	reset_control_assert(pcie->reset);
 	udelay(1);
-	regmap_update_bits_base(pcie->sysctrl_base, UNIT_SOFT_RESET_CONFIG_REG,
-				pcie->mac_rest_bitmask, pcie->mac_rest_bitmask,
-				NULL, false, true);
+	reset_control_deassert(pcie->reset);
 	udelay(1);
 
 	ret = dw_pcie_setup_rc(pp);
@@ -331,7 +327,7 @@ static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
 		 * initiate a link retrain. If link retrains were
 		 * possible, that is.
 		 */
-		if (pcie->sysctrl_base && pcie->mac_rest_bitmask)
+		if (pcie->reset)
 			schedule_work(&pcie->recover_link_work);
 
 		dev_dbg(pci->dev, "%s: link went down\n", __func__);
@@ -440,18 +436,10 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 	if (gpio_is_valid(reset_gpio))
 		pcie->reset_gpio = gpio_to_desc(reset_gpio);
 
-	pcie->sysctrl_base = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
-						       "marvell,system-controller");
-	if (IS_ERR(pcie->sysctrl_base)) {
-		dev_warn(dev, "failed to find marvell,system-controller\n");
-		pcie->sysctrl_base = 0x0;
-	}
-
-	ret = of_property_read_u32(pdev->dev.of_node, "marvell,mac-reset-bit-mask",
-				   &pcie->mac_rest_bitmask);
-	if (ret < 0) {
-		dev_warn(dev, "couldn't find mac reset bit mask: %d\n", ret);
-		pcie->mac_rest_bitmask = 0x0;
+	pcie->reset = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(pcie->reset)) {
+		dev_warn(dev, "failed to find mac reset\n");
+		pcie->reset = 0x0;
 	}
 	ret = armada8k_pcie_setup_phys(pcie);
 	if (ret)
-- 
2.25.1


