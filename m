Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6204B07C5
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 09:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbiBJIKF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 03:10:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237009AbiBJIKD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 03:10:03 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87006B80;
        Thu, 10 Feb 2022 00:10:04 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 10 Feb 2022 17:10:03 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id CFBBA2083C4C;
        Thu, 10 Feb 2022 17:10:03 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 10 Feb 2022 17:10:03 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 1C0A0C1E23;
        Thu, 10 Feb 2022 17:10:03 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 2/3] PCI: uniphier-ep: Add SoC data structure
Date:   Thu, 10 Feb 2022 17:09:55 +0900
Message-Id: <1644480596-20037-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644480596-20037-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1644480596-20037-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Define SoC data structure that includes pci_epc_features, SoC-dependent
callback functions and flags to distinguish the behavior of each SoC.
The callback functions define init() to initialize the controller and
wait() to wait until initialization is completed.

Rename uniphier_pcie_init_ep() to uniphier_pcie_pro5_init_ep() for
initializing PCIe controller implemented in Pro5 SoC. And Pro5 SoC
doesn't have wait() function.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/pci/controller/dwc/pcie-uniphier-ep.c | 61 ++++++++++++++++++---------
 1 file changed, 42 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
index 69810c6b0d58..6c035fc45aaa 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
@@ -60,7 +60,14 @@ struct uniphier_pcie_ep_priv {
 	struct clk *clk, *clk_gio;
 	struct reset_control *rst, *rst_gio;
 	struct phy *phy;
-	const struct pci_epc_features *features;
+	const struct uniphier_pcie_ep_soc_data *data;
+};
+
+struct uniphier_pcie_ep_soc_data {
+	bool has_gio;
+	void (*init)(struct uniphier_pcie_ep_priv *priv);
+	int (*wait)(struct uniphier_pcie_ep_priv *priv);
+	const struct pci_epc_features features;
 };
 
 #define to_uniphier_pcie(x)	dev_get_drvdata((x)->dev)
@@ -91,7 +98,7 @@ static void uniphier_pcie_phy_reset(struct uniphier_pcie_ep_priv *priv,
 	writel(val, priv->base + PCL_RSTCTRL2);
 }
 
-static void uniphier_pcie_init_ep(struct uniphier_pcie_ep_priv *priv)
+static void uniphier_pcie_pro5_init_ep(struct uniphier_pcie_ep_priv *priv)
 {
 	u32 val;
 
@@ -209,7 +216,7 @@ uniphier_pcie_get_features(struct dw_pcie_ep *ep)
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct uniphier_pcie_ep_priv *priv = to_uniphier_pcie(pci);
 
-	return priv->features;
+	return &priv->data->features;
 }
 
 static const struct dw_pcie_ep_ops uniphier_pcie_ep_ops = {
@@ -238,7 +245,8 @@ static int uniphier_pcie_ep_enable(struct uniphier_pcie_ep_priv *priv)
 	if (ret)
 		goto out_rst_assert;
 
-	uniphier_pcie_init_ep(priv);
+	if (priv->data->init)
+		priv->data->init(priv);
 
 	uniphier_pcie_phy_reset(priv, true);
 
@@ -248,8 +256,16 @@ static int uniphier_pcie_ep_enable(struct uniphier_pcie_ep_priv *priv)
 
 	uniphier_pcie_phy_reset(priv, false);
 
+	if (priv->data->wait) {
+		ret = priv->data->wait(priv);
+		if (ret)
+			goto out_phy_exit;
+	}
+
 	return 0;
 
+out_phy_exit:
+	phy_exit(priv->phy);
 out_rst_gio_assert:
 	reset_control_assert(priv->rst_gio);
 out_rst_assert:
@@ -277,8 +293,8 @@ static int uniphier_pcie_ep_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->features = of_device_get_match_data(dev);
-	if (WARN_ON(!priv->features))
+	priv->data = of_device_get_match_data(dev);
+	if (WARN_ON(!priv->data))
 		return -EINVAL;
 
 	priv->pci.dev = dev;
@@ -288,13 +304,15 @@ static int uniphier_pcie_ep_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	priv->clk_gio = devm_clk_get(dev, "gio");
-	if (IS_ERR(priv->clk_gio))
-		return PTR_ERR(priv->clk_gio);
+	if (priv->data->has_gio) {
+		priv->clk_gio = devm_clk_get(dev, "gio");
+		if (IS_ERR(priv->clk_gio))
+			return PTR_ERR(priv->clk_gio);
 
-	priv->rst_gio = devm_reset_control_get_shared(dev, "gio");
-	if (IS_ERR(priv->rst_gio))
-		return PTR_ERR(priv->rst_gio);
+		priv->rst_gio = devm_reset_control_get_shared(dev, "gio");
+		if (IS_ERR(priv->rst_gio))
+			return PTR_ERR(priv->rst_gio);
+	}
 
 	priv->clk = devm_clk_get(dev, "link");
 	if (IS_ERR(priv->clk))
@@ -321,13 +339,18 @@ static int uniphier_pcie_ep_probe(struct platform_device *pdev)
 	return dw_pcie_ep_init(&priv->pci.ep);
 }
 
-static const struct pci_epc_features uniphier_pro5_data = {
-	.linkup_notifier = false,
-	.msi_capable = true,
-	.msix_capable = false,
-	.align = 1 << 16,
-	.bar_fixed_64bit = BIT(BAR_0) | BIT(BAR_2) | BIT(BAR_4),
-	.reserved_bar =  BIT(BAR_4),
+static const struct uniphier_pcie_ep_soc_data uniphier_pro5_data = {
+	.has_gio = true,
+	.init = uniphier_pcie_pro5_init_ep,
+	.wait = NULL,
+	.features = {
+		.linkup_notifier = false,
+		.msi_capable = true,
+		.msix_capable = false,
+		.align = 1 << 16,
+		.bar_fixed_64bit = BIT(BAR_0) | BIT(BAR_2) | BIT(BAR_4),
+		.reserved_bar =  BIT(BAR_4),
+	},
 };
 
 static const struct of_device_id uniphier_pcie_ep_match[] = {
-- 
2.7.4

