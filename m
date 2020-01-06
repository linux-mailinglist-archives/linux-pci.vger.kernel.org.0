Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B91E131037
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 11:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgAFKT0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jan 2020 05:19:26 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55832 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgAFKTZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jan 2020 05:19:25 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 006AJDR0017702;
        Mon, 6 Jan 2020 04:19:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578305953;
        bh=7suyugL6OjEgzVgCAv3ba7IYEsUPuEE1sWxK8qkxVlg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TAmWDGmnM5FjGbuH+suaJlt9fHtbx67AtdGDtOHrE4qhhrrbC3EmJ9qYIZatbLWOj
         JQ1dJj5R6M5FdLoG8kQxtxzZb7ZzK1GPnrt2yhaNvojDDzOr7WlNdVtt9djIW5tY4Q
         2j/jNjyArWiOxhINZKrkkwtLxXt3juOcP+FXFRQs=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 006AJDOS000388
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Jan 2020 04:19:13 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 6 Jan
 2020 04:19:12 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 6 Jan 2020 04:19:12 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 006AIqXv118652;
        Mon, 6 Jan 2020 04:19:09 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Murray <andrew.murray@arm.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 05/14] PCI: cadence: Add support to start link and verify link status
Date:   Mon, 6 Jan 2020 15:50:49 +0530
Message-ID: <20200106102058.19183-6-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106102058.19183-1-kishon@ti.com>
References: <20200106102058.19183-1-kishon@ti.com>
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
 .../pci/controller/cadence/pcie-cadence-ep.c  |  8 +++++
 .../controller/cadence/pcie-cadence-host.c    | 28 +++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h | 30 +++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index d5be81075cc3..26cb492fdb81 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -457,8 +457,10 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
+	struct device *dev = pcie->dev;
 	struct pci_epf *epf;
 	u32 cfg;
+	int ret;
 
 	/*
 	 * BIT(0) is hardwired to 1, hence function 0 is always enabled
@@ -469,6 +471,12 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 		cfg |= BIT(epf->func_no);
 	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, cfg);
 
+	ret = cdns_pcie_start_link(pcie);
+	if (ret) {
+		dev_err(dev, "Failed to start link\n");
+		return ret;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 11eb81da0233..d6a38b74371c 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -3,6 +3,7 @@
 // Cadence PCIe host controller driver.
 // Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
 
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
@@ -200,6 +201,23 @@ static int cdns_pcie_host_init(struct device *dev,
 	return err;
 }
 
+static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
+{
+	struct device *dev = pcie->dev;
+	int retries;
+
+	/* Check if the link is up or not */
+	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
+		if (cdns_pcie_link_up(pcie)) {
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
@@ -253,6 +271,16 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 
 	pcie->mem_res = res;
 
+	ret = cdns_pcie_start_link(pcie);
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
 		return ret;
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 391636a9c084..676a57b7ad3d 100644
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
@@ -227,6 +232,9 @@ enum cdns_pcie_msg_routing {
 struct cdns_pcie_ops {
 	u32	(*read)(void __iomem *addr, int size);
 	void	(*write)(void __iomem *addr, int size, u32 value);
+	int	(*start_link)(struct cdns_pcie *pcie);
+	void	(*stop_link)(struct cdns_pcie *pcie);
+	bool	(*link_up)(struct cdns_pcie *pcie);
 };
 
 /**
@@ -457,6 +465,28 @@ static inline u32 cdns_pcie_ep_fn_readl(struct cdns_pcie *pcie, u8 fn, u32 reg)
 	return readl(addr);
 }
 
+static inline int cdns_pcie_start_link(struct cdns_pcie *pcie)
+{
+	if (pcie->ops->start_link)
+		return pcie->ops->start_link(pcie);
+
+	return 0;
+}
+
+static inline void cdns_pcie_stop_link(struct cdns_pcie *pcie)
+{
+	if (pcie->ops->stop_link)
+		pcie->ops->stop_link(pcie);
+}
+
+static inline bool cdns_pcie_link_up(struct cdns_pcie *pcie)
+{
+	if (pcie->ops->link_up)
+		return pcie->ops->link_up(pcie);
+
+	return true;
+}
+
 #ifdef CONFIG_PCIE_CADENCE_HOST
 int cdns_pcie_host_setup(struct cdns_pcie_rc *rc);
 #else
-- 
2.17.1

