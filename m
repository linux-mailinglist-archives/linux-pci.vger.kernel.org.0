Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2185734804
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 15:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfFDNR7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jun 2019 09:17:59 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54942 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbfFDNR7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2019 09:17:59 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x54DHZbs028030;
        Tue, 4 Jun 2019 08:17:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559654255;
        bh=NQisG6of0th5e5nh0dWxjvqkrQFUAwxLaJ6uQ3mRLhk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=p/w+dePUAOZBdhfQ0h69WotHcCUiE55mkIh05kVLvDhwP57FXWOS0v2PQ6GB0z8oC
         Ns6QDwgoGcD3juTUBM6xVmTZQPxxn6BDTSRI/PTavSeixh1+Sxn+walG/sXKZKphGO
         ByoDc+Hj6QGTVHa+raGna/KVWeHm4VUgqn4VBy50=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x54DHZFO052752
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Jun 2019 08:17:35 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 4 Jun
 2019 08:17:35 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 4 Jun 2019 08:17:34 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x54DGdGP098972;
        Tue, 4 Jun 2019 08:17:30 -0500
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
Subject: [RFC PATCH 09/30] PCI: cadence: Add platform_data to start link and check link status
Date:   Tue, 4 Jun 2019 18:44:55 +0530
Message-ID: <20190604131516.13596-10-kishon@ti.com>
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

Add support in cadence driver to read platform_data passed to it from
platform specific drivers. The platform_data right now contains two
ops, one to start link and the other to check the link status.
This is required since the registers for starting a link and for
checking link status is in the wrapper and not in Cadence PCIe core.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/pcie-cadence-ep.c   |  1 +
 drivers/pci/controller/pcie-cadence-host.c |  1 +
 drivers/pci/controller/pcie-cadence.c      | 41 ++++++++++++++++++++++
 drivers/pci/controller/pcie-cadence.h      | 13 +++++++
 4 files changed, 56 insertions(+)

diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
index 07f840cfba23..b044167071e6 100644
--- a/drivers/pci/controller/pcie-cadence-ep.c
+++ b/drivers/pci/controller/pcie-cadence-ep.c
@@ -462,6 +462,7 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
 
 	pcie = &ep->pcie;
 	pcie->is_rc = false;
+	pcie->plat_data = pdev->dev.platform_data;
 
 	data = (struct cdns_pcie_ep_data *)match->data;
 	if (data) {
diff --git a/drivers/pci/controller/pcie-cadence-host.c b/drivers/pci/controller/pcie-cadence-host.c
index ab6491b23775..2363f05e7c58 100644
--- a/drivers/pci/controller/pcie-cadence-host.c
+++ b/drivers/pci/controller/pcie-cadence-host.c
@@ -304,6 +304,7 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
 	rc->dev = dev;
 
 	pcie = &rc->pcie;
+	pcie->plat_data = pdev->dev.platform_data;
 	pcie->is_rc = true;
 
 	data = (struct cdns_pcie_host_data *)match->data;
diff --git a/drivers/pci/controller/pcie-cadence.c b/drivers/pci/controller/pcie-cadence.c
index de5b3b06f2d0..5ac42b19bb63 100644
--- a/drivers/pci/controller/pcie-cadence.c
+++ b/drivers/pci/controller/pcie-cadence.c
@@ -3,6 +3,7 @@
 // Cadence PCIe controller driver.
 // Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
 
+#include <linux/delay.h>
 #include <linux/kernel.h>
 
 #include "pcie-cadence.h"
@@ -47,6 +48,46 @@ void cdns_pcie_write32(void __iomem *addr, int size, u32 value)
 	writel(val, aligned_addr);
 }
 
+int cdns_pcie_start_link(struct cdns_pcie *pci, bool start)
+{
+	struct cdns_pcie_plat_data *plat_data;
+
+	plat_data = pci->plat_data;
+	if (!plat_data)
+		return 0;
+
+	return plat_data->start_link(plat_data, start);
+}
+
+static bool cdns_pcie_is_link_up(struct cdns_pcie *pci)
+{
+	struct cdns_pcie_plat_data *plat_data;
+
+	plat_data = pci->plat_data;
+	if (!plat_data)
+		return true;
+
+	return plat_data->is_link_up(plat_data);
+}
+
+int cdns_pcie_wait_for_link(struct device *dev, struct cdns_pcie *pci)
+{
+	int retries;
+
+	/* Check if the link is up or not */
+	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
+		if (cdns_pcie_is_link_up(pci)) {
+			dev_info(dev, "Link up\n");
+			return 0;
+		}
+		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
+	}
+
+	dev_err(dev, "Phy link never came up\n");
+
+	return -ETIMEDOUT;
+}
+
 void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 fn,
 				   u32 r, bool is_io,
 				   u64 cpu_addr, u64 pci_addr, size_t size)
diff --git a/drivers/pci/controller/pcie-cadence.h b/drivers/pci/controller/pcie-cadence.h
index d157bf5eabd5..3cef398b50da 100644
--- a/drivers/pci/controller/pcie-cadence.h
+++ b/drivers/pci/controller/pcie-cadence.h
@@ -10,6 +10,11 @@
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
 
+/* Parameters for the waiting for link up routine */
+#define LINK_WAIT_MAX_RETRIES	10
+#define LINK_WAIT_USLEEP_MIN	90000
+#define LINK_WAIT_USLEEP_MAX	100000
+
 /*
  * Local Management Registers
  */
@@ -221,6 +226,11 @@ enum cdns_pcie_msg_routing {
 	MSG_ROUTING_GATHER,
 };
 
+struct cdns_pcie_plat_data {
+	int (*start_link)(struct cdns_pcie_plat_data *data, bool start);
+	bool (*is_link_up)(struct cdns_pcie_plat_data *data);
+};
+
 /**
  * struct cdns_pcie - private data for Cadence PCIe controller drivers
  * @reg_base: IO mapped register base
@@ -236,6 +246,7 @@ struct cdns_pcie {
 	int			phy_count;
 	struct phy		**phy;
 	struct device_link	**link;
+	struct cdns_pcie_plat_data *plat_data;
 	u32 (*read)(void __iomem *addr, int size);
 	void (*write)(void __iomem *addr, int size, u32 value);
 };
@@ -408,6 +419,8 @@ int cdns_pcie_enable_phy(struct cdns_pcie *pcie);
 int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie);
 u32 cdns_pcie_read32(void __iomem *addr, int size);
 void cdns_pcie_write32(void __iomem *addr, int size, u32 value);
+int cdns_pcie_start_link(struct cdns_pcie *pci, bool start);
+int cdns_pcie_wait_for_link(struct device *dev, struct cdns_pcie *pci);
 extern const struct dev_pm_ops cdns_pcie_pm_ops;
 
 #endif /* _PCIE_CADENCE_H */
-- 
2.17.1

