Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88CB435F4C0
	for <lists+linux-pci@lfdr.de>; Wed, 14 Apr 2021 15:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351293AbhDNNWD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Apr 2021 09:22:03 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:27736 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229450AbhDNNWC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Apr 2021 09:22:02 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13EDLQD6027731;
        Wed, 14 Apr 2021 06:21:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pfpt0220;
 bh=yL2TE49Ph1eFxqJLXW3dPQR/djJYvlhBmxhBpOY7iSI=;
 b=PAnU6weDFy20d1abhnCUKuiPfLUJjZLYPnFMFKmlgKQAKhBHzI/UZsrS1HSbgs6cD60u
 LcOyfXLvcO6phQcOf1pKZtdeb8S88DBBkKD1JSHehE1a5dj8+thN5XW3nB8gZl0UR8xq
 Dl0wb/gZWSbkz6sw38s6I45DKGD3IcpwsY/Y4mg/v+3p53AbarDshtz1Dd/ho1iYoU2p
 8PUSnWcXv9hQLzygwZliqfAJZ7GPGYsq4SR2vPK+VCm7qWKznEGbZoU7bt7FsYRXgqKP
 gpTXI32ey4bPVJDsrbESqgILyle86hYEqaiZIo+84sMKh8y/70LFFj58VY0/4Y5SUz/9 jQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 37wn4wt5r4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 14 Apr 2021 06:21:26 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 14 Apr
 2021 06:21:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Apr 2021 06:21:23 -0700
Received: from nw-bp.marvell.com (nw-bp.marvell.com [10.5.24.22])
        by maili.marvell.com (Postfix) with ESMTP id C05B83F7040;
        Wed, 14 Apr 2021 06:21:19 -0700 (PDT)
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
        Ben Peled <bpeled@marvell.com>
Subject: =?UTF-8?q?=5B=E2=80=9DPATCH=E2=80=9D=20v2=205/5=5D=20PCI=3A=20armada8k=3A=20add=20device=20reset=20to=20link-down=20handle?=
Date:   Wed, 14 Apr 2021 16:20:54 +0300
Message-ID: <1618406454-7953-6-git-send-email-bpeled@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1618406454-7953-1-git-send-email-bpeled@marvell.com>
References: <1618406454-7953-1-git-send-email-bpeled@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -cKwrM6rjjzn37Rup-lWxZXYcioIbeMp
X-Proofpoint-GUID: -cKwrM6rjjzn37Rup-lWxZXYcioIbeMp
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-14_07:2021-04-14,2021-04-14 signatures=0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ben Peled <bpeled@marvell.com>

Added pcie reset via gpio support as described in the
designware-pcie.txt DT binding document.
In cases link down cause still exist in device.
The device need to be reset to reestablish the link.
If reset-gpio pin provided in the device tree, then the linkdown
handle resets the device before reestablishing link.

Signed-off-by: Ben Peled <bpeled@marvell.com>
---
 drivers/pci/controller/dwc/pcie-armada8k.c | 24 ++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index 34b253c..04bba97 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -24,6 +24,7 @@
 #include <linux/of_irq.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
+#include <linux/of_gpio.h>
 
 #include "pcie-designware.h"
 
@@ -38,6 +39,8 @@ struct armada8k_pcie {
 	struct regmap *sysctrl_base;
 	u32 mac_rest_bitmask;
 	struct work_struct recover_link_work;
+	enum of_gpio_flags flags;
+	struct gpio_desc *reset_gpio;
 };
 
 #define PCIE_VENDOR_REGS_OFFSET		0x8000
@@ -247,9 +250,18 @@ static void armada8k_pcie_recover_link(struct work_struct *ws)
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
 
@@ -369,6 +381,7 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 	struct armada8k_pcie *pcie;
 	struct device *dev = &pdev->dev;
 	struct resource *base;
+	int reset_gpio;
 	int ret;
 
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
@@ -413,6 +426,13 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
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
2.7.4

