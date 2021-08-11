Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B543E9183
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 14:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhHKMef (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 08:34:35 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56250 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbhHKMee (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Aug 2021 08:34:34 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17BCXv6o080205;
        Wed, 11 Aug 2021 07:33:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1628685237;
        bh=aNc4udZAXRyrS3hAXEprxS2AyJK0I5nK13MvGZMuHD8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=f/fEnwStUgSBtlAoApddjyNvUUzXr7FQuXxSYnT8V3P8JzWSWSE5iyyFHv9DEGiGY
         pgwi7YU2iD5zQA7WwF7qHsARu6DkfKXIGqTkgojtYFm3w5/qtXSB/G/WyssTMbX6gx
         OPax+u3rB2Vn/H7fYKaQk8YEpgC+N9wxU7pqV9p0=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17BCXvtr009227
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Aug 2021 07:33:57 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 11
 Aug 2021 07:33:57 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 11 Aug 2021 07:33:57 -0500
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17BCXbix083813;
        Wed, 11 Aug 2021 07:33:52 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>, <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Joseph <tjoseph@cadence.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nadeem@cadence.com>
Subject: [PATCH v3 3/5] PCI: j721e: Add PCIe support for J7200
Date:   Wed, 11 Aug 2021 18:03:34 +0530
Message-ID: <20210811123336.31357-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210811123336.31357-1-kishon@ti.com>
References: <20210811123336.31357-1-kishon@ti.com>
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
index 0c5813b230b4..10b13b728284 100644
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
+	pcie->linkdown_irq_regfield = data->linkdown_irq_regfield;
 
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

