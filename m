Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067D7301D03
	for <lists+linux-pci@lfdr.de>; Sun, 24 Jan 2021 16:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbhAXPLi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Jan 2021 10:11:38 -0500
Received: from mx.socionext.com ([202.248.49.38]:26509 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbhAXPLP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 24 Jan 2021 10:11:15 -0500
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 25 Jan 2021 00:09:46 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 1EB7A2059027;
        Mon, 25 Jan 2021 00:09:46 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 25 Jan 2021 00:09:46 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id D3FE2B1D40;
        Mon, 25 Jan 2021 00:09:45 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 3/3] PCI: uniphier-ep: Add EPC restart management support
Date:   Mon, 25 Jan 2021 00:09:37 +0900
Message-Id: <1611500977-24816-4-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611500977-24816-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1611500977-24816-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Set the polling function and call the init function to enable EPC restart
management. The polling function detects that the bus-reset signal is a
rising edge.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/pci/controller/dwc/Kconfig            |  1 +
 drivers/pci/controller/dwc/pcie-uniphier-ep.c | 44 ++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 22c5529..90d400a 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -302,6 +302,7 @@ config PCIE_UNIPHIER_EP
 	depends on OF && HAS_IOMEM
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
+	select PCI_ENDPOINT_RESTART
 	help
 	  Say Y here if you want PCIe endpoint controller support on
 	  UniPhier SoCs. This driver supports Pro5 SoC.
diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
index 69810c6..9d83850 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
@@ -26,6 +26,7 @@
 #define PCL_RSTCTRL_PIPE3		BIT(0)
 
 #define PCL_RSTCTRL1			0x0020
+#define PCL_RSTCTRL_PERST_MON		BIT(16)
 #define PCL_RSTCTRL_PERST		BIT(0)
 
 #define PCL_RSTCTRL2			0x0024
@@ -60,6 +61,7 @@ struct uniphier_pcie_ep_priv {
 	struct clk *clk, *clk_gio;
 	struct reset_control *rst, *rst_gio;
 	struct phy *phy;
+	bool bus_reset_status;
 	const struct pci_epc_features *features;
 };
 
@@ -212,6 +214,41 @@ uniphier_pcie_get_features(struct dw_pcie_ep *ep)
 	return priv->features;
 }
 
+static bool uniphier_pcie_ep_poll_reset(void *data)
+{
+	struct uniphier_pcie_ep_priv *priv = data;
+	bool ret, status;
+
+	if (!priv)
+		return false;
+
+	status = !(readl(priv->base + PCL_RSTCTRL1) & PCL_RSTCTRL_PERST_MON);
+
+	/* return true if the rising edge of bus reset is detected */
+	ret = !!(status == false && priv->bus_reset_status == true);
+	priv->bus_reset_status = status;
+
+	return ret;
+}
+
+static int uniphier_pcie_ep_init_complete(struct dw_pcie_ep *ep)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct uniphier_pcie_ep_priv *priv = to_uniphier_pcie(pci);
+	int ret;
+
+	/* Set up epc-restart thread */
+	pci_epc_restart_register_poll_func(ep->epc,
+					    uniphier_pcie_ep_poll_reset, priv);
+	/* With call of poll_reset() directly, initialize internal state */
+	uniphier_pcie_ep_poll_reset(priv);
+	ret = pci_epc_restart_init(ep->epc);
+	if (ret)
+		dev_err(pci->dev, "Failed to initialize epc-restart (%d)\n", ret);
+
+	return ret;
+}
+
 static const struct dw_pcie_ep_ops uniphier_pcie_ep_ops = {
 	.ep_init = uniphier_pcie_ep_init,
 	.raise_irq = uniphier_pcie_ep_raise_irq,
@@ -318,7 +355,12 @@ static int uniphier_pcie_ep_probe(struct platform_device *pdev)
 		return ret;
 
 	priv->pci.ep.ops = &uniphier_pcie_ep_ops;
-	return dw_pcie_ep_init(&priv->pci.ep);
+
+	ret = dw_pcie_ep_init(&priv->pci.ep);
+	if (ret)
+		return ret;
+
+	return uniphier_pcie_ep_init_complete(&priv->pci.ep);
 }
 
 static const struct pci_epc_features uniphier_pro5_data = {
-- 
2.7.4

