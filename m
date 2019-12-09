Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2096C116913
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2019 10:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfLIJVE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Dec 2019 04:21:04 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59874 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfLIJVE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2019 04:21:04 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB99KuVN045988;
        Mon, 9 Dec 2019 03:20:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575883256;
        bh=OzxHiwIOPUOFBA7qrD6Vb+QLFWB9Mt5CRNKBBT7ftNQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=zMp0dskhFl7i6gKryWLdosqPB/ECwjUPm/lXAmyQ7JJb5FWW8Fe5fubmhJlEE3wwd
         gt0uezj7i0l19EVK6rx56mmikUauYQcdDWiNrgzoWd5yLECaWE2Ugj6S7WeyWp+K+F
         GRTsJs0Fc12wo6xh1WLi4RYFdk+cQhjGB1xTmf+Y=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB99KutT063290
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Dec 2019 03:20:56 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Dec
 2019 03:20:55 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Dec 2019 03:20:55 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB99Kcd2087697;
        Mon, 9 Dec 2019 03:20:52 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Murray <andrew.murray@arm.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 04/13] PCI: cadence: Add support to start link and verify link status
Date:   Mon, 9 Dec 2019 14:51:38 +0530
Message-ID: <20191209092147.22901-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209092147.22901-1-kishon@ti.com>
References: <20191209092147.22901-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add cdns_pcie_ops to start link and verify link status. The registers
to start link and to check link status is in Platform specific PCIe
wrapper. Add support for platform specific drivers to add callback
functions for the PCIe Cadence core to start link and verify link status.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../pci/controller/cadence/pcie-cadence-ep.c  |  8 ++++++
 .../controller/cadence/pcie-cadence-host.c    | 28 +++++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h | 23 +++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 560f22b4d165..088394b6be04 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -355,8 +355,10 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
+	struct device *dev = pcie->dev;
 	struct pci_epf *epf;
 	u32 cfg;
+	int ret;
 
 	/*
 	 * BIT(0) is hardwired to 1, hence function 0 is always enabled
@@ -367,6 +369,12 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 		cfg |= BIT(epf->func_no);
 	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, cfg);
 
+	ret = cdns_pcie_start_link(pcie, true);
+	if (ret) {
+		dev_err(dev, "Failed to start link\n");
+		return ret;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index ccf55e143e1d..0929554f5a81 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -3,6 +3,7 @@
 // Cadence PCIe host controller driver.
 // Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
 
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
@@ -201,6 +202,23 @@ static int cdns_pcie_host_init(struct device *dev,
 	return err;
 }
 
+static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
+{
+	struct device *dev = pcie->dev;
+	int retries;
+
+	/* Check if the link is up or not */
+	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
+		if (cdns_pcie_is_link_up(pcie)) {
+			dev_info(dev, "Link up\n");
+			return 0;
+		}
+		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
+	}
+
+	return -ETIMEDOUT;
+}
+
 int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 {
 	struct device *dev = rc->pcie.dev;
@@ -254,6 +272,16 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 
 	pcie->mem_res = res;
 
+	ret = cdns_pcie_start_link(pcie, true);
+	if (ret) {
+		dev_err(dev, "Failed to start link\n");
+		return ret;
+	}
+
+	ret = cdns_pcie_host_wait_for_link(pcie);
+	if (ret)
+		dev_dbg(dev, "PCIe link never came up\n");
+
 	ret = cdns_pcie_host_init(dev, &resources, rc);
 	if (ret)
 		goto err_init;
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index d0d91c69fa1d..f0395eaf9df5 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
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
@@ -226,6 +231,8 @@ enum cdns_pcie_msg_routing {
 struct cdns_pcie_ops {
 	u32	(*read)(void __iomem *addr, int size);
 	void	(*write)(void __iomem *addr, int size, u32 value);
+	int	(*start_link)(struct cdns_pcie *pcie, bool start);
+	bool	(*is_link_up)(struct cdns_pcie *pcie);
 };
 
 /**
@@ -447,6 +454,22 @@ static inline u32 cdns_pcie_ep_fn_readl(struct cdns_pcie *pcie, u8 fn, u32 reg)
 	return readl(addr);
 }
 
+static inline int cdns_pcie_start_link(struct cdns_pcie *pcie, bool start)
+{
+	if (pcie->ops->start_link)
+		return pcie->ops->start_link(pcie, start);
+
+	return 0;
+}
+
+static inline bool cdns_pcie_is_link_up(struct cdns_pcie *pcie)
+{
+	if (pcie->ops->is_link_up)
+		return pcie->ops->is_link_up(pcie);
+
+	return true;
+}
+
 #ifdef CONFIG_PCIE_CADENCE_HOST
 int cdns_pcie_host_setup(struct cdns_pcie_rc *rc);
 #else
-- 
2.17.1

