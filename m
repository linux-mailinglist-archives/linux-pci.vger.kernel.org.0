Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6663DE785
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 09:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbhHCHuT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 03:50:19 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55028 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbhHCHuS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Aug 2021 03:50:18 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1737nv2Z010982;
        Tue, 3 Aug 2021 02:49:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1627976997;
        bh=eCzGfldJXeHZ+pi6GylVenVvOeSUkL2zbkaoxGaYenU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ia2XfP93+Q6ftetJGMNXEuBGc+RLatejMivN7w2LtCq8IVStDx7m/Sj4jJa+iSpFf
         HYdzmbn2am8nsjw65KZUajAB3oEbd3wzrqL4GILSl/GZ2PxdFZPmJi3w9CyZkFvzdt
         m89CqvaY8bIUz0SDEVrf9HJtqJA/ImA2lcCmuGII=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1737nvcW024755
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Aug 2021 02:49:57 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 3 Aug
 2021 02:49:56 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 3 Aug 2021 02:49:56 -0500
Received: from a0393678-ssd.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1737nXs0045202;
        Tue, 3 Aug 2021 02:49:52 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>, <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Joseph <tjoseph@cadence.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nadeem@cadence.com>
Subject: [PATCH v2 3/6] PCI: j721e: Add PCIe support for J7200
Date:   Tue, 3 Aug 2021 13:19:29 +0530
Message-ID: <20210803074932.19820-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210803074932.19820-1-kishon@ti.com>
References: <20210803074932.19820-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

J7200 has the same PCIe IP as in J721E with minor changes in the
wrapper. J7200 allows byte access of bridge configuration space
registers and the register field for LINK_DOWN interrupt is different.
J7200 also requires "quirk_detect_quiet_flag" to be set. Configure these
changes as part of driver data applicable only to J7200.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 40 +++++++++++++++++++---
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 0c5813b230b4..8e76f2e7e782 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -27,6 +27,7 @@
 #define STATUS_REG_SYS_2	0x508
 #define STATUS_CLR_REG_SYS_2	0x708
 #define LINK_DOWN		BIT(1)
+#define J7200_LINK_DOWN		BIT(10)
 
 #define J721E_PCIE_USER_CMD_STATUS	0x4
 #define LINK_TRAINING_ENABLE		BIT(0)
@@ -57,6 +58,7 @@ struct j721e_pcie {
 	struct cdns_pcie	*cdns_pcie;
 	void __iomem		*user_cfg_base;
 	void __iomem		*intd_cfg_base;
+	u32			linkdown_irq_regfield;
 };
 
 enum j721e_pcie_mode {
@@ -67,6 +69,9 @@ enum j721e_pcie_mode {
 struct j721e_pcie_data {
 	enum j721e_pcie_mode	mode;
 	unsigned int		quirk_retrain_flag:1;
+	unsigned int		quirk_detect_quiet_flag:1;
+	u32			linkdown_irq_regfield;
+	unsigned int		byte_access_allowed:1;
 };
 
 static inline u32 j721e_pcie_user_readl(struct j721e_pcie *pcie, u32 offset)
@@ -98,12 +103,12 @@ static irqreturn_t j721e_pcie_link_irq_handler(int irq, void *priv)
 	u32 reg;
 
 	reg = j721e_pcie_intd_readl(pcie, STATUS_REG_SYS_2);
-	if (!(reg & LINK_DOWN))
+	if (!(reg & pcie->linkdown_irq_regfield))
 		return IRQ_NONE;
 
 	dev_err(dev, "LINK DOWN!\n");
 
-	j721e_pcie_intd_writel(pcie, STATUS_CLR_REG_SYS_2, LINK_DOWN);
+	j721e_pcie_intd_writel(pcie, STATUS_CLR_REG_SYS_2, pcie->linkdown_irq_regfield);
 	return IRQ_HANDLED;
 }
 
@@ -112,7 +117,7 @@ static void j721e_pcie_config_link_irq(struct j721e_pcie *pcie)
 	u32 reg;
 
 	reg = j721e_pcie_intd_readl(pcie, ENABLE_REG_SYS_2);
-	reg |= LINK_DOWN;
+	reg |= pcie->linkdown_irq_regfield;
 	j721e_pcie_intd_writel(pcie, ENABLE_REG_SYS_2, reg);
 }
 
@@ -284,10 +289,25 @@ static struct pci_ops cdns_ti_pcie_host_ops = {
 static const struct j721e_pcie_data j721e_pcie_rc_data = {
 	.mode = PCI_MODE_RC,
 	.quirk_retrain_flag = true,
+	.byte_access_allowed = false,
+	.linkdown_irq_regfield = LINK_DOWN,
 };
 
 static const struct j721e_pcie_data j721e_pcie_ep_data = {
 	.mode = PCI_MODE_EP,
+	.linkdown_irq_regfield = LINK_DOWN,
+};
+
+static const struct j721e_pcie_data j7200_pcie_rc_data = {
+	.mode = PCI_MODE_RC,
+	.quirk_detect_quiet_flag = true,
+	.linkdown_irq_regfield = J7200_LINK_DOWN,
+	.byte_access_allowed = true,
+};
+
+static const struct j721e_pcie_data j7200_pcie_ep_data = {
+	.mode = PCI_MODE_EP,
+	.quirk_detect_quiet_flag = true,
 };
 
 static const struct of_device_id of_j721e_pcie_match[] = {
@@ -299,6 +319,14 @@ static const struct of_device_id of_j721e_pcie_match[] = {
 		.compatible = "ti,j721e-pcie-ep",
 		.data = &j721e_pcie_ep_data,
 	},
+	{
+		.compatible = "ti,j7200-pcie-host",
+		.data = &j7200_pcie_rc_data,
+	},
+	{
+		.compatible = "ti,j7200-pcie-ep",
+		.data = &j7200_pcie_ep_data,
+	},
 	{},
 };
 
@@ -332,6 +360,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 
 	pcie->dev = dev;
 	pcie->mode = mode;
+	pcie->linkdown_irq_regfield =  data->linkdown_irq_regfield;
 
 	base = devm_platform_ioremap_resource_byname(pdev, "intd_cfg");
 	if (IS_ERR(base))
@@ -391,9 +420,11 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 			goto err_get_sync;
 		}
 
-		bridge->ops = &cdns_ti_pcie_host_ops;
+		if (!data->byte_access_allowed)
+			bridge->ops = &cdns_ti_pcie_host_ops;
 		rc = pci_host_bridge_priv(bridge);
 		rc->quirk_retrain_flag = data->quirk_retrain_flag;
+		rc->quirk_detect_quiet_flag = data->quirk_detect_quiet_flag;
 
 		cdns_pcie = &rc->pcie;
 		cdns_pcie->dev = dev;
@@ -459,6 +490,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 			ret = -ENOMEM;
 			goto err_get_sync;
 		}
+		ep->quirk_detect_quiet_flag = data->quirk_detect_quiet_flag;
 
 		cdns_pcie = &ep->pcie;
 		cdns_pcie->dev = dev;
-- 
2.17.1

