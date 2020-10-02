Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A859280CEB
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 06:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgJBEtD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 00:49:03 -0400
Received: from mx.socionext.com ([202.248.49.38]:24379 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbgJBEtC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Oct 2020 00:49:02 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 02 Oct 2020 13:49:00 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id B9A9D180B3C;
        Fri,  2 Oct 2020 13:49:00 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 2 Oct 2020 13:49:00 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 1A2741A0509;
        Fri,  2 Oct 2020 13:49:00 +0900 (JST)
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
Subject: [PATCH 3/3] PCI: uniphier-ep: Add EPC restart management support
Date:   Fri,  2 Oct 2020 13:48:47 +0900
Message-Id: <1601614127-13837-4-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601614127-13837-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1601614127-13837-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Set the polling function and call the init function to enable EPC restart
management. The polling function detects that the bus-reset signal is a
rising edge.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/pci/controller/dwc/Kconfig            |  1 +
 drivers/pci/controller/dwc/pcie-uniphier-ep.c | 34 +++++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index bc04986..4932095 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -296,6 +296,7 @@ config PCIE_UNIPHIER_EP
 	depends on OF && HAS_IOMEM
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
+	select PCI_ENDPOINT_RESTART
 	help
 	  Say Y here if you want PCIe endpoint controller support on
 	  UniPhier SoCs. This driver supports Pro5 SoC.
diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
index 1483559..bd187b1 100644
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
 
@@ -218,6 +220,23 @@ static const struct dw_pcie_ep_ops uniphier_pcie_ep_ops = {
 	.get_features = uniphier_pcie_get_features,
 };
 
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
 static int uniphier_add_pcie_ep(struct uniphier_pcie_ep_priv *priv,
 				struct platform_device *pdev)
 {
@@ -241,10 +260,21 @@ static int uniphier_add_pcie_ep(struct uniphier_pcie_ep_priv *priv,
 	ep->addr_size = resource_size(res);
 
 	ret = dw_pcie_ep_init(ep);
-	if (ret)
+	if (ret) {
 		dev_err(dev, "Failed to initialize endpoint (%d)\n", ret);
+		return ret;
+	}
 
-	return ret;
+	/* Set up epc-restart thread */
+	pci_epc_restart_register_poll_func(ep->epc,
+					    uniphier_pcie_ep_poll_reset, priv);
+	/* With call of poll_reset() directly, initialize internal state */
+	uniphier_pcie_ep_poll_reset(priv);
+	ret = pci_epc_restart_init(ep->epc);
+	if (ret)
+		dev_err(dev, "Failed to initialize epc-restart (%d)\n", ret);
+
+	return 0;
 }
 
 static int uniphier_pcie_ep_enable(struct uniphier_pcie_ep_priv *priv)
-- 
2.7.4

