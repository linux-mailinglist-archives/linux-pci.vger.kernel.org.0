Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D53935C9E7
	for <lists+linux-pci@lfdr.de>; Mon, 12 Apr 2021 17:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242912AbhDLPby (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Apr 2021 11:31:54 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:8832 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242897AbhDLPbs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Apr 2021 11:31:48 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13CFV7Ua004582;
        Mon, 12 Apr 2021 08:31:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pfpt0220;
 bh=RexkldyiWF9tZFzZsnrDwTW8chiyq0PpHMBC00a8QLE=;
 b=RdiWzifQamqPypkPFmPsg7ZO9evnHUnO2qktMbN7ONGtJCv2+oWLWX52p9iu7qyOpDqu
 FjCFei9qtxG9OQrc2dlKdXQDpe8vDyLvv93QzvHuG7FTcrAtzuGg1/ztMsNqt/gfkYtR
 xDdgivbuSspEqYvMHxMbw6cqeOVCpqZAS6WZ5ZvbEBMl1qiPVp9NdfOEVOsB++3dzjk6
 +182Hu3PGByhrun/E86x6gz1X8G8O142uDcqKrRQivm7sOfO/ZtQDXX1SnPJvKolA/5b
 hEq7Xm4VAhlUI38ZUcinu0KshYONxvwy/VTHkV6EiobG8cU5NqzGtxdvV1JekgncTuO9 ww== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 37vcu99xpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 08:31:15 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Apr
 2021 08:31:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 12 Apr 2021 08:31:14 -0700
Received: from nw-bp.marvell.com (nw-bp.marvell.com [10.5.24.22])
        by maili.marvell.com (Postfix) with ESMTP id DCEC33F7041;
        Mon, 12 Apr 2021 08:31:09 -0700 (PDT)
From:   <bpeled@marvell.com>
To:     <thomas.petazzoni@bootlin.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <robh+dt@kernel.org>, <mw@semihalf.com>,
        <jaz@semihalf.com>, <kostap@marvell.com>, <nadavh@marvell.com>,
        <stefanc@marvell.com>, <oferh@marvell.com>, <bpeled@marvell.com>
Subject: =?UTF-8?q?=5B=E2=80=9DPATCH=E2=80=9D=202/5=5D=20PCI=3A=20armada8k=3A=20Add=20link-down=20handle?=
Date:   Mon, 12 Apr 2021 18:30:53 +0300
Message-ID: <1618241456-27200-3-git-send-email-bpeled@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1618241456-27200-1-git-send-email-bpeled@marvell.com>
References: <1618241456-27200-1-git-send-email-bpeled@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: RWQfULCncbRL2HVMf5TzRz8HAgeHj0GO
X-Proofpoint-ORIG-GUID: RWQfULCncbRL2HVMf5TzRz8HAgeHj0GO
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_11:2021-04-12,2021-04-12 signatures=0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ben Peled <bpeled@marvell.com>

In PCIE ISR routine caused by RST_LINK_DOWN
we schedule work to handle the link-down procedure.
Link-down procedure will:
1. Remove PCIe bus
2. Reset the MAC
3. Reconfigure link back up
4. Rescan PCIe bus

Signed-off-by: Ben Peled <bpeled@marvell.com>
---
 drivers/pci/controller/dwc/pcie-armada8k.c | 68 ++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index b2278b1..4eb8607 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -22,6 +22,8 @@
 #include <linux/resource.h>
 #include <linux/of_pci.h>
 #include <linux/of_irq.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 #include "pcie-designware.h"
 
@@ -33,6 +35,9 @@ struct armada8k_pcie {
 	struct clk *clk_reg;
 	struct phy *phy[ARMADA8K_PCIE_MAX_LANES];
 	unsigned int phy_count;
+	struct regmap *sysctrl_base;
+	u32 mac_rest_bitmask;
+	struct work_struct recover_link_work;
 };
 
 #define PCIE_VENDOR_REGS_OFFSET		0x8000
@@ -73,6 +78,8 @@ struct armada8k_pcie {
 #define AX_USER_DOMAIN_MASK		0x3
 #define AX_USER_DOMAIN_SHIFT		4
 
+#define UNIT_SOFT_RESET_CONFIG_REG	0x268
+
 #define to_armada8k_pcie(x)	dev_get_drvdata((x)->dev)
 
 static void armada8k_pcie_disable_phys(struct armada8k_pcie *pcie)
@@ -224,6 +231,49 @@ static int armada8k_pcie_host_init(struct pcie_port *pp)
 
 	return 0;
 }
+static void armada8k_pcie_recover_link(struct work_struct *ws)
+{
+	struct armada8k_pcie *pcie = container_of(ws, struct armada8k_pcie, recover_link_work);
+	struct pcie_port *pp = &pcie->pci->pp;
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
+	ret = armada8k_pcie_host_init(pp);
+	if (ret) {
+		dev_err(pcie->pci->dev, "failed to initialize host: %d\n", ret);
+		pci_unlock_rescan_remove();
+		pci_dev_put(root_port);
+		return;
+	}
+
+	bus = NULL;
+	while ((bus = pci_find_next_bus(bus)) != NULL)
+		pci_rescan_bus(bus);
+	pci_unlock_rescan_remove();
+	pci_dev_put(root_port);
+}
 
 static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
 {
@@ -262,6 +312,9 @@ static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
 		 * initiate a link retrain. If link retrains were
 		 * possible, that is.
 		 */
+		if (pcie->sysctrl_base && pcie->mac_rest_bitmask)
+			schedule_work(&pcie->recover_link_work);
+
 		dev_dbg(pci->dev, "%s: link went down\n", __func__);
 	}
 
@@ -330,6 +383,8 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 
 	pcie->pci = pci;
 
+	INIT_WORK(&pcie->recover_link_work, armada8k_pcie_recover_link);
+
 	pcie->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(pcie->clk))
 		return PTR_ERR(pcie->clk);
@@ -357,6 +412,19 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
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
2.7.4

