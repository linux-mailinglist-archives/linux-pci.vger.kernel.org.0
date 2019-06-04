Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA2D34835
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 15:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfFDNSm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jun 2019 09:18:42 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55042 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbfFDNSl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2019 09:18:41 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x54DHf13028057;
        Tue, 4 Jun 2019 08:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559654261;
        bh=RElHPxtACkCdk4rLufC/bmJZmseWFYOIIvYrh7aFO/8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ctcAw7L7QUByHCOouvIbfAiWv5Zee8mbXY3jZXhr2OTNddfQLtmVD7zJnqx/VdTyr
         lC1MgB43JIWeJjcT739mZpUBUOpgDiQwkfxViuPTLl3GsgePCdIvDMwpmCh+CjaqWG
         lqtruagGs6y45G+xx4UhzoFRKD5nWMZRXj0nSwfY=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x54DHeFX052834
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Jun 2019 08:17:40 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 4 Jun
 2019 08:17:40 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 4 Jun 2019 08:17:40 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x54DGdGQ098972;
        Tue, 4 Jun 2019 08:17:35 -0500
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
Subject: [RFC PATCH 10/30] PCI: cadence: Use *_start_link() and *_wait_for_link() to establish link
Date:   Tue, 4 Jun 2019 18:44:56 +0530
Message-ID: <20190604131516.13596-11-kishon@ti.com>
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

Use cdns_pcie_start_link() to start link training and
cdns_pcie_wait_for_link() in order to wait to establish the link.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/pcie-cadence-ep.c   | 11 ++++++++++-
 drivers/pci/controller/pcie-cadence-host.c | 11 +++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
index b044167071e6..825a515821c3 100644
--- a/drivers/pci/controller/pcie-cadence-ep.c
+++ b/drivers/pci/controller/pcie-cadence-ep.c
@@ -21,6 +21,7 @@
 /**
  * struct cdns_pcie_ep - private data for this PCIe endpoint controller driver
  * @pcie: Cadence PCIe controller
+ * @dev: pointer to PCIe EP device
  * @max_regions: maximum number of regions supported by hardware
  * @ob_region_map: bitmask of mapped outbound regions
  * @ob_addr: base addresses in the AXI bus where the outbound regions start
@@ -37,6 +38,7 @@
  */
 struct cdns_pcie_ep {
 	struct cdns_pcie		pcie;
+	struct device			*dev;
 	u32				max_regions;
 	unsigned long			ob_region_map;
 	phys_addr_t			*ob_addr;
@@ -386,6 +388,7 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
 	struct pci_epf *epf;
+	int ret = 0;
 	u32 cfg;
 
 	/*
@@ -397,7 +400,11 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 		cfg |= BIT(epf->func_no);
 	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, cfg);
 
-	return 0;
+	ret = cdns_pcie_start_link(pcie, true);
+	if (ret)
+		dev_err(ep->dev, "Failed to start link\n");
+
+	return ret;
 }
 
 static const struct pci_epc_features cdns_pcie_epc_features = {
@@ -460,6 +467,8 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
 	if (!ep)
 		return -ENOMEM;
 
+	ep->dev = dev;
+
 	pcie = &ep->pcie;
 	pcie->is_rc = false;
 	pcie->plat_data = pdev->dev.platform_data;
diff --git a/drivers/pci/controller/pcie-cadence-host.c b/drivers/pci/controller/pcie-cadence-host.c
index 2363f05e7c58..4ad8f2ece6e2 100644
--- a/drivers/pci/controller/pcie-cadence-host.c
+++ b/drivers/pci/controller/pcie-cadence-host.c
@@ -365,6 +365,14 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
 		goto err_get_sync;
 	}
 
+	ret = cdns_pcie_start_link(pcie, true);
+	if (ret) {
+		dev_err(dev, "Failed to start link\n");
+		goto err_start_link;
+	}
+
+	cdns_pcie_wait_for_link(dev, pcie);
+
 	ret = cdns_pcie_host_init(dev, &resources, rc);
 	if (ret)
 		goto err_init;
@@ -386,6 +394,9 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
 	pci_free_resource_list(&resources);
 
  err_init:
+	cdns_pcie_start_link(pcie, false);
+
+ err_start_link:
 	pm_runtime_put_sync(dev);
 
  err_get_sync:
-- 
2.17.1

