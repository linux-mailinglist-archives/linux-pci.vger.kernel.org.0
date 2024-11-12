Return-Path: <linux-pci+bounces-16499-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAB09C4F17
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 08:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8F01F21D50
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 07:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BF320512D;
	Tue, 12 Nov 2024 07:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="QOHZpFNm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9D14C91;
	Tue, 12 Nov 2024 07:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731395006; cv=none; b=KKtQvoQIU7Lix9rTtvHULTAGxnqZkuWwc7wxCx1hcm6UTFeo13YJT5SS2bciXWfpJBPt77LDfSf+UBnYewenGaY9nBhk8IlYv95MC9FI2Wr3mcZcv3VETNeNk93I/Z+52e+oxKXAeLHYx/oCfuRSd6HzfNGUsh/o1D82HEw+yN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731395006; c=relaxed/simple;
	bh=Yn8usIRMux81A3PCYW8G4pm8l+e3rtKMvnYpXE7MPjE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Upiib55z/JXZRB+ZDba37UmcCRU1JWwR6tXnouTGL4tDjok/fZJdGXlUf8lla2So0k+QO55DPQmr80hYdQYSMeyA4LIU9vqMcZjWMdbrPcvkvhJCESuFOwFzHbjYS4DN4WrBXNDZrrnkQlMMZrAo7lNs6JYsZGSaZEeUFriaUzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=QOHZpFNm; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABBRxPG004091;
	Mon, 11 Nov 2024 23:03:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=SKQUSO5YDnv7240ilmklD3d
	ez7MzGqqX0CZV4jKO/Os=; b=QOHZpFNm7+ZqND1wfc/glGDzTFmqA32c31ynHz9
	ib2ydoLXyha27EZl2XCqQkqzRW5QpFnNNKigeUm6YwIVRIxGONLGf0ZFGjtafeth
	HCE8o+CpXXbDrrq8WH0USjeNDvRDwqVgNjot4vdwWHFHVB8oE3cL9obs4wsmhKS3
	JM5moVkstQTiRSiDBWx/Zf7gect95u+7CqmajXbzW/hbRt3RFI/w3IbkTAUDRFqA
	BsSj/qEs2VL45iYjln2UYyB/JEPjgIQvvsuGdidTJFCpvpesHcx1N3AgUU8zQ/jj
	T3ADMl4rbdRaLSyQeTBfc8YiNBcpn+mZtI2hisYhA12hWAw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42uh2t9sw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 23:03:14 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 11 Nov 2024 23:03:13 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 11 Nov 2024 23:03:13 -0800
Received: from localhost.localdomain (unknown [10.111.135.16])
	by maili.marvell.com (Postfix) with ESMTP id 0019B3F707F;
	Mon, 11 Nov 2024 23:03:12 -0800 (PST)
From: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
To: <lpieralisi@kernel.org>, <thomas.petazzoni@bootlin.com>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <salee@marvell.com>, <dingwei@marvell.com>,
        Jenishkumar Maheshbhai Patel
	<jpatel2@marvell.com>
Subject: [PATCH 1/1] PCI: armada8k: add device reset to link-down handle
Date: Mon, 11 Nov 2024 23:03:10 -0800
Message-ID: <20241112070310.757856-1-jpatel2@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: psM33TWMXEJ3OW10rY3DRVeU1e7PQ2FR
X-Proofpoint-ORIG-GUID: psM33TWMXEJ3OW10rY3DRVeU1e7PQ2FR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Added pcie reset via gpio support as described in the
designware-pcie.txt DT binding document.
In cases link down cause still exist in device.
The device need to be reset to reestablish the link.
If reset-gpio pin provided in the device tree, then the linkdown
handle resets the device before reestablishing link.

Signed-off-by: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
---
 drivers/pci/controller/dwc/pcie-armada8k.c | 24 ++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index b1b48c2016f7..9a48ef60be51 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -23,6 +23,7 @@
 #include <linux/of_pci.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
+#include <linux/of_gpio.h>
 
 #include "pcie-designware.h"
 
@@ -37,6 +38,8 @@ struct armada8k_pcie {
 	struct regmap *sysctrl_base;
 	u32 mac_rest_bitmask;
 	struct work_struct recover_link_work;
+	enum of_gpio_flags flags;
+	struct gpio_desc *reset_gpio;
 };
 
 #define PCIE_VENDOR_REGS_OFFSET		0x8000
@@ -238,9 +241,18 @@ static void armada8k_pcie_recover_link(struct work_struct *ws)
 	}
 	pci_lock_rescan_remove();
 	pci_stop_and_remove_bus_device(root_port);
+	/* Reset device if reset gpio is set */
+	if (pcie->reset_gpio) {
+		/* assert and then deassert the reset signal */
+		gpiod_set_value_cansleep(pcie->reset_gpio, 0);
+		msleep(100);
+		gpiod_set_value_cansleep(pcie->reset_gpio,
+					 (pcie->flags & OF_GPIO_ACTIVE_LOW) ? 0 : 1);
+	}
 	/*
-	 * Sleep needed to make sure all pcie transactions and access
-	 * are flushed before resetting the mac
+	 * Sleep used for two reasons.
+	 * First make sure all pcie transactions and access are flushed before resetting the mac
+	 * and second to make sure pci device is ready in case we reset the device
 	 */
 	msleep(100);
 
@@ -376,6 +388,7 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 	struct armada8k_pcie *pcie;
 	struct device *dev = &pdev->dev;
 	struct resource *base;
+	int reset_gpio;
 	int ret;
 
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
@@ -420,6 +433,13 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 		goto fail_clkreg;
 	}
 
+	/* Config reset gpio for pcie if the reset connected to gpio */
+	reset_gpio = of_get_named_gpio_flags(pdev->dev.of_node,
+					     "reset-gpios", 0,
+					     &pcie->flags);
+	if (gpio_is_valid(reset_gpio))
+		pcie->reset_gpio = gpio_to_desc(reset_gpio);
+
 	pcie->sysctrl_base = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
 						       "marvell,system-controller");
 	if (IS_ERR(pcie->sysctrl_base)) {
-- 
2.25.1


