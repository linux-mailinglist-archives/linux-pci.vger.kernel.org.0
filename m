Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14DC234806
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 15:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfFDNSE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jun 2019 09:18:04 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50382 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbfFDNSE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2019 09:18:04 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x54DHktZ082389;
        Tue, 4 Jun 2019 08:17:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559654266;
        bh=t0jA6IyzaKFpaRxG+xMzbQ3TeSZ/biJLiuqhdnBH3TQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=KZr/Yb1n2JCx1xdXk+5fWxz251JLI16pKngaDfG2QC6hGXVLV4i5gvy6cCgIsJMjP
         c4WNdd1kbTd+yYCRuS/k+h6OJjnmI4OPZi0H3EJWyU1J15IIwDqImxqx57wu5Udo9Z
         bvFpZC/srm1v2Mm4BAhsZsXo0/fnO3zxZwm++kmk=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x54DHkn2042937
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Jun 2019 08:17:46 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 4 Jun
 2019 08:17:46 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 4 Jun 2019 08:17:46 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x54DGdGR098972;
        Tue, 4 Jun 2019 08:17:41 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 11/30] PCI: cadence: Add support to drive PERST# line using GPIO
Date:   Tue, 4 Jun 2019 18:44:57 +0530
Message-ID: <20190604131516.13596-12-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604131516.13596-1-kishon@ti.com>
References: <20190604131516.13596-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In platforms like TI's J721E EVM, the PERST# line is connected to a
GPIO line and PERST# should be driven high to indicate the clocks are
stable (As per Figure 2-10: Power Up of the PCIe CEM spec 3.0).

Add support to make GPIO drive PERST# line.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/pcie-cadence-host.c | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/pci/controller/pcie-cadence-host.c b/drivers/pci/controller/pcie-cadence-host.c
index 4ad8f2ece6e2..8b3b9827a8d6 100644
--- a/drivers/pci/controller/pcie-cadence-host.c
+++ b/drivers/pci/controller/pcie-cadence-host.c
@@ -3,6 +3,8 @@
 // Cadence PCIe host controller driver.
 // Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
 
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
@@ -287,6 +289,7 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
 	struct pci_host_bridge *bridge;
 	struct list_head resources;
 	struct cdns_pcie_rc *rc;
+	struct gpio_desc *gpiod;
 	struct cdns_pcie *pcie;
 	struct resource *res;
 	int ret;
@@ -349,13 +352,36 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
 		dev_err(dev, "missing \"mem\"\n");
 		return -EINVAL;
 	}
+
 	pcie->mem_res = res;
 
+	gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod)) {
+		ret = PTR_ERR(gpiod);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get reset GPIO\n");
+		return ret;
+	}
+
 	ret = cdns_pcie_init_phy(dev, pcie);
 	if (ret) {
 		dev_err(dev, "failed to init phy\n");
 		return ret;
 	}
+
+	/*
+	 * "Power Sequencing and Reset Signal Timings" table in
+	 * PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, REV. 3.0
+	 * indicates PERST# should be deasserted after minimum of 100us
+	 * once REFCLK is stable. The REFCLK to the connector in RC
+	 * mode is selected while enabling the PHY. So deassert PERST#
+	 * after 100 us.
+	 */
+	if (gpiod) {
+		usleep_range(100, 200);
+		gpiod_set_value_cansleep(gpiod, 1);
+	}
+
 	platform_set_drvdata(pdev, pcie);
 
 	pm_runtime_enable(dev);
-- 
2.17.1

