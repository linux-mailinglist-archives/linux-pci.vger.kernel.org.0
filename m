Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4592E951E
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jan 2021 13:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbhADMmu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jan 2021 07:42:50 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56502 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbhADMmt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jan 2021 07:42:49 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 104Cg1Ai098496;
        Mon, 4 Jan 2021 06:42:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1609764121;
        bh=k3u+AVmoyV8AjjDEAKA55tnZJ8Kv6tWdf0rL6Di5au0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rAdjzeiC8CQMcOEpvggErBwS75NZ7TMRGP9V6lb9vef9mNtJDUspxN4fmaS2gZRSC
         e18ZIt+t8YPfxToVroEkRzXTYJjxfhfCEecaqiMuR7WAo/YuBdvCoK/Aucx7TE3iD9
         xP3gGfDJhiWqpSVlpCqOuBceYby6d0jMLaAK0YrQ=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 104Cg1mM096157
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Jan 2021 06:42:01 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 4 Jan
 2021 06:41:26 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 4 Jan 2021 06:41:26 -0600
Received: from a0393678-ssd.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 104Cf3bk034579;
        Mon, 4 Jan 2021 06:41:22 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nadeem Athani <nadeem@cadence.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 4/4] PCI: j721e: Add support to provide refclk to PCIe connector
Date:   Mon, 4 Jan 2021 18:11:03 +0530
Message-ID: <20210104124103.30930-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210104124103.30930-1-kishon@ti.com>
References: <20210104124103.30930-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to provide refclk to PCIe connector.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index dac1ac8a7615..2e73729c7388 100644
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
+			dev_err(dev, "failed to get pcie_refclk\n");
+			ret = PTR_ERR(clk);
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
@@ -476,6 +493,7 @@ static int j721e_pcie_remove(struct platform_device *pdev)
 	struct cdns_pcie *cdns_pcie = pcie->cdns_pcie;
 	struct device *dev = &pdev->dev;
 
+	clk_disable_unprepare(pcie->refclk);
 	cdns_pcie_disable_phy(cdns_pcie);
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
-- 
2.17.1

