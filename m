Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66809330829
	for <lists+linux-pci@lfdr.de>; Mon,  8 Mar 2021 07:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbhCHGgw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Mar 2021 01:36:52 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55912 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234885AbhCHGgi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Mar 2021 01:36:38 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1286aKYH110190;
        Mon, 8 Mar 2021 00:36:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615185380;
        bh=RuH1XyFPlD2/xUnAbgo3c6Sl0V2SC3r4WGxGh2uZNc8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Yosq7WEROYMiwO5WYdQCKxSPFbB5wBZOqj5aFd8uqPawsoc38DdGULVdseFS45BSG
         Vvd4MrLkLcwK/QBHNDWnjdAFmgD8Fypi7iQnSA5K9EpECQzIwJW6nsMiWyuP1EyxCp
         r82XbC4hq/rjyPGcYW4QCVX2T556YyqzPhp+MinI=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1286aKZ7017883
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Mar 2021 00:36:20 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 8 Mar
 2021 00:36:20 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 8 Mar 2021 00:36:20 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1286ZuTW117458;
        Mon, 8 Mar 2021 00:36:16 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nadeem Athani <nadeem@cadence.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v4 4/4] PCI: j721e: Add support to provide refclk to PCIe connector
Date:   Mon, 8 Mar 2021 12:05:50 +0530
Message-ID: <20210308063550.6227-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210308063550.6227-1-kishon@ti.com>
References: <20210308063550.6227-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to provide refclk to PCIe connector.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index dac1ac8a7615..7f9dd34b98a9 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -6,6 +6,7 @@
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  */
 
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/io.h>
@@ -50,6 +51,7 @@ enum link_status {
 
 struct j721e_pcie {
 	struct device		*dev;
+	struct clk		*refclk;
 	u32			mode;
 	u32			num_lanes;
 	struct cdns_pcie	*cdns_pcie;
@@ -310,6 +312,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	struct cdns_pcie_ep *ep;
 	struct gpio_desc *gpiod;
 	void __iomem *base;
+	struct clk *clk;
 	u32 num_lanes;
 	u32 mode;
 	int ret;
@@ -408,6 +411,20 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 			goto err_get_sync;
 		}
 
+		clk = devm_clk_get_optional(dev, "pcie_refclk");
+		if (IS_ERR(clk)) {
+			ret = PTR_ERR(clk);
+			dev_err(dev, "failed to get pcie_refclk\n");
+			goto err_pcie_setup;
+		}
+
+		ret = clk_prepare_enable(clk);
+		if (ret) {
+			dev_err(dev, "failed to enable pcie_refclk\n");
+			goto err_get_sync;
+		}
+		pcie->refclk = clk;
+
 		/*
 		 * "Power Sequencing and Reset Signal Timings" table in
 		 * PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, REV. 3.0
@@ -422,8 +439,10 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 		}
 
 		ret = cdns_pcie_host_setup(rc);
-		if (ret < 0)
+		if (ret < 0) {
+			clk_disable_unprepare(pcie->refclk);
 			goto err_pcie_setup;
+		}
 
 		break;
 	case PCI_MODE_EP:
@@ -476,6 +495,7 @@ static int j721e_pcie_remove(struct platform_device *pdev)
 	struct cdns_pcie *cdns_pcie = pcie->cdns_pcie;
 	struct device *dev = &pdev->dev;
 
+	clk_disable_unprepare(pcie->refclk);
 	cdns_pcie_disable_phy(cdns_pcie);
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
-- 
2.17.1

