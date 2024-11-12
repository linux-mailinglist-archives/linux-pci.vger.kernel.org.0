Return-Path: <linux-pci+bounces-16497-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D63F9C4EFC
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 07:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1496D284D01
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 06:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E4D20A5DF;
	Tue, 12 Nov 2024 06:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="A0EtzYI9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987251A00D2;
	Tue, 12 Nov 2024 06:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731394621; cv=none; b=hNG9cbdTTLLjqQXWq+5BnJg+ZtNAruPflSlEetP9rJCbo2xx7ZqHc5F8bfdQiGRs9qoEl9FkkjKQqa5eB0LX933Ge6Q/CzsoQZL0iMF+0qn8PR3ScLYU550g/Kb2yz7M/Hobk6gEiwxOL6pgONTDmsXotwOGQLU2voIKVMqzZMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731394621; c=relaxed/simple;
	bh=cLpCTElYZKGqPuIil/8Lnuu83en/SEir3efhunx88xE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ADW6PELJSLrH5cCvHTQ5CLo94T+5in4khu/FLxlwhpoHaHb8wcZQv/+Kh4Lx8Vq3xzXWsARFyBaHLuJ83yIpGck4t2eBfj41uwPIjU8Kismd3ulvtAXh9UegJBPB8ruDFhcAjW1mHXrwjTBP4GWJO6/OIMFE9uGh6FxdZCXSK0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=A0EtzYI9; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABGFCRc010340;
	Mon, 11 Nov 2024 22:48:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=it0PWhZ6Py9wcP3BwHFqiF8
	eszHsXMGDx6aKEQlAf5Y=; b=A0EtzYI9pdf8iuaFBPqzRxkeT8fDRqeM2e3e3Ok
	FWJXH3tfTUkNYlyX30bGWIoCQxGzina2JGhdovy+09FOfA4YTsf2tVJIRNejBCMy
	ctrv55AwrzcHSMO7VfXO/jmTehWhpHYKjEDsh8rWC11pZzuijE45H2y3SjZWlx07
	IjeudkZhBzD5B6Aopz2UU8FR2+7I2OCI0M5esHH1mWEgj8DSjI6ykGNljJON16Af
	4octgODz3ue6TeVEF3tV/VsIWgkIKQGoUidIsKtzYVnpdMERyqgvyQ3wm24sacEz
	xI0WvOxumvzBeTF+CMMsXiVrQufwso8uciaIzQlaoOw+lbA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42un9d1bp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 22:48:17 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 11 Nov 2024 22:48:16 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 11 Nov 2024 22:48:16 -0800
Received: from localhost.localdomain (unknown [10.111.135.16])
	by maili.marvell.com (Postfix) with ESMTP id 260663F70B3;
	Mon, 11 Nov 2024 22:48:16 -0800 (PST)
From: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
To: <lpieralisi@kernel.org>, <thomas.petazzoni@bootlin.com>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <salee@marvell.com>, <dingwei@marvell.com>,
        Jenishkumar Maheshbhai Patel
	<jpatel2@marvell.com>
Subject: [PATCH 1/1] PCI: armada8k: Add link-down handle
Date: Mon, 11 Nov 2024 22:48:13 -0800
Message-ID: <20241112064813.751736-1-jpatel2@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: gXDo76xJBWVmnOD9BybTEMtM8svUZEa9
X-Proofpoint-ORIG-GUID: gXDo76xJBWVmnOD9BybTEMtM8svUZEa9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

In PCIE ISR routine caused by RST_LINK_DOWN
we schedule work to handle the link-down procedure.
Link-down procedure will:
1. Remove PCIe bus
2. Reset the MAC
3. Reconfigure link back up
4. Rescan PCIe bus

Signed-off-by: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
---
 drivers/pci/controller/dwc/pcie-armada8k.c | 84 ++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index 07775539b321..b1b48c2016f7 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -21,6 +21,8 @@
 #include <linux/platform_device.h>
 #include <linux/resource.h>
 #include <linux/of_pci.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 #include "pcie-designware.h"
 
@@ -32,6 +34,9 @@ struct armada8k_pcie {
 	struct clk *clk_reg;
 	struct phy *phy[ARMADA8K_PCIE_MAX_LANES];
 	unsigned int phy_count;
+	struct regmap *sysctrl_base;
+	u32 mac_rest_bitmask;
+	struct work_struct recover_link_work;
 };
 
 #define PCIE_VENDOR_REGS_OFFSET		0x8000
