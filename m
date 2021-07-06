Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7413BCAEA
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jul 2021 12:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbhGFKxn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jul 2021 06:53:43 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42010 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbhGFKxk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jul 2021 06:53:40 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 166AooCs059832;
        Tue, 6 Jul 2021 05:50:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1625568650;
        bh=mqWdVCqUdGTrF/47tUIgHoFfn1zQjqo9buKQFb0roTY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SWuAmclg9XLfB8afMolrGevdB8wYiCq72tv15DPgeg6l6eEUQGVEUJErcsxvy8yg6
         uuGcta+rR9dFdVRGEga1griOtuWid7oabyJGaHKSwKjaWVysdMVbNF+9Zw91vimVzj
         lB5X6RGe/U80LhgVtHMUvohwzW2elcsQ22rjqpco=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 166AooXX126072
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Jul 2021 05:50:50 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 6 Jul
 2021 05:50:50 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 6 Jul 2021 05:50:50 -0500
Received: from a0393678-ssd.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 166Aoar3015822;
        Tue, 6 Jul 2021 05:50:46 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Joseph <tjoseph@cadence.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Nadeem Athani <nadeem@cadence.com>
Subject: [PATCH 2/5] PCI: j721e: Add PCIe support for J7200
Date:   Tue, 6 Jul 2021 16:20:32 +0530
Message-ID: <20210706105035.9915-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210706105035.9915-1-kishon@ti.com>
References: <20210706105035.9915-1-kishon@ti.com>
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
 drivers/pci/controller/cadence/pci-j721e.c | 44 ++++++++++++++++++++--
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 35e61048e133..803da33b86d8 100644
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
+	u32			link_irq_reg_field;
 };
 
 enum j721e_pcie_mode {
@@ -67,6 +69,9 @@ enum j721e_pcie_mode {
 struct j721e_pcie_data {
 	enum j721e_pcie_mode	mode;
 	bool quirk_retrain_flag;
+	bool			quirk_detect_quiet_flag;
+	u32			link_irq_reg_field;
+	bool			byte_access_allowed;
 };
 
 static inline u32 j721e_pcie_user_readl(struct j721e_pcie *pcie, u32 offset)
@@ -98,12 +103,12 @@ static irqreturn_t j721e_pcie_link_irq_handler(int irq, void *priv)
 	u32 reg;
 
 	reg = j721e_pcie_intd_readl(pcie, STATUS_REG_SYS_2);
-	if (!(reg & LINK_DOWN))
+	if (!(reg & pcie->link_irq_reg_field))
 		return IRQ_NONE;
 
 	dev_err(dev, "LINK DOWN!\n");
 
-	j721e_pcie_intd_writel(pcie, STATUS_CLR_REG_SYS_2, LINK_DOWN);
+	j721e_pcie_intd_writel(pcie, STATUS_CLR_REG_SYS_2, pcie->link_irq_reg_field);
 	return IRQ_HANDLED;
 }
 
@@ -112,7 +117,7 @@ static void j721e_pcie_config_link_irq(struct j721e_pcie *pcie)
 	u32 reg;
 
 	reg = j721e_pcie_intd_readl(pcie, ENABLE_REG_SYS_2);
-	reg |= LINK_DOWN;
+	reg |= pcie->link_irq_reg_field;
 	j721e_pcie_intd_writel(pcie, ENABLE_REG_SYS_2, reg);
 }
 
@@ -284,10 +289,25 @@ static struct pci_ops cdns_ti_pcie_host_ops = {
 static const struct j721e_pcie_data j721e_pcie_rc_data = {
 	.mode = PCI_MODE_RC,
 	.quirk_retrain_flag = true,
+	.byte_access_allowed = false,
+	.link_irq_reg_field = LINK_DOWN,
 };
 
 static const struct j721e_pcie_data j721e_pcie_ep_data = {
 	.mode = PCI_MODE_EP,
+	.link_irq_reg_field = LINK_DOWN,
+};
+
+static const struct j721e_pcie_data j7200_pcie_rc_data = {
+	.mode = PCI_MODE_RC,
+	.quirk_detect_quiet_flag = true,
+	.link_irq_reg_field = J7200_LINK_DOWN,
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
 
@@ -309,10 +337,12 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	struct pci_host_bridge *bridge;
 	struct j721e_pcie_data *data;
 	struct cdns_pcie *cdns_pcie;
+	bool byte_access_allowed;
 	struct j721e_pcie *pcie;
 	struct cdns_pcie_rc *rc;
 	struct cdns_pcie_ep *ep;
 	struct gpio_desc *gpiod;
+	u32 link_irq_reg_field;
 	void __iomem *base;
 	struct clk *clk;
 	u32 num_lanes;
@@ -325,6 +355,8 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	mode = (u32)data->mode;
+	byte_access_allowed = data->byte_access_allowed;
+	link_irq_reg_field = data->link_irq_reg_field;
 
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
@@ -332,6 +364,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 
 	pcie->dev = dev;
 	pcie->mode = mode;
+	pcie->link_irq_reg_field = link_irq_reg_field;
 
 	base = devm_platform_ioremap_resource_byname(pdev, "intd_cfg");
 	if (IS_ERR(base))
@@ -391,9 +424,11 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 			goto err_get_sync;
 		}
 
-		bridge->ops = &cdns_ti_pcie_host_ops;
+		if (!byte_access_allowed)
+			bridge->ops = &cdns_ti_pcie_host_ops;
 		rc = pci_host_bridge_priv(bridge);
 		rc->quirk_retrain_flag = data->quirk_retrain_flag;
+		rc->quirk_detect_quiet_flag = data->quirk_detect_quiet_flag;
 
 		cdns_pcie = &rc->pcie;
 		cdns_pcie->dev = dev;
@@ -459,6 +494,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 			ret = -ENOMEM;
 			goto err_get_sync;
 		}
+		ep->quirk_detect_quiet_flag = data->quirk_detect_quiet_flag;
 
 		cdns_pcie = &ep->pcie;
 		cdns_pcie->dev = dev;
-- 
2.17.1