@@ -72,6 +77,8 @@ struct armada8k_pcie {
 #define AX_USER_DOMAIN_MASK		0x3
 #define AX_USER_DOMAIN_SHIFT		4
 
+#define UNIT_SOFT_RESET_CONFIG_REG	0x268
+
 #define to_armada8k_pcie(x)	dev_get_drvdata((x)->dev)
 
 static void armada8k_pcie_disable_phys(struct armada8k_pcie *pcie)
@@ -216,6 +223,65 @@ static int armada8k_pcie_host_init(struct dw_pcie_rp *pp)
 	return 0;
 }
 
+static void armada8k_pcie_recover_link(struct work_struct *ws)
+{
+	struct armada8k_pcie *pcie = container_of(ws, struct armada8k_pcie, recover_link_work);
+	struct dw_pcie_rp *pp = &pcie->pci->pp;
+	struct pci_bus *bus = pp->bridge->bus;
+	struct pci_dev *root_port;
+	int ret;
+
+	root_port = pci_get_slot(bus, 0);
+	if (!root_port) {
+		dev_err(pcie->pci->dev, "failed to get root port\n");
+		return;
+	}
+	pci_lock_rescan_remove();
+	pci_stop_and_remove_bus_device(root_port);
+	/*
+	 * Sleep needed to make sure all pcie transactions and access
+	 * are flushed before resetting the mac
+	 */
+	msleep(100);
+
+	/* Reset mac */
+	regmap_update_bits_base(pcie->sysctrl_base, UNIT_SOFT_RESET_CONFIG_REG,
+				pcie->mac_rest_bitmask, 0, NULL, false, true);
+	udelay(1);
+	regmap_update_bits_base(pcie->sysctrl_base, UNIT_SOFT_RESET_CONFIG_REG,
+				pcie->mac_rest_bitmask, pcie->mac_rest_bitmask,
+				NULL, false, true);
+	udelay(1);
+
+	ret = dw_pcie_setup_rc(pp);
+	if (ret)
+		goto fail;
+
+	ret = armada8k_pcie_host_init(pp);
+	if (ret) {
+		dev_err(pcie->pci->dev, "failed to initialize host: %d\n", ret);
+		goto fail;
+	}
+
+	if (!dw_pcie_link_up(pcie->pci)) {
+		ret = dw_pcie_start_link(pcie->pci);
+		if (ret)
+			goto fail;
+	}
+
+	/* Wait until the link becomes active again */
+	if (dw_pcie_wait_for_link(pcie->pci))
+		dev_err(pcie->pci->dev, "Link not up after reconfiguration\n");
+
+	bus = NULL;
+	while ((bus = pci_find_next_bus(bus)) != NULL)
+		pci_rescan_bus(bus);
+
+fail:
+	pci_unlock_rescan_remove();
+	pci_dev_put(root_port);
+}
+
 static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
 {
 	struct armada8k_pcie *pcie = arg;
@@ -253,6 +319,9 @@ static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
 		 * initiate a link retrain. If link retrains were
 		 * possible, that is.
 		 */
+		if (pcie->sysctrl_base && pcie->mac_rest_bitmask)
+			schedule_work(&pcie->recover_link_work);
+
 		dev_dbg(pci->dev, "%s: link went down\n", __func__);
 	}
 
@@ -322,6 +391,8 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 
 	pcie->pci = pci;
 
+	INIT_WORK(&pcie->recover_link_work, armada8k_pcie_recover_link);
+
 	pcie->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(pcie->clk))
 		return PTR_ERR(pcie->clk);
@@ -349,6 +420,19 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 		goto fail_clkreg;
 	}
 
+	pcie->sysctrl_base = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+						       "marvell,system-controller");
+	if (IS_ERR(pcie->sysctrl_base)) {
+		dev_warn(dev, "failed to find marvell,system-controller\n");
+		pcie->sysctrl_base = 0x0;
+	}
+
+	ret = of_property_read_u32(pdev->dev.of_node, "marvell,mac-reset-bit-mask",
+				   &pcie->mac_rest_bitmask);
+	if (ret < 0) {
+		dev_warn(dev, "couldn't find mac reset bit mask: %d\n", ret);
+		pcie->mac_rest_bitmask = 0x0;
+	}
 	ret = armada8k_pcie_setup_phys(pcie);
 	if (ret)
 		goto fail_clkreg;
-- 
2.25.1


